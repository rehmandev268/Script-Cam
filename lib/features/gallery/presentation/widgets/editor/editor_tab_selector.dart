import 'package:flutter/material.dart';
import 'package:flutter_application_6/core/utils/responsive_config.dart';
import 'package:flutter_application_6/core/constants/app_constants.dart';
import '../../pages/video_editor_screen.dart';

class EditorTabSelector extends StatelessWidget {
  final EditorTab activeTab;
  final ValueChanged<EditorTab> onTabChanged;

  const EditorTabSelector({
    super.key,
    required this.activeTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        border: Border(top: BorderSide(color: Colors.white12, width: 1)),
      ),
      height: 70.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _TabItem(
            icon: Icons.cut_outlined,
            label: "Trim",
            tab: EditorTab.trim,
            isActive: activeTab == EditorTab.trim,
            onTap: () => onTabChanged(EditorTab.trim),
          ),
          _TabItem(
            icon: Icons.aspect_ratio,
            label: "Ratio",
            tab: EditorTab.ratio,
            isActive: activeTab == EditorTab.ratio,
            onTap: () => onTabChanged(EditorTab.ratio),
          ),
          _TabItem(
            icon: Icons.tune,
            label: "Adjust",
            tab: EditorTab.adjust,
            isActive: activeTab == EditorTab.adjust,
            onTap: () => onTabChanged(EditorTab.adjust),
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final EditorTab tab;
  final bool isActive;
  final VoidCallback onTap;

  const _TabItem({
    required this.icon,
    required this.label,
    required this.tab,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActive ? AppColors.primary : Colors.grey,
            size: 24.sp,
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              color: isActive ? AppColors.primary : Colors.grey,
              fontSize: 11.sp,
            ),
          ),
        ],
      ),
    );
  }
}
