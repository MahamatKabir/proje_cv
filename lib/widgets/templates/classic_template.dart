import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projet_cv/models/cv_model.dart';
import 'package:projet_cv/widgets/sous_widget/contact_item.dart';
import 'package:projet_cv/widgets/sous_widget/education_item.dart';
import 'package:projet_cv/widgets/sous_widget/experience_item.dart';
import 'package:projet_cv/widgets/sous_widget/skil_item.dart';
import 'package:projet_cv/widgets/sous_widget/social_item.dart';

class ClassicTemplate extends StatelessWidget {
  final CV cv;

  const ClassicTemplate({super.key, required this.cv});

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
                  backgroundImage: NetworkImage(cv.personalInfo.photoUrl!),
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
              Text(
                'Contact',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: cv.theme.primaryColor,
                ),
              ),
              const SizedBox(height: 8),
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
              if (cv.personalInfo.socialMedia.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  'Social',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: cv.theme.primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                ...cv.personalInfo.socialMedia.map((social) => SocialItem(
                      platform: social.platform,
                      url: social.url,
                      color: cv.theme.textColor,
                    )),
              ],
              if (cv.experience.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  'Experience',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: cv.theme.primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                ...cv.experience.map((exp) => ExperienceItem(
                      experience: exp,
                      textColor: cv.theme.textColor,
                      accentColor: cv.theme.secondaryColor,
                    )),
              ],
              if (cv.education.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  'Education',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: cv.theme.primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                ...cv.education.map((edu) => EducationItem(
                      education: edu,
                      textColor: cv.theme.textColor,
                      accentColor: cv.theme.secondaryColor,
                    )),
              ],
              if (cv.skills.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  'Skills',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: cv.theme.primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                ...cv.skills.map((skill) => SkillItem(
                      skill: skill,
                      color: cv.theme.primaryColor,
                    )),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
