import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserHeader extends StatelessWidget {
  final String initials;
  final String name;
  final String username;

  const UserHeader({
    super.key,
    required this.initials,
    required this.name,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 70.r,
            backgroundColor: const Color.fromARGB(255, 34, 41, 91),
            child: Text(
              initials,
              style: TextStyle(
                color: Colors.white,
                fontSize: 50.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 42.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            username,
            style: TextStyle(color: const Color(0xFF656678), fontSize: 30.sp),
          ),
        ],
      ),
    );
  }
}
