import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karmakart/models/trade.dart';
import 'package:karmakart/providers/trade_provider.dart';
import 'package:karmakart/screens/accept_trade_page.dart';
import 'package:karmakart/screens/dashboard_page.dart';
import 'package:karmakart/screens/profile.dart';
import 'package:provider/provider.dart';

class TradeDetails extends StatelessWidget {
  Trade trade;
  TradeDetails({super.key, required this.trade});

  @override
  Widget build(BuildContext context) {
    final tr = trade;
    Widget buildDetailRow(String label, String value, {IconData? icon}) {
      return Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: const Color(0xFF656678),
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                if (icon != null) ...[
                  SizedBox(width: 4.w),
                  Icon(icon, color: const Color(0xFF656678), size: 24.sp),
                ],
              ],
            ),
            SizedBox(height: 4.h),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 36.sp,
                fontWeight: FontWeight.w500,
              ),
              softWrap: true,
            ),
          ],
        ),
      );
    }

    // Helper method for duration row with icons
    Widget buildDurationRow(String label, String endDate) {
      return Padding(
        padding: EdgeInsets.only(bottom: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: const Color(0xFF656678),
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 4.h),
            Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.white, size: 36.sp),
                SizedBox(width: 16.w),
                Text(
                  endDate,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    // Helper method for the Project Tags section
    Widget buildTagsSection(String label, List<String> tags) {
      return Padding(
        padding: EdgeInsets.only(bottom: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: const Color(0xFF656678),
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 8.h),
            Wrap(
              spacing: 8.w,
              children:
                  tags.map((tag) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F1120),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ],
        ),
      );
    }

    // Main content section
    Widget buildMainContent() {
      return Padding(
        padding: EdgeInsets.all(80.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: "Trade details"
            Text(
              'Trade details',
              style: TextStyle(
                color: Colors.white,
                fontSize: 48.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 4.h),
            // Subtext: "Details about your trade"
            Text(
              'Details about your trade',
              style: TextStyle(
                color: const Color(0xFF656678),
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 16.h),
            // Heading section
            buildDetailRow('Heading', trade.heading),
            // Description section
            buildDetailRow('Description of your trade', trade.description),
            // Duration section
            buildDurationRow(
              'Expected Delivery Date',
              trade.expectedDeliveryTime,
            ),
            // Project Tags section
            buildTagsSection('Tags', trade.tags),
            // Proposed Karma Points section
            Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Proposed Karma points',
                    style: TextStyle(
                      color: const Color(0xFF656678),
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: trade.price.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Requests header
            SizedBox(height: 16.h),
            Text(
              'Requests',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      );
    }

    return Consumer<TradeProvider>(
      builder: (context, tp, child) {
        return FutureBuilder(
          future: tp.fetchApproacheeUserName(trade),
          builder: (context, snapshot) {
            var name = snapshot.data;
            return Scaffold(
              backgroundColor: const Color(0xFF020315),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildMainContent(),
                      RequestTile(name: name ?? 'Approachee Name', trade: tr),
                      // SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// Separate widget for the Request tile
class RequestTile extends StatelessWidget {
  final String name;
  Trade trade;

  RequestTile({super.key, required this.name, required this.trade});

  @override
  Widget build(BuildContext context) {
    return Consumer<TradeProvider>(
      builder: (context, tp, child) {
        return Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              margin: EdgeInsets.symmetric(horizontal: 80.w),
              decoration: BoxDecoration(
                color: const Color(0xFF101123),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Avatar and Name
                  GestureDetector(
                    onTap:
                        () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(),
                          ),
                        ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40.r,
                          backgroundColor: Colors.grey,
                          child: Text(
                            name[0],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Accept button
                  GestureDetector(
                    onTap: () async {
                      var res = await tp.acceptTrade(trade);
                      print(res);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DashboardPage(),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        'Accept Trade',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
  }
}
