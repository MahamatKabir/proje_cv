import 'package:flutter/material.dart';

class Education {
  String institution;
  String degree;
  String field;
  DateTime? startDate;
  DateTime? endDate;

  Education({
    this.institution = '',
    this.degree = '',
    this.field = '',
    this.startDate,
    this.endDate,
  });

  // Méthode pour mettre à jour l'éducation
  Education copyWith({
    String? institution,
    String? degree,
    String? field,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return Education(
      institution: institution ?? this.institution,
      degree: degree ?? this.degree,
      field: field ?? this.field,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}

class Experience {
  String company;
  String position;
  DateTime? startDate;
  DateTime? endDate;
  String description;

  Experience({
    this.company = '',
    this.position = '',
    this.startDate,
    this.endDate,
    this.description = '',
  });

  // Méthode pour mettre à jour l'expérience
  Experience copyWith({
    String? company,
    String? position,
    DateTime? startDate,
    DateTime? endDate,
    String? description,
  }) {
    return Experience(
      company: company ?? this.company,
      position: position ?? this.position,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      description: description ?? this.description,
    );
  }
}

enum SkillLevel { beginner, intermediate, advanced, expert }

class Skill {
  String name;
  SkillLevel level;

  Skill({
    this.name = '',
    this.level = SkillLevel.beginner,
  });

  // Méthode pour mettre à jour les compétences
  Skill copyWith({
    String? name,
    SkillLevel? level,
  }) {
    return Skill(
      name: name ?? this.name,
      level: level ?? this.level,
    );
  }
}

class SocialMedia {
  String platform;
  String url;

  SocialMedia({
    this.platform = '',
    this.url = '',
  });

  // Méthode pour mettre à jour les réseaux sociaux
  SocialMedia copyWith({
    String? platform,
    String? url,
  }) {
    return SocialMedia(
      platform: platform ?? this.platform,
      url: url ?? this.url,
    );
  }
}

class PersonalInfo {
  String fullName;
  String email;
  String phone;
  String location;
  String summary;
  String? photoUrl;
  List<SocialMedia> socialMedia;

  PersonalInfo({
    this.fullName = '',
    this.email = '',
    this.phone = '',
    this.location = '',
    this.summary = '',
    this.photoUrl,
    List<SocialMedia>? socialMedia,
  }) : socialMedia = socialMedia ?? [];

  // Méthode pour mettre à jour les informations personnelles
  PersonalInfo copyWith({
    String? fullName,
    String? email,
    String? phone,
    String? location,
    String? summary,
    String? photoUrl,
    List<SocialMedia>? socialMedia,
  }) {
    return PersonalInfo(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      summary: summary ?? this.summary,
      photoUrl: photoUrl ?? this.photoUrl,
      socialMedia: socialMedia ?? this.socialMedia,
    );
  }
}

enum CVTemplate { modern, classic, minimal, creative }

class CVTheme {
  Color primaryColor;
  Color secondaryColor;
  Color backgroundColor;
  Color textColor;
  String fontFamily;

  CVTheme({
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundColor,
    required this.textColor,
    this.fontFamily = 'Roboto',
  });

  CVTheme copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? backgroundColor,
    Color? textColor,
    String? fontFamily,
  }) {
    return CVTheme(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      fontFamily: fontFamily ?? this.fontFamily,
    );
  }

  factory CVTheme.defaultTheme() {
    return CVTheme(
      primaryColor: Colors.blue,
      secondaryColor: Colors.blueGrey,
      backgroundColor: Colors.white,
      textColor: Colors.black87,
      fontFamily: 'Roboto',
    );
  }
}

class CV {
  PersonalInfo personalInfo;
  List<Education> education;
  List<Experience> experience;
  List<Skill> skills;
  CVTemplate template;
  CVTheme theme;
  TextAlign? alignment;

  CV({
    PersonalInfo? personalInfo,
    List<Education>? education,
    List<Experience>? experience,
    List<Skill>? skills,
    this.alignment,
    this.template = CVTemplate.modern,
    CVTheme? theme,
  })  : personalInfo = personalInfo ?? PersonalInfo(),
        education = education ?? [],
        experience = experience ?? [],
        skills = skills ?? [],
        theme = theme ?? CVTheme.defaultTheme();

  void updateTheme(CVTheme newTheme) {
    theme = newTheme;
  }

  // Méthode pour mettre à jour le modèle CV
  CV copyWith({
    PersonalInfo? personalInfo,
    List<Education>? education,
    List<Experience>? experience,
    List<Skill>? skills,
    CVTemplate? template,
    CVTheme? theme,
    TextAlign? alignment,
  }) {
    return CV(
      personalInfo: personalInfo ?? this.personalInfo,
      education: education ?? this.education,
      experience: experience ?? this.experience,
      skills: skills ?? this.skills,
      template: template ?? this.template,
      theme: theme ?? this.theme,
      alignment: alignment ?? this.alignment,
    );
  }
}
