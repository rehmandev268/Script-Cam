import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_6/generated/l10n/app_localizations.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../widgets/common/adaptive_app_bar.dart';
import '../../../../core/utils/app_dialogs.dart';
import '../../../../core/utils/responsive_config.dart';
import '../../../../core/utils/toast_service.dart';
import '../../../onboarding/presentation/pages/onboarding_screen.dart';
import '../../../teleprompter/presentation/pages/teleprompter_screen.dart';
import '../../data/models/script_model.dart';
import '../providers/scripts_provider.dart';
import '../../../../core/services/recent_scripts_service.dart';
import '../widgets/category_tabs.dart';
import '../widgets/empty_scripts_state.dart';
import '../widgets/script_card.dart';
import 'editor_screen.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback? onGoToCreate;
  final double bottomPadding;

  const HomeScreen({super.key, this.onGoToCreate, this.bottomPadding = 20});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _startRecording(Script script) async {
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

    RecentScriptsService.recordUsed(script.key);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => TeleprompterScreen(script: script)),
    );
  }

  void _openEditor([Script? script]) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EditorScreen(scriptToEdit: script)),
    );
  }

  Future<void> _renameScript(Script script) async {
    final l10n = AppLocalizations.of(context);
    final controller = TextEditingController(text: script.title);
    final value = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Rename Script'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(hintText: l10n.scriptTitleHint),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, controller.text.trim()),
            child: Text(l10n.save),
          ),
        ],
      ),
    );

    if (!mounted || value == null || value.isEmpty || value == script.title) {
      return;
    }
    context.read<ScriptsProvider>().updateScript(
      script,
      value,
      script.content,
      script.category,
    );
    ToastService.show('Script renamed');
  }

  Future<void> _duplicateScript(Script script) async {
    HapticFeedback.lightImpact();
    final copy = await context.read<ScriptsProvider>().addScriptAndReturn(
      '${script.title} Copy',
      script.content,
      script.category,
    );
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EditorScreen(scriptToEdit: copy)),
    );
  }

  Future<void> _deleteScript(Script script) async {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final confirm = await AppDialogs.showConfirmDelete(
      context: context,
      title: l10n.deleteScriptTitle,
      content: l10n.deleteScriptMessage,
      isDark: isDark,
    );
    if (!mounted || !confirm) return;
    HapticFeedback.mediumImpact();
    context.read<ScriptsProvider>().deleteScript(script);
    ToastService.show(l10n.scriptDeleted);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      appBar: AdaptiveAppBar(
        title: l10n.tabScripts,
        showBackButton: false,
        actions: [
          TextButton.icon(
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary,
            ),
            onPressed: () => _openEditor(),
            icon: Icon(Icons.add_rounded, size: 22.sp),
            label: Text(
              l10n.newScript,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
              child: TextField(
                controller: _searchController,
                onChanged: (value) =>
                    context.read<ScriptsProvider>().setSearchQuery(value.trim()),
                decoration: InputDecoration(
                  hintText: l10n.searchScripts,
                  prefixIcon: const Icon(Icons.search_rounded),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Consumer<ScriptsProvider>(
              builder: (context, provider, _) {
                // Build category list: All + any category that has at least one script
                final usedCategories = provider.scripts
                    .map((s) => s.category)
                    .toSet()
                    .where((c) => c.isNotEmpty)
                    .toList()
                  ..sort();
                final tabs = [
                  'All',
                  ...usedCategories.where((c) => c != 'All'),
                ];
                return CategoryTabs(
                  categories: tabs,
                  selectedCategory: _selectedCategory,
                  onCategorySelected: (cat) =>
                      setState(() => _selectedCategory = cat),
                );
              },
            ),
            SizedBox(height: 8.h),
            Expanded(
              child: Consumer<ScriptsProvider>(
                builder: (context, provider, _) {
                  final scripts = provider.getScriptsByCategory(_selectedCategory);
                  if (scripts.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: EmptyScriptsState(selectedCategory: _selectedCategory),
                    );
                  }
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, widget.bottomPadding),
                    itemCount: scripts.length,
                    itemBuilder: (context, index) {
                      final script = scripts[index];
                      return ScriptCard(
                        script: script,
                        platformStyle: {
                          'color': AppColors.primary,
                          'icon': Icons.description_outlined,
                          'name': script.category.isEmpty ? 'General' : script.category,
                        },
                        onTap: () => _openEditor(script),
                        onRecord: () => _startRecording(script),
                        onEdit: () => _openEditor(script),
                        onRename: () => _renameScript(script),
                        onDuplicate: () => _duplicateScript(script),
                        onDelete: () => _deleteScript(script),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
