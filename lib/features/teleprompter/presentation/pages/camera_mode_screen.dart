import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/connectivity_service.dart';
import '../../../../core/utils/responsive_config.dart';
import '../../../../core/utils/toast_service.dart';
import '../../../../generated/l10n/app_localizations.dart';
import '../../../onboarding/presentation/pages/onboarding_screen.dart';
import '../../../premium/presentation/providers/premium_provider.dart';
import '../../../premium/presentation/screen/premium_screen.dart';
import '../../../settings/presentation/providers/ui_provider.dart';
import '../../../scripts/data/models/script_model.dart';
import '../../../scripts/presentation/pages/editor_screen.dart';
import '../../../scripts/presentation/providers/scripts_provider.dart';
import '../../../../core/services/recent_scripts_service.dart';
import '../../../../widgets/ads/rewarded_ad_dialog.dart';
import '../../../../widgets/common/adaptive_app_bar.dart';
import '../providers/recording_restriction_provider.dart';
import '../widgets/prompter_overlay.dart';
import 'teleprompter_screen.dart';

class CameraModeScreen extends StatefulWidget {
  const CameraModeScreen({super.key});

  @override
  State<CameraModeScreen> createState() => _CameraModeScreenState();
}

class _CameraModeScreenState extends State<CameraModeScreen>
    with SingleTickerProviderStateMixin {
  late final ScrollController _previewScrollController;
  late final Ticker _ticker;
  Duration _lastTick = Duration.zero;
  bool _isPlayingPreview = true;
  double _previewSpeed = 38;
  double _previewFontSize = 19;
  double _overlayOpacity = 0.45;
  bool _didLoadUiDefaults = false;
  bool _premiumListenerAttached = false;
  late PremiumProvider _premiumProvider;
  late RecordingRestrictionProvider _restrictionProvider;
  dynamic _selectedScriptKey;

  Script get _demoScript => Script(
    title: 'Professional Intro Script',
    content:
        'Welcome to ScriptCam.\n\nThis live preview helps you rehearse your delivery before recording.\nUse the controls below to adjust scroll speed, text size, and overlay opacity.\n\nMaintain eye contact with the lens and speak at a steady pace.\n\nWhen you are ready, tap Start Recording.',
    createdAt: DateTime.now(),
    category: 'General',
  );

  @override
  void initState() {
    super.initState();
    _previewScrollController = ScrollController();
    _ticker = createTicker(_onTick)..start();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didLoadUiDefaults) {
      final ui = context.read<UIProvider>();
      _syncPreviewFieldsFromUi(ui);
      _didLoadUiDefaults = true;
    }
    if (!_premiumListenerAttached) {
      _premiumProvider = context.read<PremiumProvider>();
      _restrictionProvider = context.read<RecordingRestrictionProvider>();
      _premiumProvider.addListener(_syncPremiumToRecordingRestriction);
      _premiumListenerAttached = true;
      _syncPremiumToRecordingRestriction();
    }
  }

  void _syncPremiumToRecordingRestriction() {
    _restrictionProvider.updatePremiumStatus(_premiumProvider.isPremium);
  }

  void _onTick(Duration elapsed) {
    if (!_isPlayingPreview || !_previewScrollController.hasClients) {
      _lastTick = elapsed;
      return;
    }
    if (_lastTick == Duration.zero) {
      _lastTick = elapsed;
      return;
    }
    final dt = (elapsed - _lastTick).inMicroseconds / 1000000.0;
    _lastTick = elapsed;
    final max = _previewScrollController.position.maxScrollExtent;
    final next = (_previewScrollController.offset + _previewSpeed * dt).clamp(
      0.0,
      max,
    );
    _previewScrollController.jumpTo(next);
    if (next >= max) {
      _previewScrollController.jumpTo(0);
    }
  }

  @override
  void dispose() {
    if (_premiumListenerAttached) {
      _premiumProvider.removeListener(_syncPremiumToRecordingRestriction);
    }
    _ticker.dispose();
    _previewScrollController.dispose();
    super.dispose();
  }

  Future<void> _startRecording(BuildContext context, Script script) async {
    final cameraStatus = await Permission.camera.status;
    final micStatus = await Permission.microphone.status;
    if (!context.mounted) return;

    if (!cameraStatus.isGranted || !micStatus.isGranted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
      return;
    }

    RecentScriptsService.recordUsed(script.key);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => TeleprompterScreen(script: script)),
    );
  }

  Script _fallbackScript() {
    return Script(
      title: AppLocalizations.of(context).untitledScript,
      content: AppLocalizations.of(context).addOrSelectScriptPrompt,
      createdAt: DateTime.now(),
      category: 'General',
    );
  }

  Script _resolveSelectedScript(List<Script> scripts) {
    if (scripts.isEmpty) return _fallbackScript();
    if (_selectedScriptKey != null) {
      for (final script in scripts) {
        if (script.key == _selectedScriptKey) return script;
      }
    }
    _selectedScriptKey = scripts.first.key;
    return scripts.first;
  }

  void _openScriptsPicker(BuildContext context, List<Script> scripts) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        final isDark = Theme.of(ctx).brightness == Brightness.dark;
        return Container(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 20.h),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurface : Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
            border: Border.all(
              color: isDark ? AppColors.borderDark : AppColors.borderLight,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 36.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.textGrey.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(99.r),
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(ctx).allScriptsTitle,
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const EditorScreen()),
                      );
                    },
                    child: Text(AppLocalizations.of(ctx).newScript),
                  ),
                ],
              ),
              SizedBox(
                height: 280.h,
                child: scripts.isEmpty
                    ? Center(
                        child: Text(
                          AppLocalizations.of(ctx).noSavedScriptSelected,
                          style: TextStyle(color: AppColors.textGrey, fontSize: 13.sp),
                        ),
                      )
                    : ListView.separated(
                        itemCount: scripts.length,
                        separatorBuilder: (_, __) => Divider(
                          height: 1,
                          color: AppColors.borderDark.withValues(alpha: 0.4),
                        ),
                        itemBuilder: (context, index) {
                          final script = scripts[index];
                          final selected = script.key == _selectedScriptKey;
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              script.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                              ),
                            ),
                            subtitle: Text(
                              AppLocalizations.of(ctx).wordCountShort(script.wordCount),
                              style: TextStyle(fontSize: 12.sp, color: AppColors.textGrey),
                            ),
                            trailing: selected
                                ? Icon(Icons.check_rounded, color: AppColors.primary, size: 18.sp)
                                : null,
                            onTap: () {
                              setState(() => _selectedScriptKey = script.key);
                              Navigator.pop(ctx);
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _syncPreviewFieldsFromUi(UIProvider ui) {
    _previewSpeed = ui.prompterScrollSpeed.clamp(10, 150);
    _previewFontSize = ui.prompterFontSize.clamp(16, 50);
    _overlayOpacity = ui.prompterOpacity.clamp(0.1, 0.9);
  }

  Future<void> _openOverlaySettings() async {
    await showPrompterOverlaySettingsSheet(context);
    if (!mounted) return;
    _syncPreviewFieldsFromUi(context.read<UIProvider>());
    setState(() {});
  }

  Future<void> _handleCreditsTap(BuildContext context) async {
    final premium = context.read<PremiumProvider>();
    if (premium.isPremium) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const PremiumScreen()),
      );
      return;
    }

    final action = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => const RewardedAdDialog(),
    );

    if (!mounted) return;
    if (action == 'premium') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const PremiumScreen()),
      );
      return;
    }
    if (action != 'watch') return;

    final restriction = context.read<RecordingRestrictionProvider>();
    final connectivity = context.read<ConnectivityService>();
    final l10n = AppLocalizations.of(context);
    restriction.watchAd(
      connectivity: connectivity,
      onRewardGranted: () {
        if (mounted) ToastService.show(l10n.rewardGranted);
      },
      onFailure: (_, __) {
        if (mounted) {
          ToastService.show(l10n.adNotAvailableDesc, isError: true);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      appBar: AdaptiveAppBar(
        title: AppLocalizations.of(context).appTitle,
        showBackButton: false,
        actions: [
          Consumer2<PremiumProvider, RecordingRestrictionProvider>(
            builder: (context, premium, restriction, _) {
              final label = premium.isPremium
                  ? AppLocalizations.of(context).pro
                  : AppLocalizations.of(context).creditsRemaining(
                      restriction.remainingRecordings,
                    );
              return Center(
                child: GestureDetector(
                  onTap: () => _handleCreditsTap(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.25),
                      ),
                    ),
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: Consumer<ScriptsProvider>(
          builder: (context, scriptsProvider, _) {
            final scripts = scriptsProvider.getScriptsByCategory('All');
            final selected = _resolveSelectedScript(scripts);

            return Padding(
              padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context).cameraPreviewWithOverlay,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.textGrey,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Icon(
                              Icons.videocam_rounded,
                              color: Colors.white24,
                              size: 88.sp,
                            ),
                          ),
                          Positioned(
                            left: 14.w,
                            right: 14.w,
                            top: 24.h,
                            bottom: 92.h,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 12.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: _overlayOpacity),
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(color: Colors.white24),
                              ),
                              child: ShaderMask(
                                shaderCallback: (rect) => const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.white,
                                    Colors.white,
                                    Colors.transparent,
                                  ],
                                  stops: [0.0, 0.08, 0.92, 1.0],
                                ).createShader(rect),
                                blendMode: BlendMode.dstIn,
                                child: SingleChildScrollView(
                                  controller: _previewScrollController,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 92.h,
                                  ),
                                  child: Text(
                                    _demoScript.content,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: _previewFontSize.sp,
                                      height: 1.55,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 12.h,
                            right: 12.w,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                'REC',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 11.sp,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 12.w,
                            right: 12.w,
                            bottom: 12.h,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 8.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.45),
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(color: Colors.white24),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: _openOverlaySettings,
                                    icon: const Icon(
                                      Icons.tune_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isPlayingPreview = !_isPlayingPreview;
                                      });
                                    },
                                    icon: Icon(
                                      _isPlayingPreview
                                          ? Icons.pause_rounded
                                          : Icons.play_arrow_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _RecentScriptsRow(
                    allScripts: scripts,
                    isDark: isDark,
                    onSelect: (script) {
                      setState(() => _selectedScriptKey = script.key);
                    },
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkSurface : Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: isDark ? AppColors.borderDark : AppColors.borderLight,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                selected.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.sp,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                scripts.isNotEmpty
                                    ? AppLocalizations.of(context).selectedScriptReady
                                    : AppLocalizations.of(
                                        context,
                                      ).noSavedScriptSelected,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: AppColors.textGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditorScreen(
                                  scriptToEdit: scripts.isNotEmpty ? selected : null,
                                ),
                              ),
                            );
                          },
                          child: Text(AppLocalizations.of(context).edit),
                        ),
                        TextButton(
                          onPressed: () => _openScriptsPicker(context, scripts),
                          child: Text(AppLocalizations.of(context).tabScripts),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _startRecording(context, selected),
                      icon: const Icon(Icons.fiber_manual_record_rounded),
                      label: Text(AppLocalizations.of(context).startRecording),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _RecentScriptsRow extends StatefulWidget {
  final List<Script> allScripts;
  final bool isDark;
  final ValueChanged<Script> onSelect;

  const _RecentScriptsRow({
    required this.allScripts,
    required this.isDark,
    required this.onSelect,
  });

  @override
  State<_RecentScriptsRow> createState() => _RecentScriptsRowState();
}

class _RecentScriptsRowState extends State<_RecentScriptsRow> {
  List<Script> _recents = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(_RecentScriptsRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    _load();
  }

  Future<void> _load() async {
    final keys = await RecentScriptsService.getRecentKeys();
    final matched = keys
        .map((k) {
          for (final s in widget.allScripts) {
            if (s.key?.toString() == k) return s;
          }
          return null;
        })
        .whereType<Script>()
        .toList();
    if (mounted) setState(() => _recents = matched);
  }

  @override
  Widget build(BuildContext context) {
    if (_recents.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Text(
            AppLocalizations.of(context).recent,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textGrey,
              letterSpacing: 0.5,
            ),
          ),
        ),
        SizedBox(
          height: 38.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: _recents.length,
            itemBuilder: (context, i) {
              final script = _recents[i];
              return GestureDetector(
                onTap: () => widget.onSelect(script),
                child: Container(
                  margin: EdgeInsets.only(right: 8.w),
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  decoration: BoxDecoration(
                    color: widget.isDark ? AppColors.darkSurface : Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: widget.isDark
                          ? AppColors.borderDark
                          : AppColors.borderLight,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.history_rounded,
                          size: 13.sp, color: AppColors.textGrey),
                      SizedBox(width: 6.w),
                      Text(
                        script.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
