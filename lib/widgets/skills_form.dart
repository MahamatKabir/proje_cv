import 'package:flutter/material.dart';
import 'package:projet_cv/models/cv_model.dart';

class SkillsForm extends StatelessWidget {
  final List<Skill> skills;
  final ValueChanged<List<Skill>> onChanged;

  const SkillsForm({
    super.key,
    required this.skills,
    required this.onChanged,
  });

  void _addSkill() {
    onChanged([...skills, Skill()]);
  }

  void _removeSkill(int index) {
    final newList = List<Skill>.from(skills)..removeAt(index);
    onChanged(newList);
  }

  void _updateSkill(int index, Skill skill) {
    final newList = List<Skill>.from(skills)..[index] = skill;
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
                  'Skills',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                ElevatedButton.icon(
                  onPressed: _addSkill,
                  icon: const Icon(Icons.add),
                  label: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: skills.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final skill = skills[index];
                return Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        initialValue: skill.name,
                        decoration: const InputDecoration(
                          labelText: 'Skill',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          _updateSkill(
                            index,
                            Skill(name: value, level: skill.level),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      flex: 2,
                      child: DropdownButtonFormField<SkillLevel>(
                        value: skill.level,
                        decoration: const InputDecoration(
                          labelText: 'Level',
                          border: OutlineInputBorder(),
                        ),
                        items: SkillLevel.values.map((level) {
                          return DropdownMenuItem(
                            value: level,
                            child: Text(level.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            _updateSkill(
                              index,
                              Skill(name: skill.name, level: value),
                            );
                          }
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeSkill(index),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
