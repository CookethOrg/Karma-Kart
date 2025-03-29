import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/widgets/barter_details_pc.dart';
import '../core/widgets/top_bar_pc.dart';
import '../core/widgets/transaction_status_pc.dart';
import '../core/widgets/user_header_pc.dart';

class PaymentCompletionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020315),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TopBar(title: 'Transaction Details'),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),
                      const UserHeader(
                        initials: 'MW',
                        name: 'To Mike Wazuski',
                        username: '@mikey',
                      ),
                      SizedBox(height: 10.h),
                      TransactionStatus(
                        amount: '200',
                        currency: 'Karma points',
                        statusText: 'Completed',
                        completionDate: DateTime(2023, 3, 25, 18, 30),
                      ),
                      SizedBox(height: 16.h),
                      BarterDetails(
                        items: [
                          BarterItem(
                            name: 'Daniel Rodriguez',
                            service: 'Logo Design for Startup',
                            points: 200,
                          ),
                          BarterItem(
                            name: 'Mike Wazuski',
                            service: 'Coding my portfolio',
                            points: 400,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
