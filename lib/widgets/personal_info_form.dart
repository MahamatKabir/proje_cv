import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projet_cv/models/cv_model.dart';

class PersonalInfoForm extends StatelessWidget {
  final PersonalInfo personalInfo;
  final ValueChanged<PersonalInfo> onChanged;

  const PersonalInfoForm({
    super.key,
    required this.personalInfo,
    required this.onChanged,
  });

  void _addSocialMedia() {
    final newSocialMedia = [...personalInfo.socialMedia, SocialMedia()];
    onChanged(PersonalInfo(
      fullName: personalInfo.fullName,
      email: personalInfo.email,
      phone: personalInfo.phone,
      location: personalInfo.location,
      summary: personalInfo.summary,
      photoUrl: personalInfo.photoUrl,
      socialMedia: newSocialMedia,
    ));
  }

  void _updateSocialMedia(int index, String platform, String url) {
    final newSocialMedia = List<SocialMedia>.from(personalInfo.socialMedia);
    newSocialMedia[index] = SocialMedia(platform: platform, url: url);
    onChanged(PersonalInfo(
      fullName: personalInfo.fullName,
      email: personalInfo.email,
      phone: personalInfo.phone,
      location: personalInfo.location,
      summary: personalInfo.summary,
      photoUrl: personalInfo.photoUrl,
      socialMedia: newSocialMedia,
    ));
  }

  void _removeSocialMedia(int index) {
    final newSocialMedia = List<SocialMedia>.from(personalInfo.socialMedia)
      ..removeAt(index);
    onChanged(PersonalInfo(
      fullName: personalInfo.fullName,
      email: personalInfo.email,
      phone: personalInfo.phone,
      location: personalInfo.location,
      summary: personalInfo.summary,
      photoUrl: personalInfo.photoUrl,
      socialMedia: newSocialMedia,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Personal Information',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: personalInfo.photoUrl != null
                          ? NetworkImage(personalInfo.photoUrl!)
                          : null,
                      child: personalInfo.photoUrl == null
                          ? const Icon(Icons.person, size: 50)
                          : null,
                    ),
                    const SizedBox(height: 8),
                    TextButton.icon(
                      icon: const Icon(Icons.photo_camera),
                      label: const Text('Add Photo'),
                      onPressed: () {
                        // Implement photo upload logic
                      },
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: personalInfo.fullName,
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) => onChanged(PersonalInfo(
                          fullName: value,
                          email: personalInfo.email,
                          phone: personalInfo.phone,
                          location: personalInfo.location,
                          summary: personalInfo.summary,
                          photoUrl: personalInfo.photoUrl,
                          socialMedia: personalInfo.socialMedia,
                        )),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        initialValue: personalInfo.email,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) => onChanged(PersonalInfo(
                          fullName: personalInfo.fullName,
                          email: value,
                          phone: personalInfo.phone,
                          location: personalInfo.location,
                          summary: personalInfo.summary,
                          photoUrl: personalInfo.photoUrl,
                          socialMedia: personalInfo.socialMedia,
                        )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: personalInfo.phone,
                    decoration: const InputDecoration(
                      labelText: 'Phone',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => onChanged(PersonalInfo(
                      fullName: personalInfo.fullName,
                      email: personalInfo.email,
                      phone: value,
                      location: personalInfo.location,
                      summary: personalInfo.summary,
                      photoUrl: personalInfo.photoUrl,
                      socialMedia: personalInfo.socialMedia,
                    )),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    initialValue: personalInfo.location,
                    decoration: const InputDecoration(
                      labelText: 'Location',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => onChanged(PersonalInfo(
                      fullName: personalInfo.fullName,
                      email: personalInfo.email,
                      phone: personalInfo.phone,
                      location: value,
                      summary: personalInfo.summary,
                      photoUrl: personalInfo.photoUrl,
                      socialMedia: personalInfo.socialMedia,
                    )),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: personalInfo.summary,
              decoration: const InputDecoration(
                labelText: 'Professional Summary',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
              onChanged: (value) => onChanged(PersonalInfo(
                fullName: personalInfo.fullName,
                email: personalInfo.email,
                phone: personalInfo.phone,
                location: personalInfo.location,
                summary: value,
                photoUrl: personalInfo.photoUrl,
                socialMedia: personalInfo.socialMedia,
              )),
            ),
            const SizedBox(height: 24),
            SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Social Media',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  TextButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('Add'),
                    onPressed: _addSocialMedia,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: personalInfo.socialMedia.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final social = personalInfo.socialMedia[index];
                return Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: social.platform.isNotEmpty
                            ? social.platform
                            : 'linkedin',
                        decoration: const InputDecoration(
                          labelText: 'Platform',
                          border: OutlineInputBorder(),
                        ),
                        items: ['LinkedIn', 'GitHub', 'Twitter', 'Other']
                            .map((platform) => DropdownMenuItem(
                                  value: platform.toLowerCase(),
                                  child: Text(platform),
                                ))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            _updateSocialMedia(index, value, social.url);
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        initialValue: social.url,
                        decoration: const InputDecoration(
                          labelText: 'URL',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) =>
                            _updateSocialMedia(index, social.platform, value),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeSocialMedia(index),
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
