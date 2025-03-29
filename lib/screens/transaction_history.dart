import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/widgets/top_bar_th.dart';
import '../core/widgets/search_bar_th.dart';
import '../core/widgets/transaction_item_th.dart';

class TransactionHistoryPage extends StatelessWidget {
  final List<Map<String, dynamic>> transactions = [
    {'name': 'Mike Wazuski', 'date': '25 March, 6:30 p.m.', 'points': -200},
    {'name': 'Hehe Hehe', 'date': '25 March, 4:30 p.m.', 'points': 30},
    {'name': 'Mike Wazuski', 'date': '24 March, 6:30 p.m.', 'points': -200},
    {'name': 'Hehe Hehe', 'date': '24 March, 4:30 p.m.', 'points': 30},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020315),
      body: SafeArea(
        child: Column(
          children: [
            const TopBar(), // Replaced _buildTopBar
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 3.h),
                      Text(
                        'Transaction History',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'All your previous transactions',
                        style: TextStyle(
                          color: const Color(0xFF656678),
                          fontSize: 27.sp,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      const SearchBarTransaction(), // Replaced _buildSearchBar
                      SizedBox(height: 10.h),
                      ..._buildTransactionSections(), // Still uses helper method
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

  List<Widget> _buildTransactionSections() {
    Map<String, List<Map<String, dynamic>>> groupedTransactions = {};

    for (var transaction in transactions) {
      String dateKey = _getDateKey(transaction['date']);
      groupedTransactions.putIfAbsent(dateKey, () => []).add(transaction);
    }

    return groupedTransactions.entries.map((entry) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 16.h),
            child: Text(
              entry.key,
              style: TextStyle(
                color: const Color(0xFF656678),
                fontSize: 31.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ...entry.value.map(
            (transaction) => TransactionItem(
              name: transaction['name'],
              date: transaction['date'],
              points: transaction['points'],
              isPositive: transaction['points'] > 0,
            ),
          ),
        ],
      );
    }).toList();
  }

  String _getDateKey(String dateString) => dateString.split(',')[0];
}
