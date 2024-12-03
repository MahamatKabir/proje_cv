import 'package:flutter/material.dart';
import 'package:projet_cv/models/cv_model.dart';

class EducationForm extends StatelessWidget {
  final List<Education> education;
  final ValueChanged<List<Education>> onChanged;

  const EducationForm({
    super.key,
    required this.education,
    required this.onChanged,
  });

  void _addEducation() {
    onChanged([...education, Education()]);
  }

  void _removeEducation(int index) {
    final newList = List<Education>.from(education)..removeAt(index);
    onChanged(newList);
  }

  void _updateEducation(int index, Education newEducation) {
    final newList = List<Education>.from(education)..[index] = newEducation;
    onChanged(newList);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Education',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                ElevatedButton.icon(
                  onPressed: _addEducation,
                  icon: const Icon(Icons.add),
                  label: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: education.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final edu = education[index];
                return EducationItem(
                  education: edu,
                  onChanged: (edu) => _updateEducation(index, edu),
                  onRemoved: () => _removeEducation(index),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class EducationItem extends StatelessWidget {
  final Education education;
  final ValueChanged<Education> onChanged;
  final VoidCallback onRemoved;

  const EducationItem({
    super.key,
    required this.education,
    required this.onChanged,
    required this.onRemoved,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: onRemoved,
                ),
              ],
            ),
            TextFormField(
              initialValue: education.institution,
              decoration: const InputDecoration(
                labelText: 'Institution',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                onChanged(Education(
                  institution: value,
                  degree: education.degree,
                  field: education.field,
                  startDate: education.startDate,
                  endDate: education.endDate,
                ));
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: education.degree,
              decoration: const InputDecoration(
                labelText: 'Degree',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                onChanged(Education(
                  institution: education.institution,
                  degree: value,
                  field: education.field,
                  startDate: education.startDate,
                  endDate: education.endDate,
                ));
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: education.field,
              decoration: const InputDecoration(
                labelText: 'Field of Study',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                onChanged(Education(
                  institution: education.institution,
                  degree: education.degree,
                  field: value,
                  startDate: education.startDate,
                  endDate: education.endDate,
                ));
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: education.startDate?.toString().split(' ')[0],
                    decoration: const InputDecoration(
                      labelText: 'Start Date',
                      border: OutlineInputBorder(),
                    ),
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: education.startDate ?? DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (date != null) {
                        onChanged(Education(
                          institution: education.institution,
                          degree: education.degree,
                          field: education.field,
                          startDate: date,
                          endDate: education.endDate,
                        ));
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    initialValue: education.endDate?.toString().split(' ')[0],
                    decoration: const InputDecoration(
                      labelText: 'End Date',
                      border: OutlineInputBorder(),
                    ),
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: education.endDate ?? DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (date != null) {
                        onChanged(Education(
                          institution: education.institution,
                          degree: education.degree,
                          field: education.field,
                          startDate: education.startDate,
                          endDate: date,
                        ));
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
