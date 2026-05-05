import 'package:flutter/material.dart';
import 'package:flutter_application_6/core/utils/responsive_config.dart';
import 'package:flutter_application_6/generated/l10n/app_localizations.dart';
import 'package:easy_video_editor/easy_video_editor.dart';
import 'package:flutter_application_6/core/constants/app_constants.dart';

class ExportDialog extends StatefulWidget {
  final Function(String name, VideoResolution quality) onExport;
  const ExportDialog({super.key, required this.onExport});

  @override
  State<ExportDialog> createState() => _ExportDialogState();
}

class _ExportDialogState extends State<ExportDialog> {
  final TextEditingController _nameController = TextEditingController();
  VideoResolution _selectedQuality = VideoResolution.p720;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  } 

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final titleColor = isDark ? Colors.white : AppColors.textBlack;
    final secondaryColor = isDark ? Colors.white70 : AppColors.textGrey;
    final inputBg = isDark
        ? Colors.black45
        : Colors.black.withValues(alpha: 0.05);
    return AlertDialog(
      backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16).r),
      title: Text(
        l10n.saveVideo,
        style: TextStyle(color: titleColor, fontSize: 18.sp),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.videoName,
            style: TextStyle(color: secondaryColor, fontSize: 12.sp),
          ),
          SizedBox(height: 8.h),
          TextField(
            controller: _nameController,
            style: TextStyle(color: titleColor),
            decoration: InputDecoration(
              hintText: l10n.videoNameHint,
              hintStyle: TextStyle(
                color: isDark ? Colors.white30 : Colors.black38,
              ),
              filled: true,
              fillColor: inputBg,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8).r,
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ).r,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            l10n.qualityLabel,
            style: TextStyle(color: secondaryColor, fontSize: 12.sp),
          ),
          SizedBox(height: 8.h),
          DropdownButtonFormField<VideoResolution>(
            initialValue: _selectedQuality,
            dropdownColor:
                isDark ? const Color(0xFF2C2C2C) : AppColors.lightSurface,
            decoration: InputDecoration(
              filled: true,
              fillColor: inputBg,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8).r,
                borderSide: BorderSide.none,
              ),
            ),
            items: [
              DropdownMenuItem(
                value: VideoResolution.p480,
                child: Text(
                  l10n.qualityLow,
                  style: TextStyle(color: titleColor),
                ),
              ),
              DropdownMenuItem(
                value: VideoResolution.p720,
                child: Text(
                  l10n.qualityStandard,
                  style: TextStyle(color: titleColor),
                ),
              ),
              DropdownMenuItem(
                value: VideoResolution.p1080,
                child: Text(
                  l10n.qualityHigh,
                  style: TextStyle(color: titleColor),
                ),
              ),
            ],
            onChanged: (v) => setState(() => _selectedQuality = v!),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancel, style: const TextStyle(color: Colors.grey)),
        ),
        ElevatedButton(
          onPressed: () {
            String name = _nameController.text.trim();
            if (name.isEmpty) {
              name = "edited_video_${DateTime.now().millisecondsSinceEpoch}";
            }
            widget.onExport(name, _selectedQuality);
          },
          child: Text(
            l10n.saveButton,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
