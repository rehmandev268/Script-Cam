import 'package:flutter/material.dart';
import 'package:flutter_application_6/generated/l10n/app_localizations.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/responsive_config.dart';
import '../../../../core/utils/toast_service.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../widgets/common/adaptive_app_bar.dart';
import '../../data/models/script_model.dart';
import '../providers/scripts_provider.dart';
import '../widgets/editor/editor_stats_bar.dart';
import '../../../../core/services/analytics_service.dart';
import '../../../../core/services/file_service.dart';
import '../../../onboarding/presentation/pages/onboarding_screen.dart';
import '../../../teleprompter/presentation/pages/teleprompter_screen.dart';

/// Result when [EditorScreen.saveReturnsToTeleprompterOnly] is true (session script).
///
/// When [persistedScript] is set, teleprompter should bind to this Hive-backed [Script].
class TeleprompterScriptEditResult {
  final String title;
  final String content;
  final Script? persistedScript;

  TeleprompterScriptEditResult({
    required this.title,
    required this.content,
    this.persistedScript,
  });
}

class EditorScreen extends StatefulWidget {
  final Script? scriptToEdit;
  final VoidCallback? onSaveSuccess;

  /// Prefills title/body when there is no [scriptToEdit] but user opened from recording.
  final String? teleprompterInitialTitle;
  final String? teleprompterInitialContent;

  /// Saves only return to caller (no Hive); used for scripts not yet in the library.
  final bool saveReturnsToTeleprompterOnly;

  const EditorScreen({
    super.key,
    this.scriptToEdit,
    this.onSaveSuccess,
    this.teleprompterInitialTitle,
    this.teleprompterInitialContent,
    this.saveReturnsToTeleprompterOnly = false,
  });

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

const List<String> kScriptCategories = [
  'General',
  'YouTube',
  'Podcast',
  'Sales',
  'Education',
  'Social Media',
  'Interview',
  'Other',
];

const List<Map<String, String>> kScriptTemplates = [
  {
    'title': 'YouTube Intro',
    'category': 'YouTube',
    'content':
        'Hey everyone, welcome back to my channel!\n\nToday we\'re diving into [TOPIC]. If you\'re new here, make sure to subscribe and hit the bell so you never miss a video.\n\nLet\'s get started!',
  },
  {
    'title': 'Product Pitch',
    'category': 'Sales',
    'content':
        'Are you struggling with [PROBLEM]?\n\nIntroducing [PRODUCT] — the solution that [KEY BENEFIT].\n\nHere\'s how it works: [EXPLANATION].\n\nJoin thousands of happy customers. Try it free today.',
  },
  {
    'title': 'Podcast Intro',
    'category': 'Podcast',
    'content':
        'Welcome to [PODCAST NAME], the show where we [SHOW PREMISE].\n\nI\'m your host, [NAME]. Today\'s guest is [GUEST NAME], who is [GUEST INTRO].\n\nLet\'s jump right in.',
  },
  {
    'title': 'Social Media Reel',
    'category': 'Social Media',
    'content':
        '[HOOK — surprising fact or bold statement]\n\nHere\'s what most people don\'t know about [TOPIC]:\n\n1. [POINT ONE]\n2. [POINT TWO]\n3. [POINT THREE]\n\nSave this for later and follow for more!',
  },
  {
    'title': 'Self Introduction',
    'category': 'General',
    'content':
        'Hi, my name is [NAME] and I\'m a [ROLE/PROFESSION] based in [LOCATION].\n\nI specialize in [SKILLS/EXPERTISE], and I\'m passionate about [INTEREST].\n\nI\'m excited to [PURPOSE OF VIDEO].',
  },
  {
    'title': 'Educational Explainer',
    'category': 'Education',
    'content':
        'Have you ever wondered about [TOPIC]?\n\nToday I\'m going to explain [CONCEPT] in a way that\'s easy to understand.\n\nFirst, let\'s cover [POINT 1].\n\nNext, [POINT 2].\n\nFinally, [POINT 3].\n\nNow you know everything you need about [TOPIC].',
  },
  {
    'title': 'Interview Answer',
    'category': 'Interview',
    'content':
        'That\'s a great question.\n\nIn my previous role at [COMPANY], I was responsible for [RESPONSIBILITY].\n\nOne challenge I faced was [CHALLENGE]. I approached it by [ACTION].\n\nThe result was [OUTCOME], which taught me [LESSON].',
  },
];

class _EditorScreenState extends State<EditorScreen> {
  String _selectedCategory = 'General';

  final _titleCtrl = TextEditingController();
  final _bodyCtrl = TextEditingController();

  int _wordCount = 0;
  int _estDurationSeconds = 0;

  @override
  void initState() {
    super.initState();
    AnalyticsService().logEditorOpened(
      isEditing:
          widget.scriptToEdit != null || widget.saveReturnsToTeleprompterOnly,
    );
    if (widget.scriptToEdit != null) {
      _titleCtrl.text = widget.scriptToEdit!.title;
      _bodyCtrl.text = widget.scriptToEdit!.content;
      _selectedCategory = kScriptCategories.contains(widget.scriptToEdit!.category)
          ? widget.scriptToEdit!.category
          : 'General';
      _updateStats();
      AnalyticsService().logScriptViewed(
        scriptId: widget.scriptToEdit!.key?.toString() ?? 'unknown',
        title: widget.scriptToEdit!.title,
        category: widget.scriptToEdit!.category,
      );
    } else if (widget.saveReturnsToTeleprompterOnly) {
      _titleCtrl.text = widget.teleprompterInitialTitle ?? '';
      _bodyCtrl.text = widget.teleprompterInitialContent ?? '';
      _updateStats();
    }
    _bodyCtrl.addListener(_updateStats);
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
      if (mounted) {
        setState(() {
          _wordCount = 0;
          _estDurationSeconds = 0;
        });
      }
      return;
    }
    final count = text.split(RegExp(r'\s+')).length;
    final seconds = (count / 140 * 60).ceil();

    if (mounted) {
      setState(() {
        _wordCount = count;
        _estDurationSeconds = seconds;
      });
    }
  }

  void _showTemplates() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 8.h),
            child: Text(
              'Templates',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
          ),
          SizedBox(
            height: 320.h,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
              itemCount: kScriptTemplates.length,
              itemBuilder: (_, i) {
                final t = kScriptTemplates[i];
                return ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  leading: Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(Icons.description_outlined,
                        color: AppColors.primary, size: 20.sp),
                  ),
                  title: Text(
                    t['title']!,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  subtitle: Text(
                    t['category']!,
                    style: TextStyle(
                        fontSize: 12.sp, color: AppColors.textGrey),
                  ),
                  onTap: () {
                    Navigator.pop(ctx);
                    if (_titleCtrl.text.isEmpty) {
                      _titleCtrl.text = t['title']!;
                    }
                    _bodyCtrl.text = t['content']!;
                    setState(() {
                      if (kScriptCategories.contains(t['category'])) {
                        _selectedCategory = t['category']!;
                      }
                    });
                    _updateStats();
                  },
                );
              },
            ),
          ),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }

  Future<void> _pasteFromClipboard() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data?.text != null) {
      _bodyCtrl.text += data!.text!;
      _updateStats();
      AnalyticsService().logScriptPasted(wordCount: _wordCount);
      if (!mounted) return;
      ToastService.show(AppLocalizations.of(context).textPasted);
    }
  }

  Future<void> _handleImport() async {
    final result = await FileService.importScript();
    if (result != null && mounted) {
      if (_titleCtrl.text.isEmpty) {
        _titleCtrl.text = result['title']!;
      }
      _bodyCtrl.text = result['content']!;
      _updateStats();
      AnalyticsService().logScriptImported(
        source: 'file',
        wordCount: _wordCount,
      );
      ToastService.show(AppLocalizations.of(context).importSuccess);
    }
  }

  /// Trims body and strips a legacy trailing hashtag line (e.g. `#YouTube`).
  String _normalizeScriptBody(String raw) {
    var s = raw.trim();
    s = s.replaceFirst(RegExp(r'\s*\n+#\w+\s*$', caseSensitive: false), '');
    return s.trim();
  }

  Future<void> _save(BuildContext context) async {
    if (_titleCtrl.text.isEmpty) {
      ToastService.show(AppLocalizations.of(context).titleRequired);
      return;
    }
    FocusManager.instance.primaryFocus?.unfocus();

    final scriptsProvider = Provider.of<ScriptsProvider>(
      context,
      listen: false,
    );

    final finalContent = _normalizeScriptBody(_bodyCtrl.text);

    if (widget.saveReturnsToTeleprompterOnly) {
      try {
        final saved = await scriptsProvider.addScriptAndReturn(
          _titleCtrl.text.trim(),
          finalContent,
          _selectedCategory,
        );
        if (!context.mounted) return;
        ToastService.show(AppLocalizations.of(context).created);
        Navigator.pop(
          context,
          TeleprompterScriptEditResult(
            title: saved.title,
            content: saved.content,
            persistedScript: saved,
          ),
        );
      } catch (_) {
        if (!context.mounted) return;
        ToastService.show(
          AppLocalizations.of(context).unexpectedErrorDesc,
          isError: true,
        );
      }
      return;
    }

    if (widget.scriptToEdit != null) {
      scriptsProvider.updateScript(
        widget.scriptToEdit!,
        _titleCtrl.text.trim(),
        finalContent,
        _selectedCategory,
      );
      AnalyticsService().logScriptEdited(
        scriptId: widget.scriptToEdit!.key?.toString() ?? 'unknown',
        title: _titleCtrl.text.trim(),
        category: _selectedCategory,
        wordCount: _wordCount,
      );
      ToastService.show(AppLocalizations.of(context).saved);
    } else {
      scriptsProvider.addScript(
        _titleCtrl.text.trim(),
        finalContent,
        _selectedCategory,
      );
      AnalyticsService().logScriptCreated(
        scriptId: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleCtrl.text.trim(),
        category: _selectedCategory,
        wordCount: _wordCount,
      );
      ToastService.show(AppLocalizations.of(context).created);
      if (widget.onSaveSuccess != null) widget.onSaveSuccess!();
    }
    Navigator.pop(context);
  }

  Future<void> _recordFromEditor() async {
    final cameraStatus = await Permission.camera.status;
    final micStatus = await Permission.microphone.status;
    if (!mounted) return;

    if (!cameraStatus.isGranted || !micStatus.isGranted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
      return;
    }

    final title = _titleCtrl.text.trim();
    final content = _bodyCtrl.text.trim();
    final script = Script(
      title: title.isEmpty ? 'Untitled Script' : title,
      content: content.isEmpty ? ' ' : _normalizeScriptBody(content),
      createdAt: DateTime.now(),
      category: _selectedCategory,
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => TeleprompterScreen(script: script)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isEditing = widget.scriptToEdit != null;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final appBarTitle = isEditing || widget.saveReturnsToTeleprompterOnly
        ? l10n.editScript
        : l10n.newScript;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : Colors.white,

      appBar: AdaptiveAppBar(
        title: appBarTitle,
        showBackButton: true,
        actions: [
          if (!widget.saveReturnsToTeleprompterOnly)
            IconButton(
              icon: Icon(
                Icons.videocam_rounded,
                color: AppColors.primary,
                size: 22.sp,
              ),
              onPressed: _recordFromEditor,
              tooltip: l10n.startRecording,
            ),
          if (isEditing)
            IconButton(
              icon: Icon(
                Icons.file_download_outlined,
                color: AppColors.primary,
                size: 22.sp,
              ),
              onPressed: () async {
                final l10n = AppLocalizations.of(context);
                await FileService.exportScript(
                  _titleCtrl.text,
                  _bodyCtrl.text,
                  shareSubject: l10n.exportedScriptSubject(_titleCtrl.text),
                );
                AnalyticsService().logScriptExported(
                  scriptId: widget.scriptToEdit?.key?.toString() ?? 'unknown',
                );
                if (mounted) {
                  ToastService.show(l10n.exportSuccess);
                }
              },
            ),
          TextButton(
            onPressed: () => _save(context),
            child: Text(
              l10n.save,
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
                        hintText: l10n.scriptTitlePlaceholder,
                        hintStyle: TextStyle(
                          color: AppColors.textGrey.withValues(alpha: 0.3),
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

                  SizedBox(height: 16.h),

                  EditorStatsBar(
                    wordCount: _wordCount,
                    durationSeconds: _estDurationSeconds,
                    onPaste: _pasteFromClipboard,
                    onImport: _handleImport,
                    onTemplates: widget.scriptToEdit == null
                        ? _showTemplates
                        : null,
                  ),

                  SizedBox(height: 12.h),
                  SizedBox(
                    height: 36.h,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: kScriptCategories.length,
                      itemBuilder: (context, i) {
                        final cat = kScriptCategories[i];
                        final selected = cat == _selectedCategory;
                        final isDark = Theme.of(context).brightness == Brightness.dark;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedCategory = cat),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: EdgeInsets.only(right: 8.w),
                            padding: EdgeInsets.symmetric(horizontal: 14.w),
                            decoration: BoxDecoration(
                              color: selected
                                  ? AppColors.primary
                                  : (isDark ? AppColors.darkSurface : AppColors.lightBg),
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(
                                color: selected
                                    ? AppColors.primary
                                    : (isDark ? AppColors.borderDark : AppColors.borderLight),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                cat,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: selected ? Colors.white : AppColors.textGrey,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16.h),

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
                        hintText: l10n.scriptContentPlaceholder,
                        hintStyle: TextStyle(
                          color: AppColors.textGrey.withValues(alpha: 0.4),
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
