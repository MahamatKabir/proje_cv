import 'dart:convert';
import 'package:projet_cv/models/cv_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _cvKey = 'cv_data';
  final SharedPreferences _prefs;

  StorageService(this._prefs);

  Future<void> saveCV(CV cv) async {
    final cvMap = {
      'personalInfo': {
        'fullName': cv.personalInfo.fullName,
        'email': cv.personalInfo.email,
        'phone': cv.personalInfo.phone,
        'location': cv.personalInfo.location,
        'summary': cv.personalInfo.summary,
      },
      'education': cv.education
          .map((edu) => {
                'institution': edu.institution,
                'degree': edu.degree,
                'field': edu.field,
                'startDate': edu.startDate?.toIso8601String(),
                'endDate': edu.endDate?.toIso8601String(),
              })
          .toList(),
      'experience': cv.experience
          .map((exp) => {
                'company': exp.company,
                'position': exp.position,
                'startDate': exp.startDate?.toIso8601String(),
                'endDate': exp.endDate?.toIso8601String(),
                'description': exp.description,
              })
          .toList(),
      'skills': cv.skills
          .map((skill) => {
                'name': skill.name,
                'level': skill.level.toString(),
              })
          .toList(),
    };

    await _prefs.setString(_cvKey, jsonEncode(cvMap));
  }

  CV? loadCV() {
    final cvString = _prefs.getString(_cvKey);
    if (cvString == null) return null;

    try {
      final cvMap = jsonDecode(cvString) as Map<String, dynamic>;
      final personalInfoMap = cvMap['personalInfo'] as Map<String, dynamic>;

      return CV(
        personalInfo: PersonalInfo(
          fullName: personalInfoMap['fullName'] as String,
          email: personalInfoMap['email'] as String,
          phone: personalInfoMap['phone'] as String,
          location: personalInfoMap['location'] as String,
          summary: personalInfoMap['summary'] as String,
        ),
        education: (cvMap['education'] as List)
            .map((edu) => Education(
                  institution: edu['institution'] as String,
                  degree: edu['degree'] as String,
                  field: edu['field'] as String,
                  startDate: edu['startDate'] != null
                      ? DateTime.parse(edu['startDate'] as String)
                      : null,
                  endDate: edu['endDate'] != null
                      ? DateTime.parse(edu['endDate'] as String)
                      : null,
                ))
            .toList(),
        experience: (cvMap['experience'] as List)
            .map((exp) => Experience(
                  company: exp['company'] as String,
                  position: exp['position'] as String,
                  startDate: exp['startDate'] != null
                      ? DateTime.parse(exp['startDate'] as String)
                      : null,
                  endDate: exp['endDate'] != null
                      ? DateTime.parse(exp['endDate'] as String)
                      : null,
                  description: exp['description'] as String,
                ))
            .toList(),
        skills: (cvMap['skills'] as List)
            .map((skill) => Skill(
                  name: skill['name'] as String,
                  level: SkillLevel.values.firstWhere(
                    (e) => e.toString() == skill['level'],
                    orElse: () => SkillLevel.beginner,
                  ),
                ))
            .toList(),
      );
    } catch (e) {
      print('Error loading CV: $e');
      return null;
    }
  }
}
