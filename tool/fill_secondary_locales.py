#!/usr/bin/env python3
"""Fill missing keys in non-English ARB files (template: app_en.arb).

- Handcrafted ICU plural strings (Google Translate breaks ICU keywords).
- Google Translate for simpler strings; falls back to English on failure.
Requires: .venv with `deep-translator` (see project setup).

Usage:
  tool/fill_secondary_locales.py           # all locales
  tool/fill_secondary_locales.py fr es      # only listed locale stems
"""

from __future__ import annotations

import json
import re
import sys
import time
from pathlib import Path

# Smaller batches are less likely to hang on free Google endpoints.
_BATCH_CHUNK = 15

ROOT = Path(__file__).resolve().parents[1]
L10N = ROOT / "lib" / "l10n"

# Maps app file stem (without app_) -> deep_translator Google target code
LANG_GOOGLE = {
    "de": "de",
    "fr": "fr",
    "es": "es",
    "pt": "pt",
    "ja": "ja",
    "ko": "ko",
    "zh": "zh-CN",
    "hi": "hi",
    "ar": "ar",
    "ur": "ur",
}

# ICU plural / select strings must not go through machine translation.
HARDCODED: dict[str, dict[str, str]] = {
    "de": {
        "currentCreditsDescription": (
            "{count, plural, =1{Für dieses Skript haben Sie noch 1 kostenlose Aufnahme.} "
            "other{Für dieses Skript haben Sie noch {count} kostenlose Aufnahmen.}}"
        ),
        "freeRecordingsLeft": (
            "{count, plural, =1{Noch 1 kostenlose Aufnahme} other{Noch {count} kostenlose Aufnahmen}}"
        ),
        "recordingsRemainingHint": (
            "{count, plural, =1{Noch 1 Aufnahme verfügbar} other{Noch {count} Aufnahmen verfügbar}} · "
            "Mehr durch Anzeige erhalten"
        ),
    },
    "fr": {
        "currentCreditsDescription": (
            "{count, plural, =1{Il vous reste 1 enregistrement gratuit pour ce script.} "
            "other{Il vous reste {count} enregistrements gratuits pour ce script.}}"
        ),
        "freeRecordingsLeft": (
            "{count, plural, =1{Il reste 1 enregistrement gratuit} "
            "other{Il reste {count} enregistrements gratuits}}"
        ),
        "recordingsRemainingHint": (
            "{count, plural, =1{Il reste 1 enregistrement} other{Il reste {count} enregistrements}} · "
            "Regardez une pub pour en obtenir plus"
        ),
    },
    "es": {
        "currentCreditsDescription": (
            "{count, plural, =1{Te queda 1 grabación gratis para este guion.} "
            "other{Te quedan {count} grabaciones gratis para este guion.}}"
        ),
        "freeRecordingsLeft": (
            "{count, plural, =1{Queda 1 grabación gratis} other{Quedan {count} grabaciones gratis}}"
        ),
        "recordingsRemainingHint": (
            "{count, plural, =1{Queda 1 grabación} other{Quedan {count} grabaciones}} · "
            "Mira un anuncio para obtener más"
        ),
    },
    "pt": {
        "currentCreditsDescription": (
            "{count, plural, =1{Você tem 1 gravação gratuita restante neste roteiro.} "
            "other{Você tem {count} gravações gratuitas restantes neste roteiro.}}"
        ),
        "freeRecordingsLeft": (
            "{count, plural, =1{Resta 1 gravação gratuita} other{Restam {count} gravações gratuitas}}"
        ),
        "recordingsRemainingHint": (
            "{count, plural, =1{Resta 1 gravação} other{Restam {count} gravações}} · "
            "Assista a um anúncio para obter mais"
        ),
    },
    "ja": {
        "currentCreditsDescription": (
            "{count, plural, =1{このスクリプトの無料録画はあと1回分あります。} "
            "other{このスクリプトの無料録画はあと{count}回分あります。}}"
        ),
        "freeRecordingsLeft": (
            "{count, plural, =1{無料録画の残り1回} other{無料録画の残り{count}回}}"
        ),
        "recordingsRemainingHint": (
            "{count, plural, =1{録画権利があと1回} other{録画権利があと{count}回}} · "
            "広告を見て追加をゲット"
        ),
    },
    "ko": {
        "currentCreditsDescription": (
            "{count, plural, =1{이 스크립트에 무료 녹화 1회가 남았습니다.} "
            "other{이 스크립트에 무료 녹화가 {count}회 남았습니다.}}"
        ),
        "freeRecordingsLeft": (
            "{count, plural, =1{무료 녹화 1회 남음} other{무료 녹화 {count}회 남음}}"
        ),
        "recordingsRemainingHint": (
            "{count, plural, =1{녹화 횟수 1회 남음} other{녹화 횟수 {count}회 남음}} · "
            "광고를 시청해 더 받기"
        ),
    },
    "zh": {
        "currentCreditsDescription": (
            "{count, plural, =1{该脚本还剩 1 次免费录像。} other{该脚本还剩 {count} 次免费录像。}}"
        ),
        "freeRecordingsLeft": "{count, plural, =1{还剩 1 次免费录像} other{还剩 {count} 次免费录像}}",
        "recordingsRemainingHint": "{count, plural, =1{还剩 1 次录像} other{还剩 {count} 次录像}} · 观看广告获取更多",
    },
    "hi": {
        "currentCreditsDescription": (
            "{count, plural, =1{इस स्क्रिप्ट के लिए आपके पास 1 मुफ्त रिकॉर्डिंग बची है।} "
            "other{इस स्क्रिप्ट के लिए आपके पास {count} मुफ्त रिकॉर्डिंगें बची हैं।}}"
        ),
        "freeRecordingsLeft": (
            "{count, plural, =1{1 मुफ्त रिकॉर्डिंग शेष} other{{count} मुफ्त रिकॉर्डिंगें शेष}}"
        ),
        "recordingsRemainingHint": (
            "{count, plural, =1{1 रिकॉर्डिंग शेष} other{{count} रिकॉर्डिंगें शेष}} · और पाने के लिए विज्ञापन देखें"
        ),
    },
}

HARDCODED["ar"] = {
    "currentCreditsDescription": (
        "{count, plural, =1{يتبقى لك تسجيل مجاني واحد لهذا النص.} "
        "other{يتبقى لك {count} تسجيلات مجانية لهذا النص.}}"
    ),
    "freeRecordingsLeft": (
        "{count, plural, =1{لا يزال هناك تسجيل مجاني واحد} other{لا يزال هناك {count} تسجيلات مجانية}}"
    ),
    "recordingsRemainingHint": (
        "{count, plural, =1{تبقّى تسجيل واحد} other{تبقّى {count} تسجيلات}} · شاهِد إعلانًا للمزيد"
    ),
}

HARDCODED["ur"] = {
    "currentCreditsDescription": (
        "{count, plural, =1{اس اسکرپٹ کے لیے آپ کو 1 مفت ریکارڈنگ بقیہ ہے۔} "
        "other{اس اسکرپٹ کے لیے آپ کو {count} مفت ریکارڈنگز بقیہ ہیں۔}}"
    ),
    "freeRecordingsLeft": (
        "{count, plural, =1{1 مفت ریکارڈنگ باقی} other{{count} مفت ریکارڈنگز باقی}}"
    ),
    "recordingsRemainingHint": (
        "{count, plural, =1{1 ریکارڈنگ باقی} other{{count} ریکارڈنگز باقی}} · مزید حاصل کرنے کے لیے اشتہار دیکھیں"
    ),
}


def brace_balance(s: str) -> tuple[int, int]:
    return s.count("{"), s.count("}")


def _simple_placeholder_names(en_s: str) -> list[str] | None:
    """Return placeholder names only if EN uses simple `{name}` groups (no plural/select)."""
    if not isinstance(en_s, str):
        return None
    if "plural" in en_s or "select," in en_s:
        return None
    if re.search(r"\{count,\s*plural", en_s):
        return None
    names = re.findall(r"\{([a-zA-Z_][a-zA-Z0-9_]*)\}", en_s)
    groups = re.findall(r"\{[^}]+\}", en_s)
    if len(groups) != len(names):
        return None
    for g, n in zip(groups, names):
        if g != "{" + n + "}":
            return None
    return names


def fix_placeholder_names(en_s: str, loc_s: str) -> str:
    """MT often renames `{error}` → localized identifier; ICU requires ASCII names."""
    names = _simple_placeholder_names(en_s)
    if not names or not isinstance(loc_s, str):
        return loc_s
    loc_groups = re.findall(r"\{[^}]+\}", loc_s)
    if len(loc_groups) != len(names):
        return loc_s
    out = loc_s
    for bad, n in zip(loc_groups, names):
        out = out.replace(bad, "{" + n + "}", 1)
    return out


def load_json(path: Path) -> dict:
    return json.loads(path.read_text(encoding="utf-8"))


def save_arb(path: Path, data: dict) -> None:
    keys_sorted = sorted(
        data.keys(),
        key=lambda k: (k != "@@locale", k.lstrip("@").lower(), k.startswith("@")),
    )
    ordered = {k: data[k] for k in keys_sorted}
    path.write_text(json.dumps(ordered, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


def missing_string_keys(en: dict, loc: dict) -> list[str]:
    en_k = {k for k in en if k != "@@locale" and not k.startswith("@")}
    lk = {k for k in loc if k != "@@locale" and not k.startswith("@")}
    return sorted(en_k - lk)


def main() -> None:
    try:
        from deep_translator import GoogleTranslator
    except ImportError as e:
        raise SystemExit(
            "Install deep-translator in .venv: python3 -m venv .venv && "
            ".venv/bin/pip install deep-translator"
        ) from e

    en_path = L10N / "app_en.arb"
    en = load_json(en_path)

    argv_norm = {x.strip().lower() for x in sys.argv[1:] if x.strip()}

    langs = list(LANG_GOOGLE.items())
    if argv_norm:
        langs = [(s, g) for s, g in langs if s in argv_norm]
        if not langs:
            print("No matching locales in argv. Known:", ", ".join(sorted(LANG_GOOGLE)))
            return

    for stem, gtarget in langs:
        path = L10N / f"app_{stem}.arb"
        if not path.exists():
            print("skip missing", path.name)
            continue

        loc = load_json(path)
        missing = missing_string_keys(en, loc)
        if not missing:
            print(stem, "complete", flush=True)
            continue

        print(f"{stem}: translating {len(missing)} missing keys...", flush=True)
        tr = GoogleTranslator(source="en", target=gtarget)
        hard = HARDCODED.get(stem, {})

        to_translate: list[tuple[str, str]] = []
        for key in missing:
            src = en.get(key)
            if not isinstance(src, str):
                continue

            if key in hard:
                loc[key] = hard[key]
                continue

            to_translate.append((key, src))

        for chunk_start in range(0, len(to_translate), _BATCH_CHUNK):
            chunk = to_translate[chunk_start : chunk_start + _BATCH_CHUNK]
            keys_chunk = [k for k, _ in chunk]
            texts = [text for _, text in chunk]
            bn = chunk_start // _BATCH_CHUNK + 1
            bt = (len(to_translate) + _BATCH_CHUNK - 1) // _BATCH_CHUNK
            print(f"  {stem} batch {bn}/{bt} ({len(keys_chunk)} strings)...", flush=True)

            outs: list[str] = []
            try:
                outs = list(tr.translate_batch(texts))
            except Exception:
                outs = []

            if len(outs) != len(keys_chunk):
                outs = []
                for _, text in chunk:
                    try:
                        outs.append(tr.translate(text))
                        time.sleep(0.06)
                    except Exception:
                        outs.append(text)

            for idx, key in enumerate(keys_chunk):
                src = texts[idx]
                out = outs[idx] if idx < len(outs) else src
                if brace_balance(out) != brace_balance(src):
                    out = src
                out = fix_placeholder_names(src, out)
                loc[key] = out

            time.sleep(0.45)

        for k, loc_v in list(loc.items()):
            if k.startswith("@") or k == "@@locale":
                continue
            ev = en.get(k)
            if not isinstance(ev, str) or not isinstance(loc_v, str):
                continue
            nv = fix_placeholder_names(ev, loc_v)
            if nv != loc_v:
                loc[k] = nv

        save_arb(path, loc)
        print(f"{stem}: saved ({len(missing)} keys checked)", flush=True)


if __name__ == "__main__":
    main()
