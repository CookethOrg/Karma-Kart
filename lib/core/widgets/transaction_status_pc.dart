import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karmakart/core/widgets/transaction_id_pc.dart';

class TransactionStatus extends StatelessWidget {
  final String amount;
  final String currency;
  final String statusText;
  final DateTime completionDate;

  const TransactionStatus({
    super.key,
    required this.amount,
    required this.currency,
    required this.statusText,
    required this.completionDate,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            amount,
            style: TextStyle(
              color: Colors.white,
              fontSize: 68.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            currency,
            style: TextStyle(color: const Color(0xFF656678), fontSize: 30.sp),
          ),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 34.w),
                SizedBox(width: 6.w),
                Text(
                  '$statusText on ${_formatDate(completionDate)}',
                  style: TextStyle(color: Colors.white, fontSize: 30.sp),
                ),
              ],
            ),
          ),
          SizedBox(height: 4.h),
          const TransactionId(id: 'Ccghi8765GfdS'),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day} ${_getMonthName(date.month)}, ${date.hour}:${date.minute.toString().padLeft(2, '0')} ${date.hour < 12 ? 'a.m.' : 'p.m.'}';
  }

  String _getMonthName(int month) {
    return const [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ][month - 1];
  }
}
