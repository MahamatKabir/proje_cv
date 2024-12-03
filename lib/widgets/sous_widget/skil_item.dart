import 'package:flutter/material.dart';
import 'package:projet_cv/models/cv_model.dart';

class SkillItem extends StatelessWidget {
  final Skill skill;
  final Color color;

  const SkillItem({
    required this.skill,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            skill.name,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: _getSkillLevel(),
            backgroundColor: color.withOpacity(0.1),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ],
      ),
    );
  }

  double _getSkillLevel() {
    switch (skill.level) {
      case SkillLevel.beginner:
        return 0.25;
      case SkillLevel.intermediate:
        return 0.5;
      case SkillLevel.advanced:
        return 0.75;
      case SkillLevel.expert:
        return 1.0;
    }
  }
}
