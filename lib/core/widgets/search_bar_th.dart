import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBarTransaction extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;

  const SearchBarTransaction({
    Key? key,
    this.hintText = 'Search in transactions',
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: const Color(0xFF656678), fontSize: 35.sp),
        prefixIcon: Icon(
          Icons.search,
          color: const Color(0xFF656678),
          size: 60.w,
        ),
        filled: true,
        fillColor: const Color(0xFF0F1120),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
      ),
      style: TextStyle(color: Colors.white, fontSize: 42.sp),
    );
  }
}
