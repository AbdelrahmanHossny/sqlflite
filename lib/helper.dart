import 'package:flutter/material.dart';

class customCheck extends StatelessWidget {
  final void Function(bool?) onChanged;
  final bool value;
  const customCheck({super.key, required this.onChanged, required this.value});

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: Colors.grey.shade800,
      value: value,
      onChanged: onChanged,
    );
  }
}
