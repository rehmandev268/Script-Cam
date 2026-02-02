import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_6/generated/l10n/app_localizations.dart';
import '../../../../core/utils/responsive_config.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../features/scripts/data/models/script_model.dart';
import '../../../settings/presentation/providers/ui_provider.dart';
import '../../../../core/services/analytics_service.dart';

class PrompterOverlay extends StatelessWidget {
  final Script script;
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
  final ScrollController scrollController;
  final VoidCallback onTogglePlay;
  final VoidCallback onToggleSettings;
  final VoidCallback onToggleControls;
  final Function(Offset) onDrag;
  final Function(Size) onResize;

  const PrompterOverlay({
    super.key,
    required this.script,
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
    required this.scrollController,
    required this.onTogglePlay,
    required this.onToggleSettings,
    required this.onToggleControls,
    required this.onDrag,
    required this.onResize,
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
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: size.width,
                    height: size.height,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: opacity),
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
                            script: script,
                            scrollController: scrollController,
                            textOrientation: textOrientation,
                            fontSize: fontSize,
                            containerHeight: size.height,
                            showScriptControls: showScriptControls,
                          ),
                          if (showSettingsPanel && showScriptControls)
                            _PrompterSettingsOverlay(
                              fontSize: fontSize,
                              prompterOpacity: prompterOpacity,
                              scrollSpeed: scrollSpeed,
                            ),
                          if (showScriptControls)
                            _PrompterControlBar(
                              isPlaying: isPlayingScript,
                              showSettings: showSettingsPanel,
                              textOrientation: textOrientation,
                              onTogglePlay: onTogglePlay,
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
          ),
        ),
      ),
    );
  }
}

class _PrompterTextList extends StatelessWidget {
  final Script script;
  final ScrollController scrollController;
  final ValueNotifier<int> textOrientation;
  final ValueNotifier<double> fontSize;
  final double containerHeight;
  final bool showScriptControls;

  const _PrompterTextList({
    required this.script,
    required this.scrollController,
    required this.textOrientation,
    required this.fontSize,
    required this.containerHeight,
    required this.showScriptControls,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      bottom: showScriptControls ? 64.h : 0,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 0),
        child: ValueListenableBuilder<int>(
          valueListenable: textOrientation,
          builder: (context, orientation, _) {
            return Consumer<UIProvider>(
              builder: (context, ui, _) {
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
                        controller: scrollController,
                        padding: EdgeInsets.symmetric(
                          vertical: containerHeight / 2,
                        ),
                        child: ValueListenableBuilder<double>(
                          valueListenable: fontSize,
                          builder: (context, fs, _) {
                            return Text(
                              script.content,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: fs,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                height: 1.4,
                                shadows: [
                                  Shadow(
                                    color: Colors.black,
                                    offset: Offset(1.w, 1.h),
                                    blurRadius: 4.r,
                                  ),
                                ],
                              ),
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
      ),
    );
  }
}

class _PrompterSettingsOverlay extends StatelessWidget {
  final ValueNotifier<double> fontSize;
  final ValueNotifier<double> prompterOpacity;
  final ValueNotifier<double> scrollSpeed;

  const _PrompterSettingsOverlay({
    required this.fontSize,
    required this.prompterOpacity,
    required this.scrollSpeed,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Positioned.fill(
      bottom: 64.h,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.r, sigmaY: 10.r),
          child: Container(
            color: Colors.black.withValues(alpha: 0.8),
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _SettingRow(
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
                SizedBox(height: 20.h),
                _SettingRow(
                  icon: Icons.opacity_rounded,
                  label: l10n.opacity,
                  notifier: prompterOpacity,
                  min: 0.1,
                  max: 0.9,
                  isPercentage: true,
                ),
                SizedBox(height: 20.h),
                _SettingRow(
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
                SizedBox(height: 24.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Consumer<UIProvider>(
                    builder: (context, uiProvider, _) => Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.mic_rounded,
                              color: AppColors.primary,
                              size: 20.sp,
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              l10n.voiceSync,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5.w,
                              ),
                            ),
                            const Spacer(),
                            Switch(
                              value: uiProvider.voiceSyncEnabled,
                              onChanged: (v) => uiProvider.toggleVoiceSync(v),
                              activeThumbColor: AppColors.primary,
                              activeTrackColor: AppColors.primary.withValues(
                                alpha: 0.3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            Icon(
                              Icons.flip_rounded,
                              color: AppColors.primary,
                              size: 20.sp,
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              l10n.mirror,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5.w,
                              ),
                            ),
                            const Spacer(),
                            Switch(
                              value: uiProvider.mirrorTextEnabled,
                              onChanged: (v) => uiProvider.toggleMirrorText(v),
                              activeThumbColor: AppColors.primary,
                              activeTrackColor: AppColors.primary.withValues(
                                alpha: 0.3,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
  final ValueChanged<double>? onChangeEnd;

  const _SettingRow({
    required this.icon,
    required this.label,
    required this.notifier,
    required this.min,
    required this.max,
    this.isPercentage = false,
    this.onChangeEnd,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: notifier,
      builder: (context, val, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white70, size: 16.sp),
              SizedBox(width: 8.w),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2.w,
                ),
              ),
              const Spacer(),
              Text(
                isPercentage ? "${(val * 100).toInt()}%" : "${val.toInt()}",
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
              inactiveTrackColor: Colors.white12,
              thumbColor: Colors.white,
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
  final VoidCallback onToggleSettings;

  const _PrompterControlBar({
    required this.isPlaying,
    required this.showSettings,
    required this.textOrientation,
    required this.onTogglePlay,
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
