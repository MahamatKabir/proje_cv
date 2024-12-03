import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:intl/intl.dart';
import 'package:projet_cv/models/cv_model.dart';

class PDFService {
  static Future<void> generateAndOpenPDF(CV cv) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageTheme: _buildTheme(cv),
        build: (context) => _buildContent(cv),
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/cv.pdf');
    await file.writeAsBytes(await pdf.save());
    await OpenFile.open(file.path);
  }

  static pw.PageTheme _buildTheme(CV cv) {
    return pw.PageTheme(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(32),
      theme: pw.ThemeData.withFont(
        base: pw.Font.helvetica(),
        bold: pw.Font.helveticaBold(),
      ),
      buildBackground: (context) => pw.FullPage(
        ignoreMargins: true,
        child: pw.Container(
          color: PdfColor.fromInt(cv.theme.backgroundColor.value),
        ),
      ),
    );
  }

  static List<pw.Widget> _buildContent(CV cv) {
    switch (cv.template) {
      case CVTemplate.modern:
        return _buildModernContent(cv);
      case CVTemplate.classic:
        return _buildClassicContent(cv);
      case CVTemplate.minimal:
        return _buildMinimalContent(cv);
      case CVTemplate.creative:
        return _buildCreativeContent(cv);
      default:
        return [];
    }
  }

  static List<pw.Widget> _buildModernContent(CV cv) {
    return [
      _buildHeader(cv.personalInfo, cv.theme),
      pw.SizedBox(height: 20),
      if (cv.experience.isNotEmpty)
        _buildSection(
          'Experience',
          cv.experience
              .map((exp) => _buildExperienceItem(exp, cv.theme))
              .toList(),
          cv.theme,
        ),
      if (cv.education.isNotEmpty)
        _buildSection(
          'Education',
          cv.education
              .map((edu) => _buildEducationItem(edu, cv.theme))
              .toList(),
          cv.theme,
        ),
      if (cv.skills.isNotEmpty) _buildSkillsSection(cv.skills, cv.theme),
    ];
  }

  static List<pw.Widget> _buildClassicContent(CV cv) {
    return [
      _buildHeader(cv.personalInfo, cv.theme),
      pw.SizedBox(height: 20),
      if (cv.experience.isNotEmpty)
        _buildSection(
          'Experience',
          cv.experience
              .map((exp) => _buildExperienceItem(exp, cv.theme))
              .toList(),
          cv.theme,
        ),
      if (cv.education.isNotEmpty)
        _buildSection(
          'Education',
          cv.education
              .map((edu) => _buildEducationItem(edu, cv.theme))
              .toList(),
          cv.theme,
        ),
      if (cv.skills.isNotEmpty) _buildSkillsSection(cv.skills, cv.theme),
    ];
  }

  static List<pw.Widget> _buildMinimalContent(CV cv) {
    return [
      _buildHeader(cv.personalInfo, cv.theme),
      pw.SizedBox(height: 20),
      if (cv.experience.isNotEmpty)
        _buildSection(
          'Experience',
          cv.experience
              .map((exp) => _buildExperienceItem(exp, cv.theme))
              .toList(),
          cv.theme,
        ),
      if (cv.education.isNotEmpty)
        _buildSection(
          'Education',
          cv.education
              .map((edu) => _buildEducationItem(edu, cv.theme))
              .toList(),
          cv.theme,
        ),
      if (cv.skills.isNotEmpty) _buildSkillsSection(cv.skills, cv.theme),
    ];
  }

  static List<pw.Widget> _buildCreativeContent(CV cv) {
    return [
      _buildHeader(cv.personalInfo, cv.theme),
      pw.SizedBox(height: 20),
      if (cv.experience.isNotEmpty)
        _buildSection(
          'Experience',
          cv.experience
              .map((exp) => _buildExperienceItem(exp, cv.theme))
              .toList(),
          cv.theme,
        ),
      if (cv.education.isNotEmpty)
        _buildSection(
          'Education',
          cv.education
              .map((edu) => _buildEducationItem(edu, cv.theme))
              .toList(),
          cv.theme,
        ),
      if (cv.skills.isNotEmpty) _buildSkillsSection(cv.skills, cv.theme),
    ];
  }

  // Méthodes _buildClassicContent, _buildMinimalContent et _buildCreativeContent
  // resteront inchangées ici et suivront une implémentation similaire

  static pw.Widget _buildHeader(PersonalInfo info, CVTheme theme) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          info.fullName,
          style: pw.TextStyle(
            fontSize: 24,
            fontWeight: pw.FontWeight.bold,
            color: PdfColor.fromInt(theme.primaryColor.value),
          ),
        ),
        pw.SizedBox(height: 10),
        pw.Text(info.email, style: _defaultTextStyle(theme)),
        pw.Text(info.phone, style: _defaultTextStyle(theme)),
        pw.Text(info.location, style: _defaultTextStyle(theme)),
        if (info.summary.isNotEmpty) ...[
          pw.SizedBox(height: 10),
          pw.Text(info.summary, style: _defaultTextStyle(theme)),
        ],
      ],
    );
  }

  static pw.Widget _buildSection(
      String title, List<pw.Widget> children, CVTheme theme) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(
            fontSize: 18,
            fontWeight: pw.FontWeight.bold,
            color: PdfColor.fromInt(theme.primaryColor.value),
          ),
        ),
        pw.SizedBox(height: 10),
        ...children,
      ],
    );
  }

  static pw.Widget _buildExperienceItem(Experience exp, CVTheme theme) {
    final dateFormat = DateFormat('MMM yyyy');
    final dates =
        '${exp.startDate != null ? dateFormat.format(exp.startDate!) : ''} - '
        '${exp.endDate != null ? dateFormat.format(exp.endDate!) : 'Present'}';

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          exp.position,
          style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              color: PdfColor.fromInt(theme.secondaryColor.value)),
        ),
        pw.Text(exp.company, style: _defaultTextStyle(theme)),
        pw.Text(dates, style: _defaultTextStyle(theme)),
        pw.SizedBox(height: 5),
        pw.Text(exp.description, style: _defaultTextStyle(theme)),
        pw.SizedBox(height: 10),
      ],
    );
  }

  static pw.Widget _buildEducationItem(Education edu, CVTheme theme) {
    final dateFormat = DateFormat('MMM yyyy');
    final dates =
        '${edu.startDate != null ? dateFormat.format(edu.startDate!) : ''} - '
        '${edu.endDate != null ? dateFormat.format(edu.endDate!) : 'Present'}';

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          edu.institution,
          style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              color: PdfColor.fromInt(theme.secondaryColor.value)),
        ),
        pw.Text('${edu.degree} in ${edu.field}',
            style: _defaultTextStyle(theme)),
        pw.Text(dates, style: _defaultTextStyle(theme)),
        pw.SizedBox(height: 10),
      ],
    );
  }

  static pw.Widget _buildSkillsSection(List<Skill> skills, CVTheme theme) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Skills',
          style: pw.TextStyle(
            fontSize: 18,
            fontWeight: pw.FontWeight.bold,
            color: PdfColor.fromInt(theme.primaryColor.value),
          ),
        ),
        pw.SizedBox(height: 10),
        pw.Wrap(
          spacing: 10,
          runSpacing: 5,
          children: skills
              .map((skill) => pw.Container(
                    padding: pw.EdgeInsets.all(5),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(
                          color: PdfColor.fromInt(theme.textColor.value)),
                      borderRadius: pw.BorderRadius.circular(5),
                    ),
                    child: pw.Text('${skill.name} - ${skill.level.name}',
                        style: _defaultTextStyle(theme)),
                  ))
              .toList(),
        ),
      ],
    );
  }

  static pw.TextStyle _defaultTextStyle(CVTheme theme) {
    return pw.TextStyle(
      fontSize: 12,
      color: PdfColor.fromInt(theme.textColor.value),
    );
  }
}
