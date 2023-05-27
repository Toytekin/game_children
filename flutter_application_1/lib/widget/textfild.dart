import 'package:flutter/material.dart';

class SbtTextfild extends StatelessWidget {
  final TextEditingController controller;
  final String hinttext;
  const SbtTextfild({
    super.key,
    required this.controller,
    required this.hinttext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hinttext,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
