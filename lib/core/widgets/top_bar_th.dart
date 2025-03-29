import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:radix_icons/radix_icons.dart'; // Import Radix Icons

class TopBar extends StatelessWidget {
  final VoidCallback? onBackPressed;

  const TopBar({Key? key, this.onBackPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.end, // Align items to the end (right)
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xff020315), Color(0xff1d1f2e)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
            padding: EdgeInsets.all(8.w),
            child: Icon(
              RadixIcons.Calendar, // Using Radix calendar icon
              color: Colors.white,
              size: 50.w,
            ),
          ),
        ],
      ),
    );
  }
}
