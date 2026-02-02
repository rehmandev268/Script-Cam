import 'package:flutter/material.dart';
import 'package:flutter_application_6/generated/l10n/app_localizations.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/responsive_config.dart';
import '../../data/models/script_model.dart';

class ScriptMenuButton extends StatelessWidget {
  final Script script;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ScriptMenuButton({
    super.key,
    required this.script,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return PopupMenuButton<String>(
      padding: EdgeInsets.zero,
      icon: Icon(Icons.more_vert, color: AppColors.textGrey, size: 22.sp),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      elevation: 0,
      offset: const Offset(0, 40),
      onSelected: (value) {
        if (value == 'delete') onDelete();
        if (value == 'edit') onEdit();
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'edit',
          child: Row(
            children: [
              Icon(Icons.edit_rounded, size: 18.sp, color: AppColors.primary),
              SizedBox(width: 12.w),
              Text(
                l10n.edit,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              Icon(
                Icons.delete_outline_rounded,
                size: 18.sp,
                color: Colors.red,
              ),
              SizedBox(width: 12.w),
              Text(
                l10n.delete,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
