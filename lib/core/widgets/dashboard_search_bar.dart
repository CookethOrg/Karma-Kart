import 'package:flutter/material.dart';

class DashboardSearchBar extends StatelessWidget {
  const DashboardSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search for trades',
        hintStyle: TextStyle(color: Color(0xFF656678), fontSize: 14),
        prefixIcon: Icon(Icons.search, color: Color(0xFF656678)),
        filled: true,
        fillColor: Color(0xFF0F1120),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
      style: TextStyle(color: Colors.white),
    );
  }
}
