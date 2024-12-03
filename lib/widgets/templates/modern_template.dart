import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projet_cv/models/cv_model.dart';
import 'package:projet_cv/widgets/sous_widget/contact_item.dart';
import 'package:projet_cv/widgets/sous_widget/education_item.dart';
import 'package:projet_cv/widgets/sous_widget/experience_item.dart';
import 'package:projet_cv/widgets/sous_widget/skil_item.dart';
import 'package:projet_cv/widgets/sous_widget/social_item.dart';

class ModernTemplate extends StatelessWidget {
  final CV cv;

  const ModernTemplate({super.key, required this.cv});

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('MMM yyyy').format(date);
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: cv.theme.primaryColor,
      ),
    );
  }

  Widget _buildText(String text, {double fontSize = 15}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: cv.theme.textColor,
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String? text) {
    if (text == null || text.isEmpty) return SizedBox.shrink();
    return ContactItem(
      icon: icon,
      text: text,
      color: cv.theme.textColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: cv.theme.backgroundColor,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.only(top: 40),
                  height: 700,
                  color: cv.theme.primaryColor.withOpacity(0.1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cv.personalInfo.fullName,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: cv.theme.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (cv.personalInfo.photoUrl != null)
                        CircleAvatar(
                          radius: 70,
                          backgroundImage:
                              NetworkImage(cv.personalInfo.photoUrl!),
                          onBackgroundImageError: (_, __) =>
                              const Icon(Icons.error),
                        ),
                      const SizedBox(height: 16),
                      _buildText(cv.personalInfo.summary),
                      const SizedBox(height: 16),
                      if (cv.personalInfo.email.isNotEmpty ||
                          cv.personalInfo.phone.isNotEmpty ||
                          cv.personalInfo.location.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionTitle(context, 'Contact'),
                            const SizedBox(height: 16),
                            _buildContactItem(
                                Icons.email, cv.personalInfo.email),
                            _buildContactItem(
                                Icons.phone, cv.personalInfo.phone),
                            _buildContactItem(
                                Icons.location_on, cv.personalInfo.location),
                          ],
                        ),
                      if (cv.personalInfo.socialMedia.isNotEmpty) ...[
                        const SizedBox(height: 20),
                        _buildSectionTitle(context, 'Social'),
                        const SizedBox(height: 16),
                        ...cv.personalInfo.socialMedia
                            .map((social) => SocialItem(
                                  platform: social.platform,
                                  url: social.url,
                                  color: cv.theme.textColor,
                                )),
                      ],
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (cv.experience.isNotEmpty) ...[
                        const SizedBox(height: 32),
                        _buildSectionTitle(context, 'Experience'),
                        const SizedBox(height: 16),
                        ...cv.experience.map((exp) => ExperienceItem(
                              experience: exp,
                              textColor: cv.theme.textColor,
                              accentColor: cv.theme.secondaryColor,
                            )),
                      ],
                      if (cv.education.isNotEmpty) ...[
                        const SizedBox(height: 32),
                        _buildSectionTitle(context, 'Education'),
                        const SizedBox(height: 16),
                        ...cv.education.map((edu) => EducationItem(
                              education: edu,
                              textColor: cv.theme.textColor,
                              accentColor: cv.theme.secondaryColor,
                            )),
                      ],
                      if (cv.skills.isNotEmpty) ...[
                        const SizedBox(height: 24),
                        _buildSectionTitle(context, 'Skills'),
                        const SizedBox(height: 16),
                        ...cv.skills.map((skill) => SkillItem(
                              skill: skill,
                              color: cv.theme.primaryColor,
                            )),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
