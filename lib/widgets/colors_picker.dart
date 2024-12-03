import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerButton extends StatelessWidget {
  final Color color;
  final String label;
  final ValueChanged<Color> onColorChanged;

  const ColorPickerButton({
    Key? key,
    required this.color,
    required this.label,
    required this.onColorChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () async {
            final pickedColor = await showDialog<Color>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Select Color'),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: color,
                    onColorChanged: onColorChanged,
                  ),
                ),
                actions: [
                  TextButton(
                    child: const Text('Done'),
                    onPressed: () => Navigator.of(context).pop(color),
                  ),
                ],
              ),
            );
            if (pickedColor != null) {
              onColorChanged(pickedColor);
            }
          },
          child: CircleAvatar(
            backgroundColor: color,
            radius: 16,
          ),
        ),
      ],
    );
  }
}
