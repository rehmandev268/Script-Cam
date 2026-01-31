import 'package:flutter/material.dart';
import 'package:flutter_application_6/core/utils/responsive_config.dart';
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
    return AlertDialog(
      backgroundColor: const Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16).r),
      title: Text(
        "Save Video",
        style: TextStyle(color: Colors.white, fontSize: 18.sp),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Video Name",
            style: TextStyle(color: Colors.white70, fontSize: 12.sp),
          ),
          SizedBox(height: 8.h),
          TextField(
            controller: _nameController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Enter video name...",
              hintStyle: const TextStyle(color: Colors.white30),
              filled: true,
              fillColor: Colors.black45,
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
            "Quality",
            style: TextStyle(color: Colors.white70, fontSize: 12.sp),
          ),
          SizedBox(height: 8.h),
          DropdownButtonFormField<VideoResolution>(
            initialValue: _selectedQuality,
            dropdownColor: const Color(0xFF2C2C2C),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.black45,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8).r,
                borderSide: BorderSide.none,
              ),
            ),
            items: const [
              DropdownMenuItem(
                value: VideoResolution.p480,
                child: Text(
                  "Low (480p)",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              DropdownMenuItem(
                value: VideoResolution.p720,
                child: Text(
                  "Standard (720p)",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              DropdownMenuItem(
                value: VideoResolution.p1080,
                child: Text(
                  "High (1080p)",
                  style: TextStyle(color: Colors.white),
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
          child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
        ),
        ElevatedButton(
          onPressed: () {
            String name = _nameController.text.trim();
            if (name.isEmpty) {
              name = "edited_video_${DateTime.now().millisecondsSinceEpoch}";
            }
            widget.onExport(name, _selectedQuality);
          },
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
          child: const Text("Save", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
