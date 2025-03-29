import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionItem extends StatelessWidget {
  final String name;
  final String date;
  final int points;
  final bool isPositive;

  const TransactionItem({
    Key? key,
    required this.name,
    required this.date,
    required this.points,
    this.isPositive = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xff020315), Color(0xff1d1f2e)],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40.r,
                  backgroundColor: const Color(0xFF0F1120),
                  child: Text(
                    name.isNotEmpty ? name[0] : '?',
                    style: TextStyle(color: Colors.white, fontSize: 32.sp),
                  ),
                ),
                SizedBox(width: 16.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      date,
                      style: TextStyle(
                        color: const Color(0xFF656678),
                        fontSize: 24.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              '${isPositive ? '+' : ''}$points Karma points',
              style: TextStyle(
                color: isPositive ? Colors.green : Colors.red,
                fontSize: 28.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
