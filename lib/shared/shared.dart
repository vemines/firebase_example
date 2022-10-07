import 'package:flutter/material.dart';

InputDecoration myInputDecoration(IconData icon, String hint) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.grey[200],
    border: InputBorder.none,
    hintText: hint,
    contentPadding: const EdgeInsets.all(16),
    prefixIcon: Icon(
      icon,
      color: Colors.blueAccent,
    ),
  );
}

InputDecoration myInputDecoration2(String hint) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.grey[200],
    border: InputBorder.none,
    hintText: hint,
    contentPadding: const EdgeInsets.all(16),
  );
}
