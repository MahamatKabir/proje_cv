import 'package:flutter/material.dart';
import 'package:projet_cv/models/cv_model.dart';

class ExperienceForm extends StatelessWidget {
  final List<Experience> experiences;
  final ValueChanged<List<Experience>> onChanged;

  const ExperienceForm({
    super.key,
    required this.experiences,
    required this.onChanged,
  });

  void _addExperience() {
    onChanged([...experiences, Experience()]);
  }

  void _removeExperience(int index) {
    final newList = List<Experience>.from(experiences)..removeAt(index);
    onChanged(newList);
  }

  void _updateExperience(int index, Experience experience) {
    final newList = List<Experience>.from(experiences)..[index] = experience;
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
                  'Work Experience',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                ElevatedButton.icon(
                  onPressed: _addExperience,
                  icon: const Icon(Icons.add),
                  label: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: experiences.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final experience = experiences[index];
                return ExperienceItem(
                  experience: experience,
                  onChanged: (exp) => _updateExperience(index, exp),
                  onRemoved: () => _removeExperience(index),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ExperienceItem extends StatelessWidget {
  final Experience experience;
  final ValueChanged<Experience> onChanged;
  final VoidCallback onRemoved;

  const ExperienceItem({
    super.key,
    required this.experience,
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
              initialValue: experience.company,
              decoration: const InputDecoration(
                labelText: 'Company',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                onChanged(Experience(
                  company: value,
                  position: experience.position,
                  startDate: experience.startDate,
                  endDate: experience.endDate,
                  description: experience.description,
                ));
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: experience.position,
              decoration: const InputDecoration(
                labelText: 'Position',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                onChanged(Experience(
                  company: experience.company,
                  position: value,
                  startDate: experience.startDate,
                  endDate: experience.endDate,
                  description: experience.description,
                ));
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue:
                        experience.startDate?.toString().split(' ')[0],
                    decoration: const InputDecoration(
                      labelText: 'Start Date',
                      border: OutlineInputBorder(),
                    ),
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: experience.startDate ?? DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (date != null) {
                        onChanged(Experience(
                          company: experience.company,
                          position: experience.position,
                          startDate: date,
                          endDate: experience.endDate,
                          description: experience.description,
                        ));
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    initialValue: experience.endDate?.toString().split(' ')[0],
                    decoration: const InputDecoration(
                      labelText: 'End Date',
                      border: OutlineInputBorder(),
                    ),
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: experience.endDate ?? DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (date != null) {
                        onChanged(Experience(
                          company: experience.company,
                          position: experience.position,
                          startDate: experience.startDate,
                          endDate: date,
                          description: experience.description,
                        ));
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: experience.description,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              onChanged: (value) {
                onChanged(Experience(
                  company: experience.company,
                  position: experience.position,
                  startDate: experience.startDate,
                  endDate: experience.endDate,
                  description: value,
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
