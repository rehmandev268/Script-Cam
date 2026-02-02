import 'package:flutter/material.dart';
import 'package:flutter_application_6/generated/l10n/app_localizations.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/responsive_config.dart';
import '../../../../core/utils/toast_service.dart';
import '../../../../core/services/ads_service/interstitial_ad_helper.dart';
import '../../../premium/presentation/providers/premium_provider.dart';
import '../../../teleprompter/presentation/pages/teleprompter_screen.dart';
import '../../data/models/script_model.dart';
import '../providers/scripts_provider.dart';
import 'editor_screen.dart';
import '../../../../core/constants/app_constants.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../core/utils/platform_utils.dart';
import '../../../../core/utils/app_dialogs.dart';
import '../../../onboarding/presentation/pages/onboarding_screen.dart';
import '../widgets/premium_badge.dart';
import '../widgets/category_tabs.dart';
import '../widgets/script_card.dart';
import '../widgets/empty_scripts_state.dart';
import '../widgets/script_search_bar.dart';
import '../../../../widgets/ads/custom_native_ad_widget.dart';
import '../../../../core/services/analytics_service.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback? onGoToCreate;
  final double bottomPadding;

  const HomeScreen({super.key, this.onGoToCreate, this.bottomPadding = 20});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = "All";
  final List<String> _categories = [
    "All",
    ...PlatformConfig.platforms.map((p) => p['name'] as String),
  ];
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<double> _scrollProgress = ValueNotifier<double>(0.0);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _scrollProgress.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    // Calculate smooth progress from 0.0 to 1.0 based on scroll offset
    // Transition happens between 0 and 100 pixels for smoother effect
    const double maxScrollForTransition = 100.0;
    final double offset = _scrollController.offset.clamp(
      0.0,
      maxScrollForTransition,
    );
    final double linearProgress = offset / maxScrollForTransition;

    // Apply easing curve for smoother animation (ease-in-out cubic)
    final double easedProgress = linearProgress < 0.5
        ? 4 * linearProgress * linearProgress * linearProgress
        : 1 - pow(-2 * linearProgress + 2, 3) / 2;

    if ((_scrollProgress.value - easedProgress).abs() > 0.005) {
      _scrollProgress.value = easedProgress;
    }
  }

  void _confirmDelete(BuildContext context, Script script, bool isDark) async {
    bool confirm = await AppDialogs.showConfirmDelete(
      context: context,
      title: AppLocalizations.of(context).deleteScriptTitle,
      content: AppLocalizations.of(context).deleteScriptMessage,
      isDark: isDark,
    );
    if (confirm && context.mounted) {
      Provider.of<ScriptsProvider>(context, listen: false).deleteScript(script);
      ToastService.show(AppLocalizations.of(context).scriptDeleted);
    }
  }

  void _handleVideoClick(BuildContext context, Script script) async {
    FocusManager.instance.primaryFocus?.unfocus();

    // Check permissions before proceeding
    final cameraStatus = await Permission.camera.status;
    final micStatus = await Permission.microphone.status;

    if (!cameraStatus.isGranted || !micStatus.isGranted) {
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const OnboardingScreen()),
        );
      }
      return;
    }

    if (!context.mounted) return;
    final premium = Provider.of<PremiumProvider>(
      context,
      listen: false,
    ).isPremium;
    // Navigate immediately
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => TeleprompterScreen(script: script)),
    );

    // Show ad independently
    InterstitialAdHelper.show(isPremium: premium, onComplete: () {});
  }

  void _handleEditClick(BuildContext context, Script script) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EditorScreen(scriptToEdit: script)),
    );
  }

  String _getGreeting(AppLocalizations l10n) {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) return l10n.goodMorning;
    if (hour >= 12 && hour < 17) return l10n.goodAfternoon;
    return l10n.goodEvening;
  }

  String _getEmoji() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) return "☀️";
    if (hour >= 12 && hour < 17) return "🌤️";
    return "🌙";
  }

  void _showQuickRecordBottomSheet(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController contentController = TextEditingController();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    AnalyticsService().logQuickRecordStarted();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: Colors.amber.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.bolt_rounded,
                      color: Colors.amber,
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    l10n.quickRecord,
                    style: GoogleFonts.manrope(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Text(
                l10n.quickRecordDialogDesc,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textGrey,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 24.h),
              _buildFieldLabel(l10n.scriptTitle),
              SizedBox(height: 8.h),
              TextField(
                controller: titleController,
                textCapitalization: TextCapitalization.sentences,
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
                decoration: _buildInputDecoration(l10n.scriptTitleHint, isDark),
              ),
              SizedBox(height: 20.h),
              _buildFieldLabel(l10n.scriptContent),
              SizedBox(height: 8.h),
              TextField(
                controller: contentController,
                maxLines: 5,
                textCapitalization: TextCapitalization.sentences,
                style: TextStyle(fontSize: 15.sp),
                decoration: _buildInputDecoration(
                  l10n.scriptContentHint,
                  isDark,
                ),
              ),
              SizedBox(height: 32.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    final titleInput = titleController.text.trim();
                    final contentInput = contentController.text.trim();
                    final tempScript = Script(
                      createdAt: DateTime.now(),
                      title: titleInput.isEmpty ? l10n.quickRecord : titleInput,
                      content: contentInput.isEmpty ? " " : contentInput,
                      category: 'General',
                    );
                    _handleVideoClick(ctx, tempScript);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 56.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    l10n.startRecording,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textGrey,
        letterSpacing: 0.5,
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hint, bool isDark) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        fontSize: 14.sp,
        color: Colors.grey,
        fontWeight: FontWeight.normal,
      ),
      filled: true,
      fillColor: isDark ? AppColors.darkBg : Colors.grey.shade50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      contentPadding: EdgeInsets.all(16.r),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final topPadding = MediaQuery.of(context).padding.top;
    final premiumProvider = Provider.of<PremiumProvider>(context);
    final l10n = AppLocalizations.of(context);

    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 500));
        if (mounted) setState(() {});
      },
      color: AppColors.primary,
      child: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: false,
            automaticallyImplyLeading: false,
            backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
            elevation: 0,
            scrolledUnderElevation: 2,
            toolbarHeight: 80.h + topPadding,
            titleSpacing: 0,
            title: ValueListenableBuilder<double>(
              valueListenable: _scrollProgress,
              builder: (context, progress, _) {
                return Stack(
                  children: [
                    // Expanded header - fades out as we scroll
                    IgnorePointer(
                      ignoring: progress > 0.3,
                      child: Opacity(
                        opacity: (1.0 - progress * 1.5).clamp(0.0, 1.0),
                        child: Transform.translate(
                          offset: Offset(0, -10 * progress),
                          child: Transform.scale(
                            scale: (1.0 - progress * 0.05).clamp(0.95, 1.0),
                            alignment: Alignment.centerLeft,
                            child: _buildExpandedHeader(
                              isDark,
                              topPadding,
                              l10n,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Collapsed header - fades in as we scroll
                    IgnorePointer(
                      ignoring: progress < 0.3,
                      child: Opacity(
                        opacity: (progress * 1.5 - 0.5).clamp(0.0, 1.0),
                        child: Transform.translate(
                          offset: Offset(0, 10 * (1.0 - progress)),
                          child: Transform.scale(
                            scale: (0.95 + progress * 0.05).clamp(0.95, 1.0),
                            alignment: Alignment.centerLeft,
                            child: _buildCollapsedHeader(
                              isDark,
                              topPadding,
                              l10n,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          // 2. Action Cards, Ads, Search, Tabs
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Action Cards
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildActionCard(
                          title: l10n.newScript,
                          subtitle: l10n.writeFromScratch,
                          icon: Icons.text_snippet,
                          gradient: [AppColors.primary, AppColors.primaryDark],
                          onTap: widget.onGoToCreate,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: _buildActionCard(
                          title: l10n.quickRecord,
                          subtitle: l10n.recordOnTheFly,
                          icon: Icons.videocam_rounded,
                          gradient: [
                            const Color(0xFF63F297),
                            const Color.fromARGB(255, 54, 178, 100),
                          ],
                          onTap: () => _showQuickRecordBottomSheet(context),
                        ),
                      ),
                    ],
                  ),
                ),

                // Native Ad
                if (!premiumProvider.isPremium)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 4.h,
                      horizontal: 20.w,
                    ),
                    child: CustomNativeAdWidget(
                      key: ValueKey("HomeAd_$isDark"),
                      factoryId: 'adFactoryHome',
                      height: 84.h,
                      isGlass: false,
                    ),
                  ),

                // Search Bar
                const ScriptSearchBar(),

                // Projects Header
                Padding(
                  padding: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.myScripts,
                        style: GoogleFonts.manrope(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        l10n.recentFirst,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.textGrey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                // Category Tabs
                CategoryTabs(
                  categories: _categories,
                  selectedCategory: _selectedCategory,
                  onCategorySelected: (cat) {
                    setState(() => _selectedCategory = cat);
                    AnalyticsService().logCategorySelected(cat);
                  },
                ),
                SizedBox(height: 12.h),
              ],
            ),
          ),

          // 3. Scripts List
          Consumer<ScriptsProvider>(
            builder: (context, provider, _) {
              final displayedScripts = provider.getScriptsByCategory(
                _selectedCategory,
              );

              if (displayedScripts.isEmpty) {
                return SliverToBoxAdapter(
                  child: EmptyScriptsState(selectedCategory: _selectedCategory),
                );
              }

              return SliverPadding(
                padding: EdgeInsets.fromLTRB(
                  20.w,
                  4.h,
                  20.w,
                  widget.bottomPadding + 20.h,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return FadeInUp(
                      duration: Duration(
                        milliseconds: 300 + (index * 50).clamp(0, 300),
                      ),
                      child: ScriptCard(
                        script: displayedScripts[index],
                        platformStyle: PlatformConfig.getPlatformStyle(
                          displayedScripts[index].title,
                          displayedScripts[index].content,
                          isDark,
                        ),
                        onTap: () =>
                            _handleEditClick(context, displayedScripts[index]),
                        onRecord: () =>
                            _handleVideoClick(context, displayedScripts[index]),
                        onEdit: () =>
                            _handleEditClick(context, displayedScripts[index]),
                        onDelete: () => _confirmDelete(
                          context,
                          displayedScripts[index],
                          isDark,
                        ),
                      ),
                    );
                  }, childCount: displayedScripts.length),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedHeader(
    bool isDark,
    double topPadding,
    AppLocalizations l10n,
  ) {
    return Container(
      key: const ValueKey('expanded'),
      padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      _getGreeting(l10n),
                      style: GoogleFonts.manrope(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w800,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(_getEmoji(), style: TextStyle(fontSize: 18.sp)),
                  ],
                ),
                Text(
                  l10n.readyToCreate,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: isDark ? Colors.white70 : AppColors.textGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const PremiumBadge(),
          SizedBox(width: 8.w),
          IconButton(
            onPressed: () =>
                AppDialogs.showAppInfo(context: context, isDark: isDark),
            icon: Icon(
              Icons.info_outline_rounded,
              size: 22.sp,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCollapsedHeader(
    bool isDark,
    double topPadding,
    AppLocalizations l10n,
  ) {
    return Container(
      key: const ValueKey('collapsed'),
      padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 15.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Category Dropdown (compact)
          Expanded(
            flex: 2,
            child: Container(
              height: 44.h,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.primary.withValues(alpha: 0.15)
                    : AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedCategory,
                  isExpanded: true,
                  iconSize: 20.sp,
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.primary,
                  ),
                  style: GoogleFonts.manrope(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  dropdownColor: isDark ? AppColors.darkSurface : Colors.white,
                  items: _categories.map((cat) {
                    return DropdownMenuItem(
                      value: cat,
                      child: Text(cat == 'All' ? l10n.all : cat),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => _selectedCategory = val);
                    }
                  },
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          // Quick Action: New Script
          _buildQuickActionButton(
            icon: Icons.add_rounded,
            color: AppColors.primary,
            onTap: widget.onGoToCreate,
          ),
          SizedBox(width: 8.w),
          // Quick Action: Quick Record
          _buildQuickActionButton(
            icon: Icons.videocam_rounded,
            color: const Color(0xFF63F297),
            onTap: () => _showQuickRecordBottomSheet(context),
          ),
          SizedBox(width: 8.w),
          // Premium Badge
          const PremiumBadge(),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton({
    required IconData icon,
    required Color color,
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          width: 44.w,
          height: 44.h,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
          ),
          child: Icon(icon, color: color, size: 22.sp),
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required List<Color> gradient,
    VoidCallback? onTap,
  }) {
    return FadeInDown(
      duration: const Duration(milliseconds: 600),
      child: Container(
        height: 120.h,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(24.r)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24.r),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -10.w,
                      bottom: -10.h,
                      child: Icon(
                        icon,
                        size: 80.sp,
                        color: Colors.white.withValues(alpha: 0.12),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.r),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(8.r),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.25),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(icon, color: Colors.white, size: 22.sp),
                          ),
                          const Spacer(),
                          Text(
                            title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            subtitle,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
