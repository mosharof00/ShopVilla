import 'package:flutter/material.dart';

class CustomRadioButton extends StatelessWidget {
  final List<String> values;
  final int selectedIndex;
  final Function(int) onChanged;

  CustomRadioButton({
    required this.values,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: values.asMap().entries.map((entry) {
        int idx = entry.key;
        String val = entry.value;
        return GestureDetector(
          onTap: () => onChanged(idx),
          child: Row(
            children: [
              Radio(
                value: idx,
                groupValue: selectedIndex,
                onChanged: (int? index) => onChanged(index!),
              ),
              Text(val),
            ],
          ),
        );
      }).toList(),
    );
  }
}
