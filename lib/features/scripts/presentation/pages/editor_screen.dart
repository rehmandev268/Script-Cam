import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/responsive_config.dart';
import '../../../../core/utils/toast_service.dart';
import '../../../../core/services/ads_service/interstitial_ad_helper.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../widgets/common/adaptive_app_bar.dart';
import '../../../premium/presentation/providers/premium_provider.dart';
import '../../data/models/script_model.dart';
import '../providers/scripts_provider.dart';
import '../widgets/editor/platform_selector.dart';
import '../widgets/editor/editor_stats_bar.dart';
import '../../../../core/utils/platform_utils.dart';
import '../../../../core/services/analytics_service.dart';

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
  final List<Map<String, dynamic>> _platforms = PlatformConfig.platforms;

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
      AnalyticsService().logScriptViewed(
        scriptId: widget.scriptToEdit!.key?.toString() ?? 'unknown',
        title: widget.scriptToEdit!.title,
        category: widget.scriptToEdit!.category,
      );
    }
    _bodyCtrl.addListener(_updateStats);
  }

  void _detectPlatformFromContent() {
    final combined = "${_titleCtrl.text} ${_bodyCtrl.text}".toLowerCase();

    for (var p in _platforms) {
      final name = p['name'] as String;
      if (name == "General") continue;

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
    String cleanContent = rawContent;
    for (var p in _platforms) {
      final name = p['name'] as String;
      if (name == "General") continue;

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

    final finalContent = _processContentForSave(_bodyCtrl.text);

    InterstitialAdHelper.show(
      isPremium: premium,
      onComplete: () {
        if (widget.scriptToEdit != null) {
          scriptsProvider.updateScript(
            widget.scriptToEdit!,
            _titleCtrl.text.trim(),
            finalContent,
            _selectedPlatform,
          );
          ToastService.show("Saved");
        } else {
          scriptsProvider.addScript(
            _titleCtrl.text.trim(),
            finalContent,
            _selectedPlatform,
          );
          ToastService.show("Created!");
          if (widget.onSaveSuccess != null) widget.onSaveSuccess!();
        }
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.scriptToEdit != null;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : Colors.white,

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
                      ),

                      decoration: InputDecoration(
                        filled: false,
                        hintText: "Script Title...",
                        hintStyle: TextStyle(
                          color: AppColors.textGrey.withOpacity(0.3),
                          fontWeight: FontWeight.w800,
                          fontSize: 24.sp,
                        ),

                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
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
                        color: AppColors.textGrey,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  PlatformSelector(
                    platforms: _platforms,
                    selectedPlatform: _selectedPlatform,
                    onPlatformSelected: (platform) =>
                        setState(() => _selectedPlatform = platform),
                    isDark: isDark,
                  ),

                  SizedBox(height: 10.h),

                  EditorStatsBar(
                    wordCount: _wordCount,
                    estDuration: _estDuration,
                    onPaste: _pasteFromClipboard,
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: TextField(
                      controller: _bodyCtrl,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      textCapitalization: TextCapitalization.sentences,
                      style: TextStyle(fontSize: 17.sp, height: 1.6),
                      decoration: InputDecoration(
                        filled: false,
                        hintText: "Start writing your script here...",
                        hintStyle: TextStyle(
                          color: AppColors.textGrey.withOpacity(0.4),
                          fontSize: 17.sp,
                        ),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
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
