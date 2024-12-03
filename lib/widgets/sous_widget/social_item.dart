import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialItem extends StatelessWidget {
  final String platform;
  final String url;
  final Color color;

  const SocialItem({
    required this.platform,
    required this.url,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(_getSocialIcon(), size: 16, color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              url,
              style: TextStyle(color: color),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getSocialIcon() {
    switch (platform.toLowerCase()) {
      case 'linkedin':
        return FontAwesomeIcons.linkedin;
      case 'github':
        return Icons.code;
      case 'twitter':
        return FontAwesomeIcons.twitter;
      default:
        return Icons.link;
    }
  }
}
