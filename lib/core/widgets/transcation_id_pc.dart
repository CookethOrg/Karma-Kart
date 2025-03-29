import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionId extends StatelessWidget {
  final String id;

  const TransactionId({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Clipboard.setData(ClipboardData(text: id));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Transaction ID copied to clipboard')),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 3.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Transaction id: ',
                    style: TextStyle(
                      color: const Color(0xFF656678),
                      fontSize: 30.sp,
                    ),
                  ),
                  TextSpan(
                    text: id,
                    style: TextStyle(color: Colors.white, fontSize: 30.sp),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Icon(Icons.copy, color: const Color(0xFF656678), size: 34.w),
          ],
        ),
      ),
    );
  }
}
