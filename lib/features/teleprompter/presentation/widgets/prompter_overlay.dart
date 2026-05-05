import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_6/generated/l10n/app_localizations.dart';
import '../../../../core/utils/responsive_config.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../settings/presentation/providers/ui_provider.dart';
import '../../../../core/services/analytics_service.dart';
import '../../../premium/presentation/providers/premium_provider.dart';
import '../../../premium/presentation/screen/premium_screen.dart';
import '../../../../core/utils/toast_service.dart';

TextStyle _applyFontFamily(TextStyle base, String family) {
  switch (family) {
    case 'Manrope':
      return GoogleFonts.manrope(textStyle: base);
    case 'Roboto Mono':
      return GoogleFonts.robotoMono(textStyle: base);
    case 'Playfair Display':
      return GoogleFonts.playfairDisplay(textStyle: base);
    case 'Oswald':
      return GoogleFonts.oswald(textStyle: base);
    case 'Lato':
      return GoogleFonts.lato(textStyle: base);
    default:
      return base;
  }
}

class PrompterOverlay extends StatelessWidget {
  final String scriptContent;
  final bool isPlayingScript;
  final bool showScriptControls;
  final bool showSettingsPanel;
  final double dragX;
  final double dragY;
  final ValueNotifier<Size> prompterSize;
  final ValueNotifier<double> prompterOpacity;
  final ValueNotifier<double> fontSize;
  final ValueNotifier<int> textOrientation;
  final ValueNotifier<double> scrollSpeed;
  final ValueNotifier<double> lineSpacing;
  final ValueNotifier<double> scrollProgress;
  final ScrollController scrollController;
  final VoidCallback onTogglePlay;
  final VoidCallback? onEditScript;
  final VoidCallback onToggleSettings;
  final VoidCallback onToggleControls;
  final Function(Offset) onDrag;
  final Function(Size) onResize;
  final VoidCallback? onTapPause;

  const PrompterOverlay({
    super.key,
    required this.scriptContent,
    required this.isPlayingScript,
    required this.showScriptControls,
    required this.showSettingsPanel,
    required this.dragX,
    required this.dragY,
    required this.prompterSize,
    required this.prompterOpacity,
    required this.fontSize,
    required this.textOrientation,
    required this.scrollSpeed,
    required this.lineSpacing,
    required this.scrollProgress,
    required this.scrollController,
    required this.onTogglePlay,
    this.onEditScript,
    required this.onToggleSettings,
    required this.onToggleControls,
    required this.onDrag,
    required this.onResize,
    this.onTapPause,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: dragX,
      top: dragY,
      child: RepaintBoundary(
        child: GestureDetector(
          onPanUpdate: (d) => onDrag(d.delta),
          onTap: onToggleControls,
          child: ValueListenableBuilder<Size>(
            valueListenable: prompterSize,
            builder: (context, size, _) {
              return ValueListenableBuilder<double>(
                valueListenable: prompterOpacity,
                builder: (context, opacity, _) {
                  return Consumer<UIProvider>(
                    builder: (context, uiBg, _) {
                      final bgBase = Color(uiBg.prompterBgColor);
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        width: size.width,
                        height: size.height,
                        decoration: BoxDecoration(
                          color: bgBase.withValues(alpha: opacity),
                          border: Border.all(
                            color: showScriptControls
                                ? Colors.white24
                                : Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24.r),
                          child: Stack(
                            children: [
                              _PrompterTextList(
                                scriptContent: scriptContent,
                                scrollController: scrollController,
                                textOrientation: textOrientation,
                                fontSize: fontSize,
                                lineSpacing: lineSpacing,
                                scrollSpeed: scrollSpeed,
                                containerHeight: size.height,
                                showScriptControls: showScriptControls,
                                onTapPause: onTapPause,
                              ),
                              _ScrollProgressBar(scrollProgress: scrollProgress),
                              if (showScriptControls)
                                _PrompterControlBar(
                                  isPlaying: isPlayingScript,
                                  showSettings: showSettingsPanel,
                                  textOrientation: textOrientation,
                                  onTogglePlay: onTogglePlay,
                                  onEditScript: onEditScript,
                                  onToggleSettings: onToggleSettings,
                                ),
                              if (showScriptControls)
                                _ResizeHandle(
                                  onResize: onResize,
                                  prompterSize: prompterSize,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ScrollProgressBar extends StatelessWidget {
  final ValueNotifier<double> scrollProgress;

  const _ScrollProgressBar({required this.scrollProgress});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: ValueListenableBuilder<double>(
        valueListenable: scrollProgress,
        builder: (context, progress, _) {
          if (progress <= 0) return const SizedBox.shrink();
          return Consumer<PremiumProvider>(
            builder: (context, premium, _) {
              return ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r),
                ),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 3.h,
                  backgroundColor: Colors.white10,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.primary,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}


class _PrompterTextList extends StatefulWidget {
  final String scriptContent;
  final ScrollController scrollController;
  final ValueNotifier<int> textOrientation;
  final ValueNotifier<double> fontSize;
  final ValueNotifier<double> lineSpacing;
  final ValueNotifier<double> scrollSpeed;
  final double containerHeight;
  final bool showScriptControls;
  final VoidCallback? onTapPause;

  const _PrompterTextList({
    required this.scriptContent,
    required this.scrollController,
    required this.textOrientation,
    required this.fontSize,
    required this.lineSpacing,
    required this.scrollSpeed,
    required this.containerHeight,
    required this.showScriptControls,
    this.onTapPause,
  });

  @override
  State<_PrompterTextList> createState() => _PrompterTextListState();
}

class _PrompterTextListState extends State<_PrompterTextList> {
  int _focusCharIndex = 0;
  double _pinchStartFontSize = 20.0;

  // Cue card state
  List<String> _cueCards = [];
  int _cueIndex = 0;

  List<String> _buildCueCards(String text) {
    return text
        .split(RegExp(r'(?<=[.!?])\s+|[\n]+'))
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
  }

  void _nextCue() {
    if (_cueIndex < _cueCards.length - 1) {
      HapticFeedback.lightImpact();
      setState(() => _cueIndex++);
    }
  }

  void _prevCue() {
    if (_cueIndex > 0) {
      HapticFeedback.lightImpact();
      setState(() => _cueIndex--);
    }
  }

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
    widget.fontSize.addListener(_onMetricsChanged);
    widget.lineSpacing.addListener(_onMetricsChanged);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    widget.fontSize.removeListener(_onMetricsChanged);
    widget.lineSpacing.removeListener(_onMetricsChanged);
    super.dispose();
  }

  void _onScroll() => _updateFocusIndex();
  void _onMetricsChanged() => _updateFocusIndex();

  void _updateFocusIndex() {
    if (!widget.scrollController.hasClients) return;
    final scrollOffset = widget.scrollController.offset;
    final focusLineY = widget.containerHeight * 0.25;
    // The text starts at containerHeight/2 padding, so the y in text-space
    // that sits at the focus line is:  scrollOffset - containerH/2 + focusLineY
    final textY = scrollOffset - widget.containerHeight / 2 + focusLineY;
    if (textY < 0) {
      if (_focusCharIndex != 0) setState(() => _focusCharIndex = 0);
      return;
    }

    final content = widget.scriptContent.isEmpty
        ? ' '
        : widget.scriptContent;
    final fs = widget.fontSize.value;
    final ls = widget.lineSpacing.value;
    final horizontalPadding = 32.0.w;
    final maxWidth = (widget.containerHeight > 0)
        ? (widget.containerHeight - horizontalPadding).clamp(100.0, 2000.0)
        : 300.0;

    final painter = TextPainter(
      text: TextSpan(
        text: content,
        style: TextStyle(
          fontSize: fs,
          fontWeight: FontWeight.w700,
          height: ls,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);

    final pos = painter.getPositionForOffset(Offset(maxWidth / 2, textY));
    final newIndex = pos.offset.clamp(0, content.length);
    if (newIndex != _focusCharIndex) {
      setState(() => _focusCharIndex = newIndex);
    }
  }

  Widget _buildCueCardView(BuildContext context, UIProvider ui) {
    _cueCards = _buildCueCards(
      widget.scriptContent.isEmpty ? '...' : widget.scriptContent,
    );
    final clamped = _cueIndex.clamp(0, _cueCards.isEmpty ? 0 : _cueCards.length - 1);
    if (_cueIndex != clamped) _cueIndex = clamped;
    final card = _cueCards.isEmpty ? '' : _cueCards[_cueIndex];
    final total = _cueCards.length;

    return ValueListenableBuilder<double>(
      valueListenable: widget.fontSize,
      builder: (_, fs, __) {
        final style = _applyFontFamily(
          TextStyle(
            fontSize: fs,
            color: Colors.white,
            fontWeight: FontWeight.w700,
            height: 1.4,
            shadows: [Shadow(color: Colors.black, offset: Offset(1.w, 1.h), blurRadius: 4.r)],
          ),
          ui.prompterFontFamily,
        );
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: GestureDetector(
                onTapUp: (d) {
                  final half = context.size?.width ?? 300;
                  if (d.localPosition.dx > half / 2) {
                    _nextCue();
                  } else {
                    _prevCue();
                  }
                },
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Text(card, textAlign: TextAlign.center, style: style),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios_rounded, color: _cueIndex > 0 ? Colors.white70 : Colors.white24, size: 18.sp),
                    onPressed: _cueIndex > 0 ? _prevCue : null,
                  ),
                  Text(
                    '${_cueIndex + 1} / $total',
                    style: TextStyle(color: Colors.white54, fontSize: 12.sp),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios_rounded, color: _cueIndex < total - 1 ? Colors.white70 : Colors.white24, size: 18.sp),
                    onPressed: _cueIndex < total - 1 ? _nextCue : null,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      bottom: widget.showScriptControls ? 64.h : 0,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTapDown: widget.onTapPause != null ? (_) => widget.onTapPause!() : null,
        onScaleStart: (d) {
          _pinchStartFontSize = widget.fontSize.value;
        },
        onScaleUpdate: (d) {
          if (d.pointerCount >= 2) {
            // Pinch → font size
            final newFs = (_pinchStartFontSize * d.scale).clamp(14.0, 60.0);
            widget.fontSize.value = newFs;
          } else {
            // Single-finger vertical swipe → scroll speed
            final dy = d.focalPointDelta.dy;
            if (dy.abs() > 1.0) {
              final delta = -dy * 0.4;
              widget.scrollSpeed.value =
                  (widget.scrollSpeed.value + delta).clamp(10.0, 150.0);
            }
          }
        },
        child: Consumer<UIProvider>(
          builder: (context, uiCol, _) {
            final colWidth = uiCol.prompterColumnWidth; // 0.0–1.0
            // extra horizontal padding: full=0%, medium=15%, narrow=30% of container
            final extraPct = (1.0 - colWidth) * 0.30;
            final hPad = 16.w + (widget.containerHeight > 0
                ? widget.containerHeight * extraPct
                : 0.0);
            return Padding(
          padding: EdgeInsets.fromLTRB(hPad, 24.h, hPad, 0),
          child: ValueListenableBuilder<int>(
          valueListenable: widget.textOrientation,
          builder: (context, orientation, _) {
            return Consumer<UIProvider>(
              builder: (context, ui, _) {
                if (ui.cueCardModeEnabled) {
                  return _buildCueCardView(context, ui);
                }
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.diagonal3Values(
                    ui.mirrorTextEnabled ? -1.0 : 1.0,
                    1.0,
                    1.0,
                  ),
                  child: RotatedBox(
                    quarterTurns: orientation,
                    child: ShaderMask(
                      shaderCallback: (r) => const LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.white,
                          Colors.white,
                          Colors.transparent,
                        ],
                        stops: [0.0, 0.1, 0.9, 1.0],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ).createShader(r),
                      blendMode: BlendMode.dstIn,
                      child: SingleChildScrollView(
                        controller: widget.scrollController,
                        padding: EdgeInsets.symmetric(
                          vertical: widget.containerHeight / 2,
                        ),
                        child: ValueListenableBuilder<double>(
                          valueListenable: widget.fontSize,
                          builder: (context, fs, _) {
                            return ValueListenableBuilder<double>(
                              valueListenable: widget.lineSpacing,
                              builder: (context, ls, _) {
                                final rawText = widget.scriptContent.isEmpty
                                    ? AppLocalizations.of(context).scriptContentPlaceholder
                                    : widget.scriptContent;

                                final textCol = Color(ui.prompterTextColor);
                                final baseStyle = _applyFontFamily(
                                  TextStyle(
                                    fontSize: fs,
                                    color: textCol,
                                    fontWeight: FontWeight.w700,
                                    height: ls,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withValues(alpha: 0.6),
                                        offset: Offset(1.w, 1.h),
                                        blurRadius: 4.r,
                                      ),
                                    ],
                                  ),
                                  ui.prompterFontFamily,
                                );

                                if (!ui.focusLineEnabled) {
                                  return Text(
                                    rawText,
                                    textAlign: TextAlign.center,
                                    style: baseStyle,
                                  );
                                }

                                // Find the line boundaries around focusCharIndex.
                                // Walk back to nearest newline (or start) and forward
                                // to next newline (or end) to get the focused line range.
                                final clampedIdx = _focusCharIndex.clamp(0, rawText.length);
                                int lineStart = rawText.lastIndexOf('\n', clampedIdx > 0 ? clampedIdx - 1 : 0);
                                lineStart = lineStart < 0 ? 0 : lineStart + 1;
                                int lineEnd = rawText.indexOf('\n', clampedIdx);
                                if (lineEnd < 0) lineEnd = rawText.length;

                                final before = rawText.substring(0, lineStart);
                                final focused = rawText.substring(lineStart, lineEnd);
                                final after = rawText.substring(lineEnd);

                                final dimStyle = baseStyle.copyWith(
                                  color: textCol.withValues(alpha: 0.35),
                                  shadows: [],
                                );
                                final focusStyle = baseStyle.copyWith(
                                  color: textCol,
                                  backgroundColor: AppColors.primary.withValues(alpha: 0.28),
                                );

                                return RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    children: [
                                      if (before.isNotEmpty)
                                        TextSpan(text: before, style: dimStyle),
                                      TextSpan(text: focused, style: focusStyle),
                                      if (after.isNotEmpty)
                                        TextSpan(text: after, style: dimStyle),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      );
          },
        ),
      ),
    );
  }
}

class PrompterSettingsSheet extends StatelessWidget {
  final ValueNotifier<double> fontSize;
  final ValueNotifier<double> prompterOpacity;
  final ValueNotifier<double> scrollSpeed;
  final ValueNotifier<double> lineSpacing;

  const PrompterSettingsSheet({
    super.key,
    required this.fontSize,
    required this.prompterOpacity,
    required this.scrollSpeed,
    required this.lineSpacing,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final sheetBg = isDark ? const Color(0xFF111111) : AppColors.lightSurface;
    final borderColor = isDark ? Colors.white10 : AppColors.borderLight;
    final panelBg = isDark
        ? Colors.white.withValues(alpha: 0.05)
        : Colors.black.withValues(alpha: 0.03);
    const sectionSpacing = 12.0;

    return Container(
      decoration: BoxDecoration(
        color: sheetBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        border: Border(top: BorderSide(color: borderColor, width: 1.w)),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 24.h),
          child: Column(
            children: [
              Container(
                width: 42.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white24
                      : Colors.black.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: _SettingRow(
                      icon: Icons.text_fields_rounded,
                      label: l10n.fontSize,
                      notifier: fontSize,
                      min: 16,
                      max: 50,
                      onChangeEnd: (v) {
                        AnalyticsService().logTeleprompterSettingsChanged(
                          fontSize: v,
                          scrollSpeed: 0,
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _SettingRow(
                      icon: Icons.opacity_rounded,
                      label: l10n.opacity,
                      notifier: prompterOpacity,
                      min: 0.1,
                      max: 0.9,
                      isPercentage: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: sectionSpacing.h),
              Row(
                children: [
                  Expanded(
                    child: _SettingRow(
                      icon: Icons.format_line_spacing_rounded,
                      label: l10n.lineSpacing,
                      notifier: lineSpacing,
                      min: 1.0,
                      max: 2.5,
                      decimals: 1,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _SettingRow(
                      icon: Icons.speed_rounded,
                      label: l10n.speed,
                      notifier: scrollSpeed,
                      min: 10,
                      max: 150,
                      onChangeEnd: (v) {
                        AnalyticsService().logTeleprompterSettingsChanged(
                          fontSize: 0,
                          scrollSpeed: v,
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: sectionSpacing.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: panelBg,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: borderColor),
                ),
                child: Consumer<UIProvider>(
                  builder: (context, uiProvider, _) => Column(
                    children: [
                      _toggleRow(
                        context: context,
                        icon: Icons.mic_rounded,
                        label: l10n.voiceSync,
                        trailing: Consumer<PremiumProvider>(
                          builder: (context, premium, _) => Switch(
                            value:
                                uiProvider.voiceSyncEnabled &&
                                premium.isPremium,
                            onChanged: (v) {
                              if (premium.isPremium) {
                                uiProvider.toggleVoiceSync(v);
                              } else {
                                ToastService.show(l10n.voiceSyncLocked);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const PremiumScreen(),
                                  ),
                                );
                              }
                            },
                            activeThumbColor: AppColors.primary,
                            activeTrackColor: AppColors.primary.withValues(alpha: 0.3),
                          ),
                        ),
                      ),
                      _toggleRow(
                        context: context,
                        icon: Icons.flip_rounded,
                        label: l10n.mirror,
                        trailing: Switch(
                          value: uiProvider.mirrorTextEnabled,
                          onChanged: (v) => uiProvider.toggleMirrorText(v),
                          activeThumbColor: AppColors.primary,
                          activeTrackColor: AppColors.primary.withValues(alpha: 0.3),
                        ),
                      ),
                      _toggleRow(
                        context: context,
                        icon: Icons.center_focus_strong_rounded,
                        label: l10n.focusLine,
                        trailing: Switch(
                          value: uiProvider.focusLineEnabled,
                          onChanged: (v) => uiProvider.toggleFocusLine(v),
                          activeThumbColor: AppColors.primary,
                          activeTrackColor: AppColors.primary.withValues(alpha: 0.3),
                        ),
                      ),
                      _toggleRow(
                        context: context,
                        icon: Icons.view_day_rounded,
                        label: l10n.cueCards,
                        trailing: Consumer<PremiumProvider>(
                          builder: (context, premium, _) => Switch(
                            value: uiProvider.cueCardModeEnabled && premium.isPremium,
                            onChanged: (v) {
                              if (premium.isPremium) {
                                uiProvider.toggleCueCardMode(v);
                              } else {
                                ToastService.show(l10n.voiceSyncLocked);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const PremiumScreen(),
                                  ),
                                );
                              }
                            },
                            activeThumbColor: AppColors.primary,
                            activeTrackColor: AppColors.primary.withValues(alpha: 0.3),
                          ),
                        ),
                      ),
                      SizedBox(height: sectionSpacing.h),
                      Row(
                        children: [
                          Icon(Icons.font_download_outlined,
                              color: AppColors.primary, size: 18.sp),
                          SizedBox(width: 10.w),
                          Text(
                            l10n.font,
                            style: TextStyle(
                              color: isDark
                                  ? Colors.white
                                  : AppColors.textBlack,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: SizedBox(
                              height: 32.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                itemCount: kPrompterFontFamilies.length,
                                itemBuilder: (context, i) {
                                  final family = kPrompterFontFamilies[i];
                                  final selected =
                                      uiProvider.prompterFontFamily == family;
                                  return GestureDetector(
                                    onTap: () =>
                                        uiProvider.setPrompterFontFamily(family),
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 180),
                                      margin: EdgeInsets.only(right: 6.w),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      decoration: BoxDecoration(
                                        color: selected
                                            ? AppColors.primary
                                            : (isDark
                                                ? Colors.white10
                                                : Colors.black.withValues(alpha: 0.06)),
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                      ),
                                      child: Center(
                                        child: Text(
                                          family,
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w700,
                                            color: selected
                                                ? Colors.white
                                                : (isDark
                                                    ? Colors.white60
                                                    : AppColors.textGrey),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: sectionSpacing.h),
                      _SpeedPresetsRow(scrollSpeed: scrollSpeed),
                      SizedBox(height: sectionSpacing.h),
                      _toggleRow(
                        context: context,
                        icon: Icons.loop_rounded,
                        label: l10n.loop,
                        trailing: Switch(
                          value: uiProvider.prompterLoopEnabled,
                          onChanged: uiProvider.togglePrompterLoop,
                          activeThumbColor: AppColors.primary,
                          activeTrackColor: AppColors.primary.withValues(alpha: 0.3),
                        ),
                      ),
                      _toggleRow(
                        context: context,
                        icon: Icons.speed_rounded,
                        label: l10n.softStart,
                        trailing: Switch(
                          value: uiProvider.prompterSoftStartEnabled,
                          onChanged: uiProvider.togglePrompterSoftStart,
                          activeThumbColor: AppColors.primary,
                          activeTrackColor: AppColors.primary.withValues(alpha: 0.3),
                        ),
                      ),
                      SizedBox(height: sectionSpacing.h),
                      _ColorAndWidthRow(uiProvider: uiProvider),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _toggleRow({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Widget trailing,
  }) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 18.sp),
        SizedBox(width: 10.w),
        Text(
          label,
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : AppColors.textBlack,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        trailing,
      ],
    );
  }
}

class _SettingRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final ValueNotifier<double> notifier;
  final double min;
  final double max;
  final bool isPercentage;
  final int decimals;
  final ValueChanged<double>? onChangeEnd;

  const _SettingRow({
    required this.icon,
    required this.label,
    required this.notifier,
    required this.min,
    required this.max,
    this.isPercentage = false,
    this.decimals = 0,
    this.onChangeEnd,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ValueListenableBuilder<double>(
      valueListenable: notifier,
      builder: (context, val, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: isDark ? Colors.white70 : AppColors.textGrey,
                size: 16.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                label,
                style: TextStyle(
                  color: isDark ? Colors.white70 : AppColors.textGrey,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2.w,
                ),
              ),
              const Spacer(),
              Text(
                isPercentage
                    ? "${(val * 100).toInt()}%"
                    : decimals > 0
                    ? val.toStringAsFixed(decimals)
                    : "${val.toInt()}",
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 4.h,
              activeTrackColor: AppColors.primary,
              inactiveTrackColor: isDark
                  ? Colors.white12
                  : Colors.black.withValues(alpha: 0.14),
              thumbColor: isDark ? Colors.white : AppColors.primary,
              overlayColor: AppColors.primary.withValues(alpha: 0.2),
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 7.r),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 14.r),
            ),
            child: Slider(
              value: val,
              min: min,
              max: max,
              onChanged: (v) => notifier.value = v,
              onChangeEnd: onChangeEnd,
            ),
          ),
        ],
      ),
    );
  }
}

class _PrompterControlBar extends StatelessWidget {
  final bool isPlaying;
  final bool showSettings;
  final ValueNotifier<int> textOrientation;
  final VoidCallback onTogglePlay;
  final VoidCallback? onEditScript;
  final VoidCallback onToggleSettings;

  const _PrompterControlBar({
    required this.isPlaying,
    required this.showSettings,
    required this.textOrientation,
    required this.onTogglePlay,
    this.onEditScript,
    required this.onToggleSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 64.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.4),
          border: Border(
            top: BorderSide(color: Colors.white10, width: 1.w),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                showSettings ? Icons.close : Icons.tune,
                color: Colors.white70,
              ),
              iconSize: 24.sp,
              onPressed: onToggleSettings,
            ),
            GestureDetector(
              onTap: onTogglePlay,
              child: Container(
                width: 48.w,
                height: 48.h,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: 30.sp,
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.edit_note_rounded,
                    color:
                        onEditScript == null ? Colors.white24 : Colors.white70,
                    size: 22.sp,
                  ),
                  onPressed: onEditScript,
                ),
                IconButton(
                  icon: Icon(
                    Icons.rotate_right,
                    color: Colors.white70,
                    size: 24.sp,
                  ),
                  onPressed: () =>
                      textOrientation.value = (textOrientation.value + 1) % 4,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ResizeHandle extends StatelessWidget {
  final Function(Size) onResize;
  final ValueNotifier<Size> prompterSize;

  const _ResizeHandle({required this.onResize, required this.prompterSize});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 4,
      bottom: 4,
      child: GestureDetector(
        onPanUpdate: (d) {
          final newWidth = (prompterSize.value.width + d.delta.dx).clamp(
            200.0,
            1000.0,
          );
          final newHeight = (prompterSize.value.height + d.delta.dy).clamp(
            200.0,
            1000.0,
          );
          onResize(Size(newWidth, newHeight));
        },
        child: Container(
          width: 32,
          height: 32,
          alignment: Alignment.bottomRight,
          color: Colors.transparent,
          child: const Icon(
            Icons.open_in_full_rounded,
            color: Colors.white54,
            size: 18,
          ),
        ),
      ),
    );
  }
}

// ─── Speed Presets ────────────────────────────────────────────────────────────
class _SpeedPresetsRow extends StatelessWidget {
  final ValueNotifier<double> scrollSpeed;
  const _SpeedPresetsRow({required this.scrollSpeed});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final presets = <({String label, double value})>[
      (label: l10n.speedSlow, value: 25.0),
      (label: l10n.speedNormal, value: 50.0),
      (label: l10n.speedFast, value: 85.0),
      (label: l10n.speedTurbo, value: 130.0),
    ];
    return Row(
      children: [
        Icon(Icons.play_circle_outline, color: AppColors.primary, size: 18.sp),
        SizedBox(width: 10.w),
        Text(
          l10n.speed,
          style: TextStyle(
            color: isDark ? Colors.white : AppColors.textBlack,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: ValueListenableBuilder<double>(
            valueListenable: scrollSpeed,
            builder: (_, spd, _) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: presets.map((p) {
                final selected = (spd - p.value).abs() < 5;
                return GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    scrollSpeed.value = p.value;
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.primary
                          : (isDark
                              ? Colors.white10
                              : Colors.black.withValues(alpha: 0.06)),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      p.label,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        color: selected
                            ? Colors.white
                            : (isDark ? Colors.white60 : AppColors.textGrey),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Color Swatches + Column Width ────────────────────────────────────────────
class _ColorAndWidthRow extends StatelessWidget {
  final UIProvider uiProvider;
  const _ColorAndWidthRow({required this.uiProvider});

  static const _bgPresets = <({String label, int color})>[
    (label: 'Black', color: 0xFF000000),
    (label: 'Dark', color: 0xFF1A1A2E),
    (label: 'Grey', color: 0xFF2C2C2C),
    (label: 'Green', color: 0xFF0D2B0D),
    (label: 'Navy', color: 0xFF0A0A2A),
  ];

  static const _textPresets = <({String label, int color})>[
    (label: 'White', color: 0xFFFFFFFF),
    (label: 'Yellow', color: 0xFFFFF176),
    (label: 'Amber', color: 0xFFFFCC00),
    (label: 'Cyan', color: 0xFF80DEEA),
    (label: 'Green', color: 0xFF69F0AE),
  ];

  Widget _swatchRow({
    required String rowLabel,
    required IconData icon,
    required List<({String label, int color})> presets,
    required int selectedColor,
    required void Function(int) onSelect,
  }) {
    return Builder(builder: (context) {
      final isDark = Theme.of(context).brightness == Brightness.dark;
      return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 18.sp),
        SizedBox(width: 8.w),
        Text(
          rowLabel,
          style: TextStyle(
            color: isDark ? Colors.white : AppColors.textBlack,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Row(
            children: presets.map((p) {
              final selected = selectedColor == p.color;
              return GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  onSelect(p.color);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: 28.w,
                  height: 28.w,
                  margin: EdgeInsets.only(right: 8.w),
                  decoration: BoxDecoration(
                    color: Color(p.color),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: selected
                          ? AppColors.primary
                          : (isDark
                              ? Colors.white24
                              : AppColors.borderLight),
                      width: selected ? 2.5 : 1,
                    ),
                  ),
                  child: selected
                      ? Icon(Icons.check, color: p.color == 0xFF000000 ? Colors.white : Colors.black, size: 14.sp)
                      : null,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        _swatchRow(
          rowLabel: AppLocalizations.of(context).background,
          icon: Icons.format_color_fill_rounded,
          presets: _bgPresets,
          selectedColor: uiProvider.prompterBgColor,
          onSelect: uiProvider.setPrompterBgColor,
        ),
        SizedBox(height: 8.h),
        _swatchRow(
          rowLabel: AppLocalizations.of(context).text,
          icon: Icons.format_color_text_rounded,
          presets: _textPresets,
          selectedColor: uiProvider.prompterTextColor,
          onSelect: uiProvider.setPrompterTextColor,
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Icon(Icons.width_normal_rounded, color: AppColors.primary, size: 18.sp),
            SizedBox(width: 8.w),
            Text(
              AppLocalizations.of(context).width,
              style: TextStyle(
                color: isDark ? Colors.white : AppColors.textBlack,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  (label: AppLocalizations.of(context).widthNarrow, value: 0.0),
                  (label: AppLocalizations.of(context).widthMedium, value: 0.5),
                  (label: AppLocalizations.of(context).widthFull, value: 1.0),
                ].map((p) {
                  final selected = (uiProvider.prompterColumnWidth - p.value).abs() < 0.1;
                  return GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      uiProvider.setPrompterColumnWidth(p.value);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: selected
                            ? AppColors.primary
                            : (isDark
                                ? Colors.white10
                                : Colors.black.withValues(alpha: 0.06)),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        p.label,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w700,
                          color: selected
                              ? Colors.white
                              : (isDark ? Colors.white60 : AppColors.textGrey),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Same overlay settings sheet as in-record mode; keeps [UIProvider] in sync for
/// the slider-backed values while the sheet is open.
Future<void> showPrompterOverlaySettingsSheet(BuildContext context) async {
  final ui = context.read<UIProvider>();

  final fontSize = ValueNotifier(ui.prompterFontSize);
  final prompterOpacity = ValueNotifier(ui.prompterOpacity);
  final scrollSpeed = ValueNotifier(ui.prompterScrollSpeed);
  final lineSpacing = ValueNotifier(ui.lineSpacing);

  void syncFontSize() => ui.setPrompterFontSize(fontSize.value);
  void syncOpacity() => ui.setPrompterOpacity(prompterOpacity.value);
  void syncScrollSpeed() => ui.setPrompterScrollSpeed(scrollSpeed.value);
  void syncLineSpacing() => ui.setLineSpacing(lineSpacing.value);

  fontSize.addListener(syncFontSize);
  prompterOpacity.addListener(syncOpacity);
  scrollSpeed.addListener(syncScrollSpeed);
  lineSpacing.addListener(syncLineSpacing);

  try {
    await showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => PrompterSettingsSheet(
        fontSize: fontSize,
        prompterOpacity: prompterOpacity,
        scrollSpeed: scrollSpeed,
        lineSpacing: lineSpacing,
      ),
    );
  } finally {
    fontSize.removeListener(syncFontSize);
    prompterOpacity.removeListener(syncOpacity);
    scrollSpeed.removeListener(syncScrollSpeed);
    lineSpacing.removeListener(syncLineSpacing);
    fontSize.dispose();
    prompterOpacity.dispose();
    scrollSpeed.dispose();
    lineSpacing.dispose();
  }
}
