import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BarterItemWidget extends StatelessWidget {
  final String name;
  final String service;
  final int points;

  const BarterItemWidget({
    super.key,
    required this.name,
    required this.service,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff020315), Color(0xff1d1f2e)],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 42.r,
                backgroundColor: const Color(0xFF0F1120),
                child: Text(
                  name.isNotEmpty ? name[0] : '?',
                  style: TextStyle(color: Colors.white, fontSize: 30.sp),
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    service,
                    style: TextStyle(
                      color: const Color(0xFF656678),
                      fontSize: 25.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            '$points',
            style: TextStyle(
              color: Colors.white,
              fontSize: 34.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
