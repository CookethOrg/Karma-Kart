// payment_completion_page.dart (with Provider)
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/widgets/barter_details_pc.dart';
import '../core/widgets/top_bar_pc.dart';
import '../core/widgets/transaction_status_pc.dart';
import '../core/widgets/user_header_pc.dart';
import '../providers/transaction_history_provider.dart';

class PaymentCompletionPage extends StatelessWidget {
  final Transaction transaction;

  const PaymentCompletionPage({Key? key, required this.transaction})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Extract date components from the date string
    final dateTimeParts = transaction.date.split(', ');
    final datePart = dateTimeParts[0].split(' ');
    final timePart = dateTimeParts[1].split(' ');

    final day = int.tryParse(datePart[0]) ?? 1;
    final month = _getMonthNumber(datePart[1]);
    final hour = int.tryParse(timePart[0].split(':')[0]) ?? 12;
    final minute = int.tryParse(timePart[0].split(':')[1]) ?? 0;
    final isPM = timePart[1].toLowerCase().contains('p');

    final dateTime = DateTime(
      DateTime.now().year,
      month,
      day,
      isPM && hour != 12 ? hour + 12 : (hour == 12 && !isPM ? 0 : hour),
      minute,
    );

    // Generate initials from the name
    final initials =
        transaction.name.isNotEmpty
            ? transaction.name
                .split(' ')
                .map((part) => part.isNotEmpty ? part[0] : '')
                .join('')
                .substring(0, transaction.name.split(' ').length > 1 ? 2 : 1)
            : '?';

    // Use provided username or generate one
    final username =
        transaction.username ??
        '@${transaction.name.split(' ')[0].toLowerCase()}';

    return Scaffold(
      backgroundColor: const Color(0xFF020315),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopBar(title: 'Transaction Details'),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),
                      UserHeader(
                        initials: initials,
                        name:
                            transaction.isPositive
                                ? 'From ${transaction.name}'
                                : 'To ${transaction.name}',
                        username: username,
                      ),
                      SizedBox(height: 10.h),
                      TransactionStatus(
                        amount: transaction.points.abs().toString(),
                        currency: 'Karma points',
                        statusText: 'Completed',
                        completionDate: dateTime,
                      ),
                      SizedBox(height: 16.h),
                      BarterDetails(
                        items: [
                          BarterItem(
                            name: transaction.name,
                            service:
                                transaction.service ??
                                (transaction.isPositive
                                    ? 'Received Karma points'
                                    : 'Sent Karma points'),
                            points: transaction.points.abs(),
                          ),
                          // Optionally add more barter items if needed for your use case
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

  // Helper method to convert month name to number
  int _getMonthNumber(String monthName) {
    const months = {
      'january': 1,
      'february': 2,
      'march': 3,
      'april': 4,
      'may': 5,
      'june': 6,
      'july': 7,
      'august': 8,
      'september': 9,
      'october': 10,
      'november': 11,
      'december': 12,
      'jan': 1,
      'feb': 2,
      'mar': 3,
      'apr': 4,
      'jun': 6,
      'jul': 7,
      'aug': 8,
      'sep': 9,
      'oct': 10,
      'nov': 11,
      'dec': 12,
    };

    return months[monthName.toLowerCase()] ?? 1;
  }
}
