import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../core/widgets/top_bar_th.dart';
import '../core/widgets/search_bar_th.dart';
import '../core/widgets/transaction_item_th.dart';
import '../providers/transaction_history_provider.dart';
import 'payment_completion.dart';

class TransactionHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access transactions from provider
    final transactionData = Provider.of<TransactionProvider>(context);
    final transactions = transactionData.transactions;

    return Scaffold(
      backgroundColor: const Color(0xFF020315),
      body: SafeArea(
        child: Column(
          children: [
            const TopBar(),
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
                      const SearchBarTransaction(),
                      SizedBox(height: 10.h),
                      ..._buildTransactionSections(context, transactions),
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

  List<Widget> _buildTransactionSections(
    BuildContext context,
    List<Transaction> transactions,
  ) {
    Map<String, List<Transaction>> groupedTransactions = {};

    for (var transaction in transactions) {
      String dateKey = _getDateKey(transaction.date);
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
              name: transaction.name,
              date: transaction.date,
              points: transaction.points,
              isPositive: transaction.isPositive,
              onTap: () {
                // Navigate to payment completion page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            PaymentCompletionPage(transaction: transaction),
                  ),
                );
              },
            ),
          ),
        ],
      );
    }).toList();
  }

  String _getDateKey(String dateString) => dateString.split(',')[0];
}
