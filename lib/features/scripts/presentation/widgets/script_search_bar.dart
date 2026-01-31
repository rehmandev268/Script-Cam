import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/responsive_config.dart';
import '../providers/scripts_provider.dart';

class ScriptSearchBar extends StatefulWidget {
  const ScriptSearchBar({super.key});

  @override
  State<ScriptSearchBar> createState() => _ScriptSearchBarState();
}

class _ScriptSearchBarState extends State<ScriptSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      child: Container(
        height: 54.h,
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
            width: 1,
          ),
        ),
        child: TextField(
          controller: _controller,
          onChanged: (v) => context.read<ScriptsProvider>().setSearchQuery(v),
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            hintText: "Search your scripts...",
            hintStyle: TextStyle(
              color: AppColors.textGrey.withValues(alpha: 0.6),
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: Container(
              margin: EdgeInsets.all(12.r),
              padding: EdgeInsets.all(4.r),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.search_rounded,
                color: AppColors.primary,
                size: 20.sp,
              ),
            ),
            suffixIcon: _controller.text.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      Icons.close_rounded,
                      size: 20.sp,
                      color: AppColors.textGrey,
                    ),
                    onPressed: () {
                      _controller.clear();
                      context.read<ScriptsProvider>().setSearchQuery("");
                      setState(() {});
                    },
                  )
                : null,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 16.h),
          ),
        ),
      ),
    );
  }
}
