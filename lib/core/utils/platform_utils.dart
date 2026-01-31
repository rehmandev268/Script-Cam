import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PlatformConfig {
  static final List<Map<String, dynamic>> platforms = [
    {
      "name": "General",
      "icon": Icons.video_library,
      "color": const Color(0xFF455A64),
      "textColor": Colors.white,
    },
    {
      "name": "YouTube",
      "icon": FontAwesomeIcons.youtube,
      "color": const Color(0xFFFF0000),
      "textColor": Colors.white,
    },
    {
      "name": "Instagram",
      "icon": FontAwesomeIcons.instagram,
      "gradient": const LinearGradient(
        colors: [Color(0xFF833AB4), Color(0xFFFD1D1D), Color(0xFFF56040)],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ),
      "color": const Color(0xFFE1306C),
      "textColor": Colors.white,
    },
    {
      "name": "TikTok",
      "icon": FontAwesomeIcons.tiktok,
      "color": Colors.black,
      "textColor": Colors.white,
      "darkModeColor": const Color(0xFF00F2EA),
      "darkModeText": Colors.black,
    },
    {
      "name": "LinkedIn",
      "icon": FontAwesomeIcons.linkedin,
      "color": const Color(0xFF0077B5),
      "textColor": Colors.white,
    },
    {
      "name": "Facebook",
      "icon": FontAwesomeIcons.facebook,
      "color": const Color(0xFF1877F2),
      "textColor": Colors.white,
    },
    {
      "name": "Shorts",
      "icon": FontAwesomeIcons.youtube,
      "color": const Color(0xFFE11D48),
      "textColor": Colors.white,
    },
  ];

  static Map<String, dynamic> getPlatformStyle(
    String title,
    String content,
    bool isDark,
  ) {
    final combined = "$title $content".toLowerCase();
    Map<String, dynamic> selected = platforms[0];

    for (var p in platforms) {
      if (p['name'] == "General") continue;
      if (combined.contains((p['name'] as String).toLowerCase())) {
        selected = p;
        break;
      }
    }

    Color brandColor = selected['color'];
    if (isDark && selected.containsKey('darkModeColor')) {
      brandColor = selected['darkModeColor'];
    } else if (selected['name'] == 'TikTok' && !isDark) {
      brandColor = Colors.black;
    }

    return {
      "name": selected['name'],
      "icon": selected['icon'],
      "color": brandColor,
      "textColor": selected['textColor'] ?? Colors.white,
      "gradient": selected['gradient'],
      "darkModeText": selected['darkModeText'],
    };
  }
}
