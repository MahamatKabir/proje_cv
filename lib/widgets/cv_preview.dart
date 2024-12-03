import 'package:flutter/material.dart';
import 'package:projet_cv/models/cv_model.dart';
import 'package:projet_cv/widgets/colors_picker.dart';
import 'package:projet_cv/widgets/templates/classic_template.dart';
import 'package:projet_cv/widgets/templates/creative_template.dart';
import 'package:projet_cv/widgets/templates/minimale_template.dart';
import 'package:projet_cv/widgets/templates/modern_template.dart';

class CVPreview extends StatelessWidget {
  final CV cv;
  final Function(CVTemplate) onTemplateChanged;
  final Function(CVTheme) onThemeChanged;

  const CVPreview({
    Key? key,
    required this.cv,
    required this.onTemplateChanged,
    required this.onThemeChanged,
  }) : super(key: key);

  Widget _getTemplateWidget() {
    switch (cv.template) {
      case CVTemplate.modern:
        return ModernTemplate(cv: cv);
      case CVTemplate.classic:
        return ClassicTemplate(cv: cv);
      case CVTemplate.minimal:
        return MinimalTemplate(cv: cv);
      case CVTemplate.creative:
        return CreativeTemplate(cv: cv);
      default:
        return const Placeholder(); // Default widget in case of error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCustomCard(context),
        const SizedBox(height: 20),
        _buildCVPreview(),
      ],
    );
  }

  Widget _buildCustomCard(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Personnaliser le Modèle',
              style: Theme.of(context).textTheme.headline6?.copyWith(
                  fontWeight: FontWeight.bold, color: Colors.blueAccent),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildModelDropdown(),
                const SizedBox(width: 16),
                _buildColorButton(context),
              ],
            ),
            const SizedBox(height: 16),
            _buildFontSwitches(),
          ],
        ),
      ),
    );
  }

  Widget _buildModelDropdown() {
    return Expanded(
      child: DropdownButtonFormField<CVTemplate>(
        value: cv.template,
        decoration: _inputDecoration('Style du Modèle'),
        items: CVTemplate.values.map((template) {
          return DropdownMenuItem(
            value: template,
            child: Text(
              template.name.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            onTemplateChanged(value);
          }
        },
      ),
    );
  }

  Widget _buildColorButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.color_lens, color: Colors.blueAccent),
      onPressed: () => _openColorPickerDialog(context),
    );
  }

  Widget _buildFontSwitches() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Police du Modèle:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildFontSwitch('Roboto', 'Roboto'),
            _buildFontSwitch('Arial', 'Arial'),
            _buildFontSwitch('Times New Roman', 'Times New Roman'),
            _buildFontSwitch('Courier New', 'Courier New'),
          ],
        ),
      ],
    );
  }

  Widget _buildFontSwitch(String fontName, String displayName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(displayName,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500)),
        Switch(
          value: cv.theme.fontFamily == fontName,
          onChanged: (bool isSelected) {
            if (isSelected) {
              onThemeChanged(
                CVTheme(
                  primaryColor: cv.theme.primaryColor,
                  secondaryColor: cv.theme.secondaryColor,
                  backgroundColor: cv.theme.backgroundColor,
                  textColor: cv.theme.textColor,
                  fontFamily: fontName,
                ),
              );
            }
          },
        ),
      ],
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.blueGrey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.blue),
      ),
    );
  }

  Widget _buildCVPreview() {
    return Expanded(
      child: InteractiveViewer(
        boundaryMargin: const EdgeInsets.all(20),
        minScale: 0.5,
        maxScale: 2.0,
        child: _getTemplateWidget(),
      ),
    );
  }

  void _openColorPickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Personnaliser les Couleurs',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildColorPickerButton(
                context,
                'Couleur Principale',
                cv.theme.primaryColor,
                (color) {
                  onThemeChanged(
                    CVTheme(
                      primaryColor: color,
                      secondaryColor: cv.theme.secondaryColor,
                      backgroundColor: cv.theme.backgroundColor,
                      textColor: cv.theme.textColor,
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              _buildColorPickerButton(
                context,
                'Couleur Secondaire',
                cv.theme.secondaryColor,
                (color) {
                  onThemeChanged(
                    CVTheme(
                      primaryColor: cv.theme.primaryColor,
                      secondaryColor: color,
                      backgroundColor: cv.theme.backgroundColor,
                      textColor: cv.theme.textColor,
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              _buildColorPickerButton(
                context,
                'Couleur de Fond',
                cv.theme.backgroundColor,
                (color) {
                  onThemeChanged(
                    CVTheme(
                      primaryColor: cv.theme.primaryColor,
                      secondaryColor: cv.theme.secondaryColor,
                      backgroundColor: color,
                      textColor: cv.theme.textColor,
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              _buildColorPickerButton(
                context,
                'Couleur du Texte',
                cv.theme.textColor,
                (color) {
                  onThemeChanged(
                    CVTheme(
                      primaryColor: cv.theme.primaryColor,
                      secondaryColor: cv.theme.secondaryColor,
                      backgroundColor: cv.theme.backgroundColor,
                      textColor: color,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Fermer',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorPickerButton(
    BuildContext context,
    String label,
    Color color,
    Function(Color) onColorChanged,
  ) {
    return ColorPickerButton(
      color: color,
      label: label,
      onColorChanged: onColorChanged,
    );
  }
}
