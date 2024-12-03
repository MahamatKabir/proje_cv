import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projet_cv/models/cv_model.dart';
import 'package:projet_cv/widgets/sous_widget/contact_item.dart';
import 'package:projet_cv/widgets/sous_widget/education_item.dart';
import 'package:projet_cv/widgets/sous_widget/experience_item.dart';
import 'package:projet_cv/widgets/sous_widget/skil_item.dart';
import 'package:projet_cv/widgets/sous_widget/social_item.dart';

class CreativeTemplate extends StatelessWidget {
  final CV cv;

  const CreativeTemplate({super.key, required this.cv});

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('MMM yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: cv.theme.backgroundColor,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (cv.personalInfo.photoUrl != null)
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(cv.personalInfo.photoUrl!),
                    ),
                  const SizedBox(width: 16),
                  Text(
                    cv.personalInfo.fullName,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: cv.theme.primaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                cv.personalInfo.summary,
                style: TextStyle(
                  fontSize: 16,
                  color: cv.theme.textColor,
                ),
              ),
              const Divider(),
              _buildSectionTitle('Contact'),
              _buildContactDetails(),
              const Divider(),
              _buildSectionTitle('Experience'),
              _buildExperienceDetails(),
              const Divider(),
              _buildSectionTitle('Education'),
              _buildEducationDetails(),
              const Divider(),
              _buildSectionTitle('Skills'),
              _buildSkillDetails(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: cv.theme.primaryColor,
        ),
      ),
    );
  }

  Widget _buildContactDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContactItem(
          icon: Icons.email,
          text: cv.personalInfo.email,
          color: cv.theme.textColor,
        ),
        ContactItem(
          icon: Icons.phone,
          text: cv.personalInfo.phone,
          color: cv.theme.textColor,
        ),
        ContactItem(
          icon: Icons.location_on,
          text: cv.personalInfo.location,
          color: cv.theme.textColor,
        ),
        if (cv.personalInfo.socialMedia.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: cv.personalInfo.socialMedia
                .map((social) => SocialItem(
                      platform: social.platform,
                      url: social.url,
                      color: cv.theme.textColor,
                    ))
                .toList(),
          ),
      ],
    );
  }

  Widget _buildExperienceDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: cv.experience
          .map((exp) => ExperienceItem(
                experience: exp,
                textColor: cv.theme.textColor,
                accentColor: cv.theme.secondaryColor,
              ))
          .toList(),
    );
  }

  Widget _buildEducationDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: cv.education
          .map((edu) => EducationItem(
                education: edu,
                textColor: cv.theme.textColor,
                accentColor: cv.theme.secondaryColor,
              ))
          .toList(),
    );
  }

  Widget _buildSkillDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: cv.skills
          .map((skill) => SkillItem(
                skill: skill,
                color: cv.theme.primaryColor,
              ))
          .toList(),
    );
  }
}
