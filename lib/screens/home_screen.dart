import 'package:flutter/material.dart';
import 'package:projet_cv/models/cv_model.dart';
import 'package:projet_cv/services/pdf_service.dart';
import 'package:projet_cv/services/storage_service.dart';
import 'package:projet_cv/widgets/cv_preview.dart';
import 'package:projet_cv/widgets/education_form.dart';
import 'package:projet_cv/widgets/experience_form.dart';
import 'package:projet_cv/widgets/personal_info_form.dart';
import 'package:projet_cv/widgets/skills_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late CV cv;
  bool showPreview = false;
  late StorageService _storageService;

  @override
  void initState() {
    super.initState();
    cv = CV();
    _initializeStorage();
  }

  Future<void> _initializeStorage() async {
    final prefs = await SharedPreferences.getInstance();
    _storageService = StorageService(prefs);
    final savedCV = _storageService.loadCV();
    if (savedCV != null) {
      setState(() {
        cv = savedCV;
      });
    }
  }

  void _saveCV() {
    _storageService.saveCV(cv);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('CV saved successfully')),
    );
  }

  void _exportPDF() async {
    try {
      await PDFService.generateAndOpenPDF(cv);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error generating PDF: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('CV Builder',
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.save, color: Colors.white),
            onPressed: _saveCV,
          ),
          IconButton(
            icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
            onPressed: _exportPDF,
          ),
          IconButton(
            icon: Icon(
              showPreview ? Icons.edit : Icons.preview,
              color: Colors.white,
            ),
            onPressed: () => setState(() => showPreview = !showPreview),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: showPreview
            ? CVPreview(
                cv: cv,
                onTemplateChanged: (template) {
                  setState(() {
                    cv.template = template;
                  });
                },
                onThemeChanged: (theme) {
                  setState(() {
                    cv.theme = theme;
                  });
                },
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildCard(
                      child: PersonalInfoForm(
                        personalInfo: cv.personalInfo,
                        onChanged: (info) =>
                            setState(() => cv.personalInfo = info),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildCard(
                      child: ExperienceForm(
                        experiences: cv.experience,
                        onChanged: (exp) => setState(() => cv.experience = exp),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildCard(
                      child: EducationForm(
                        education: cv.education,
                        onChanged: (edu) => setState(() => cv.education = edu),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildCard(
                      child: SkillsForm(
                        skills: cv.skills,
                        onChanged: (skills) =>
                            setState(() => cv.skills = skills),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }
}
