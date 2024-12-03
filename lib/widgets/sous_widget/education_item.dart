import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projet_cv/models/cv_model.dart';

class EducationItem extends StatelessWidget {
  final Education education;
  final Color textColor;
  final Color accentColor;

  const EducationItem({
    required this.education,
    required this.textColor,
    required this.accentColor,
  });

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('MMM yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  education.degree,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  '${_formatDate(education.startDate)} - ${_formatDate(education.endDate)}',
                  style: TextStyle(
                    color: accentColor,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          Text(
            education.institution,
            style: TextStyle(
              color: accentColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            education.field,
            style: TextStyle(color: textColor),
          ),
        ],
      ),
    );
  }
}
