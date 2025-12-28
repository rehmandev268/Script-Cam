import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/responsive_config.dart';
import '../../../../core/utils/toast_service.dart';
import '../../../../core/services/ad_manager.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../widgets/common/adaptive_app_bar.dart';
import '../../../premium/presentation/providers/premium_provider.dart';
import '../../data/models/script_model.dart';
import '../providers/scripts_provider.dart';

class EditorScreen extends StatefulWidget {
  final Script? scriptToEdit;
  final VoidCallback? onSaveSuccess;

  const EditorScreen({super.key, this.scriptToEdit, this.onSaveSuccess});

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  final _titleCtrl = TextEditingController();
  final _bodyCtrl = TextEditingController();

  String _selectedPlatform = "General";
  final List<Map<String, dynamic>> _platforms = [
    {"name": "General", "icon": Icons.article_rounded, "color": Colors.grey},
    {
      "name": "YouTube",
      "icon": Icons.play_arrow_rounded,
      "color": const Color(0xFFFF0000),
    },
    {
      "name": "Instagram",
      "icon": Icons.camera_alt_rounded,
      "color": const Color(0xFFE1306C),
    },
    {
      "name": "TikTok",
      "icon": Icons.music_note_rounded,
      "color": const Color(0xFF00F2EA),
    },
    {
      "name": "LinkedIn",
      "icon": Icons.work_rounded,
      "color": const Color(0xFF0077B5),
    },
  ];

  int _wordCount = 0;
  String _estDuration = "0s";

  @override
  void initState() {
    super.initState();
    if (widget.scriptToEdit != null) {
      _titleCtrl.text = widget.scriptToEdit!.title;
      _bodyCtrl.text = widget.scriptToEdit!.content;
      _detectPlatformFromContent();
      _updateStats();
    }
    _bodyCtrl.addListener(_updateStats);
  }

  void _detectPlatformFromContent() {
    final combined = "${_titleCtrl.text} ${_bodyCtrl.text}".toLowerCase();

    for (var p in _platforms) {
      final name = p['name'] as String;
      if (name == "General") continue;

      // Check if title/content contains the platform name or hashtag
      if (combined.contains(name.toLowerCase())) {
        setState(() {
          _selectedPlatform = name;
        });
        return;
      }
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _bodyCtrl.dispose();
    super.dispose();
  }

  void _updateStats() {
    final text = _bodyCtrl.text.trim();
    if (text.isEmpty) {
      if (mounted)
        setState(() {
          _wordCount = 0;
          _estDuration = "0s";
        });
      return;
    }
    final count = text.split(RegExp(r'\s+')).length;
    final seconds = (count / 140 * 60).ceil();
    final durationStr = seconds < 60
        ? "${seconds}s"
        : "${(seconds / 60).floor()}m ${seconds % 60}s";

    if (mounted)
      setState(() {
        _wordCount = count;
        _estDuration = durationStr;
      });
  }

  Future<void> _pasteFromClipboard() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data?.text != null) {
      _bodyCtrl.text += data!.text!;
      _updateStats();
      ToastService.show("Text pasted");
    }
  }

  String _processContentForSave(String rawContent) {
    // 1. Remove existing platform tags to avoid duplicates (e.g. #YouTube)
    String cleanContent = rawContent;
    for (var p in _platforms) {
      final name = p['name'] as String;
      if (name == "General") continue;
      // Remove "\n\n#Platform" or just "#Platform"
      cleanContent = cleanContent.replaceAll(
        RegExp(r'\n\n#' + name, caseSensitive: false),
        '',
      );
      cleanContent = cleanContent.replaceAll(
        RegExp(r'#' + name, caseSensitive: false),
        '',
      );
    }
    cleanContent = cleanContent.trim();

    // 2. Append new tag if not General
    if (_selectedPlatform != "General") {
      return "$cleanContent\n\n#$_selectedPlatform";
    }

    return cleanContent;
  }

  void _save(BuildContext context) async {
    if (_titleCtrl.text.isEmpty) {
      ToastService.show("Title required");
      return;
    }
    FocusManager.instance.primaryFocus?.unfocus();

    final scriptsProvider = Provider.of<ScriptsProvider>(
      context,
      listen: false,
    );
    final premium = Provider.of<PremiumProvider>(
      context,
      listen: false,
    ).isPremium;

    // Process content to include the platform tag so filters work
    final finalContent = _processContentForSave(_bodyCtrl.text);

    AdHelper.showInterstitialAd(() {
      if (widget.scriptToEdit != null) {
        scriptsProvider.updateScript(
          widget.scriptToEdit!,
          _titleCtrl.text,
          finalContent,
        );
        ToastService.show("Saved");
      } else {
        scriptsProvider.addScript(_titleCtrl.text, finalContent);
        ToastService.show("Created!");
        if (widget.onSaveSuccess != null) widget.onSaveSuccess!();
      }
      Navigator.pop(context);
    }, premium);
  }

  Widget _buildPlatformSelector(bool isDark) {
    return Container(
      height: 50.h,
      margin: EdgeInsets.symmetric(vertical: 10.h),
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        scrollDirection: Axis.horizontal,
        itemCount: _platforms.length,
        separatorBuilder: (_, __) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final p = _platforms[index];
          final isSelected = _selectedPlatform == p['name'];
          final color = p['color'] as Color;

          return GestureDetector(
            onTap: () => setState(() => _selectedPlatform = p['name']),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? color.withOpacity(0.15)
                    : (isDark ? AppColors.darkSurface : AppColors.lightBg),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isSelected
                      ? color
                      : (isDark ? AppColors.borderDark : AppColors.borderLight),
                  width: isSelected ? 1.5 : 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    p['icon'],
                    size: 18.sp,
                    color: isSelected
                        ? color
                        : (isDark ? Colors.grey : Colors.grey.shade600),
                  ),
                  if (isSelected) ...[
                    SizedBox(width: 6.w),
                    Text(
                      p['name'],
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatsBar(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pillColor = isDark ? AppColors.darkSurface : Colors.white;
    final textColor = isDark ? AppColors.textWhite70 : AppColors.textGrey;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      color: isDark ? AppColors.darkBg : AppColors.lightBg,
      child: Row(
        children: [
          _buildPill(Icons.text_fields, "$_wordCount w", pillColor, textColor),
          SizedBox(width: 10.w),
          _buildPill(Icons.timer_outlined, _estDuration, pillColor, textColor),
          const Spacer(),
          InkWell(
            onTap: _pasteFromClipboard,
            borderRadius: BorderRadius.circular(8.r),
            child: Padding(
              padding: EdgeInsets.all(8.0.r),
              child: Row(
                children: [
                  Icon(
                    Icons.paste_rounded,
                    size: 16.sp,
                    color: AppColors.primary,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    "Paste",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPill(IconData icon, String text, Color bg, Color textC) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: bg == Colors.white
              ? AppColors.borderLight
              : Colors.transparent,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14.sp, color: textC),
          SizedBox(width: 6.w),
          Text(
            text,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: textC,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.scriptToEdit != null;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,

      appBar: AdaptiveAppBar(
        title: isEditing ? "Edit Script" : "New Script",
        showBackButton: true,
        actions: [
          TextButton(
            onPressed: () => _save(context),
            child: Text(
              "SAVE",
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: TextField(
                      controller: _titleCtrl,
                      textCapitalization: TextCapitalization.sentences,
                      style: GoogleFonts.manrope(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w800,
                        color: isDark
                            ? AppColors.textWhite
                            : AppColors.textBlack,
                      ),
                      decoration: InputDecoration(
                        hintText: "Script Title...",
                        hintStyle: TextStyle(
                          color: isDark ? Colors.white24 : Colors.grey.shade300,
                          fontWeight: FontWeight.w800,
                          fontSize: 24.sp,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                      left: 24.w,
                      top: 15.h,
                      bottom: 5.h,
                    ),
                    child: Text(
                      "PLATFORM",
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white38 : Colors.grey,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  _buildPlatformSelector(isDark),

                  Divider(height: 30.h),

                  _buildStatsBar(context),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: TextField(
                      controller: _bodyCtrl,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      textCapitalization: TextCapitalization.sentences,
                      style: TextStyle(
                        fontSize: 17.sp,
                        height: 1.6,
                        color: isDark
                            ? AppColors.textWhite70
                            : AppColors.textBlack,
                      ),
                      decoration: InputDecoration(
                        hintText: "Start writing your script here...",
                        hintStyle: TextStyle(
                          color: isDark ? Colors.white24 : Colors.grey.shade400,
                          fontSize: 17.sp,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  SizedBox(height: 300.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
