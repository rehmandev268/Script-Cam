import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/responsive_config.dart';
import '../../../../core/utils/toast_service.dart';
import '../../../../core/services/ad_manager.dart';
import '../../../../widgets/common/adaptive_app_bar.dart';
import '../../../premium/presentation/providers/premium_provider.dart';
import '../../../premium/presentation/screen/premium_screen.dart';
import '../../../teleprompter/presentation/pages/teleprompter_screen.dart';
import '../../data/models/script_model.dart';
import '../providers/scripts_provider.dart';
import 'editor_screen.dart';
import '../../../../core/constants/app_constants.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback? onGoToCreate;

  const HomeScreen({super.key, this.onGoToCreate});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = "All";
  final List<String> _categories = [
    "All",
    "General",
    "YouTube",
    "Instagram",
    "TikTok",
    "LinkedIn",
  ];

  void _confirmDelete(BuildContext context, Script script) async {
    bool confirm =
        await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("Delete Script?", style: TextStyle(fontSize: 18.sp)),
            content: Text(
              "This action cannot be undone.",
              style: TextStyle(fontSize: 14.sp),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text("Cancel", style: TextStyle(fontSize: 14.sp)),
              ),
              TextButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: Text(
                  "Delete",
                  style: TextStyle(color: Colors.red, fontSize: 14.sp),
                ),
              ),
            ],
          ),
        ) ??
        false;

    if (confirm && context.mounted) {
      Provider.of<ScriptsProvider>(context, listen: false).deleteScript(script);
      ToastService.show("Script deleted");
    }
  }

  void _handleVideoClick(BuildContext context, Script script) {
    FocusManager.instance.primaryFocus?.unfocus();
    final premium = Provider.of<PremiumProvider>(
      context,
      listen: false,
    ).isPremium;
    AdHelper.showInterstitialAd(() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => TeleprompterScreen(script: script)),
      );
    }, premium);
  }

  void _handleEditClick(BuildContext context, Script script) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EditorScreen(scriptToEdit: script)),
    );
  }

  Widget _buildPremiumBadge(BuildContext context) {
    final isPremium = Provider.of<PremiumProvider>(context).isPremium;
    if (isPremium) return const SizedBox.shrink();

    return Center(
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const PremiumScreen()),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.premium, Colors.orange],
            ),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star_rounded, size: 14.sp, color: Colors.white),
              SizedBox(width: 4.w),
              Text(
                "PRO",
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 0.5.w,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return FadeInDown(
      duration: const Duration(milliseconds: 600),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        height: 100.h,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onGoToCreate,
            borderRadius: BorderRadius.circular(24.r),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryVariant],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.4),
                    blurRadius: 20.r,
                    offset: Offset(0, 10.h),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -10.w,
                    bottom: -10.h,
                    child: Icon(
                      Icons.movie_creation_outlined,
                      size: 90.sp,
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12.r),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 26.sp,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Create New Script",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              "Select platform & start writing",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
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
    );
  }

  Widget _buildCategoryTabs(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 36.h,
      margin: EdgeInsets.only(bottom: 10.h),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final catName = _categories[index];
          final isSelected = _selectedCategory == catName;

          final bg = isSelected
              ? AppColors.primary
              : (isDark ? AppColors.darkSurface : AppColors.lightSurface);

          final textC = isSelected
              ? Colors.white
              : (isDark ? AppColors.textGrey : AppColors.textGrey);

          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = catName),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: EdgeInsets.only(right: 10.w),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(18.r),
                border: Border.all(
                  color: isSelected
                      ? Colors.transparent
                      : (isDark ? AppColors.borderDark : AppColors.borderLight),
                ),
              ),
              child: Center(
                child: Text(
                  catName,
                  style: TextStyle(
                    color: textC,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildScriptCard(BuildContext context, Script script) {
    final wordCount = script.content.split(' ').length;
    final readTime = (wordCount / 130).ceil();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // --- LOGIC FIXED HERE ---
    String platformText = "GENERAL";
    Color platformColor = Colors.grey;

    // Check both title AND content for platform keywords
    final combinedText = "${script.title} ${script.content}".toLowerCase();

    if (combinedText.contains("youtube")) {
      platformText = "YOUTUBE";
      platformColor = const Color(0xFFFF0000); // YouTube Red
    } else if (combinedText.contains("instagram") ||
        combinedText.contains("insta")) {
      platformText = "INSTAGRAM";
      platformColor = const Color(0xFFE1306C); // Instagram Pink
    } else if (combinedText.contains("tiktok")) {
      platformText = "TIKTOK";
      platformColor = Colors.black;
      if (isDark) platformColor = const Color(0xFF00F2EA); // Cyan for dark mode
    } else if (combinedText.contains("linkedin")) {
      platformText = "LINKEDIN";
      platformColor = const Color(0xFF0077B5); // LinkedIn Blue
    }

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.03),
            blurRadius: 15.r,
            offset: Offset(0, 5.h),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _handleEditClick(context, script),
        borderRadius: BorderRadius.circular(20.r),
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withOpacity(0.05)
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.article_rounded,
                      color: isDark ? Colors.white70 : Colors.black87,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          script.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.manrope(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: isDark
                                ? AppColors.textWhite
                                : AppColors.textBlack,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "$readTime min read • $wordCount words",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.textGrey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildMenuButton(context, script),
                ],
              ),
              SizedBox(height: 16.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Platform Badge
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: platformColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      platformText,
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: platformColor,
                      ),
                    ),
                  ),

                  Material(
                    color: AppColors.accent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30.r),
                    child: InkWell(
                      onTap: () => _handleVideoClick(context, script),
                      borderRadius: BorderRadius.circular(30.r),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 8.h,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.videocam_rounded,
                              size: 16.sp,
                              color: AppColors.accent,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              "Record",
                              style: TextStyle(
                                color: AppColors.accent,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, Script script) {
    return SizedBox(
      width: 24.w,
      height: 24.h,
      child: PopupMenuButton<String>(
        padding: EdgeInsets.zero,
        icon: Icon(Icons.more_vert, color: AppColors.textGrey, size: 20.sp),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        onSelected: (value) {
          if (value == 'delete') _confirmDelete(context, script);
          if (value == 'edit') _handleEditClick(context, script);
        },
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 'edit',
            child: Text("Edit", style: TextStyle(fontSize: 14.sp)),
          ),
          PopupMenuItem(
            value: 'delete',
            child: Text(
              "Delete",
              style: TextStyle(color: Colors.red, fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50.h),
          Icon(Icons.filter_list_off, size: 50.sp, color: Colors.grey.shade400),
          SizedBox(height: 10.h),
          Text(
            "No scripts in '$_selectedCategory'",
            style: TextStyle(
              color: isDark ? Colors.white70 : Colors.grey.shade600,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,

      appBar: AdaptiveAppBar(
        title: "ScriptFlow",
        showBackButton: false,
        actions: [_buildPremiumBadge(context)],
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(bottom: 120.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeroSection(context),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
                child: Text(
                  "Recent Projects",
                  style: GoogleFonts.manrope(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.textWhite : AppColors.textBlack,
                  ),
                ),
              ),

              _buildCategoryTabs(context),

              Consumer<ScriptsProvider>(
                builder: (context, provider, _) {
                  final displayedScripts = provider.getScriptsByCategory(
                    _selectedCategory,
                  );

                  if (displayedScripts.isEmpty) {
                    return _buildEmptyState(context);
                  }

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: List.generate(displayedScripts.length, (index) {
                        return FadeInUp(
                          duration: const Duration(milliseconds: 300),
                          child: _buildScriptCard(
                            context,
                            displayedScripts[index],
                          ),
                        );
                      }),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
