import 'package:flutter/material.dart';

@immutable
final class CustomDropdownField extends StatelessWidget {
  const CustomDropdownField({
    super.key,
    required this.labelText,
    required this.items,
    this.value,
    required this.onChanged,
    this.isDense = true,
    this.enabled = true,
  });

  final String labelText;
  final List<String> items;
  final String? value;
  final ValueChanged<String?>? onChanged;
  final bool isDense;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      isDense: isDense,
      initialValue: (value != null && items.contains(value)) ? value : null,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
        enabled: enabled,
      ),
      items: items
          .map(
            (item) =>
                DropdownMenuItem<String>(value: item, child: Text((item))),
          )
          .toList(),
      onChanged: enabled ? onChanged : null,
    );
  }
}
