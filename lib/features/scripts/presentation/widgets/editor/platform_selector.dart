import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/utils/responsive_config.dart';

class PlatformSelector extends StatelessWidget {
  final List<Map<String, dynamic>> platforms;
  final String selectedPlatform;
  final Function(String) onPlatformSelected;
  final bool isDark;

  const PlatformSelector({
    super.key,
    required this.platforms,
    required this.selectedPlatform,
    required this.onPlatformSelected,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42.h,
      margin: EdgeInsets.symmetric(vertical: 12.h),
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        scrollDirection: Axis.horizontal,
        itemCount: platforms.length,
        separatorBuilder: (_, __) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final p = platforms[index];
          final isSelected = selectedPlatform == p['name'];

          BoxDecoration decoration;

          if (isSelected) {
            if (p['gradient'] != null) {
              decoration = BoxDecoration(
                gradient: p['gradient'],
                borderRadius: BorderRadius.circular(21.r),
              );
            } else {
              Color bg = p['color'];
              if (isDark && p.containsKey('darkModeColor')) {
                bg = p['darkModeColor'];
              }
              decoration = BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(21.r),
              );
            }
          } else {
            decoration = BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(21.r),
              border: Border.all(
                color: isDark ? Colors.white24 : Colors.grey.shade300,
                width: 1.5,
              ),
            );
          }

          Color contentColor;
          Color iconColor;

          if (isSelected) {
            if (isDark && p.containsKey('darkModeText')) {
              contentColor = p['darkModeText'];
            } else {
              contentColor = p['textColor'];
            }
            iconColor = contentColor;
          } else {
            contentColor = isDark ? Colors.white60 : Colors.grey.shade600;
            if (p['name'] == 'General') {
              iconColor = isDark ? Colors.white60 : Colors.grey.shade600;
            } else {
              Color brandColor = p['color'];
              if (isDark && p.containsKey('darkModeColor')) {
                brandColor = p['darkModeColor'];
              }
              if (p['name'] == 'TikTok' && !isDark) {
                iconColor = Colors.black87;
              } else {
                iconColor = brandColor;
              }
            }
          }

          return GestureDetector(
            onTap: () => onPlatformSelected(p['name']),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              alignment: Alignment.center,
              decoration: decoration,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FaIcon(p['icon'], size: 14.sp, color: iconColor),
                  SizedBox(width: 8.w),
                  Text(
                    p['name'],
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: contentColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
