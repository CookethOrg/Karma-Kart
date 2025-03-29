import 'package:flutter/material.dart';
import 'package:karmakart/core/services/supabase_service.dart';
import 'package:karmakart/core/widgets/dashboard_search_bar.dart';
import 'package:karmakart/core/widgets/drawers/dashboard_drawer.dart';
import 'package:karmakart/models/trade.dart';
import 'package:karmakart/providers/authentication_provider.dart';
import 'package:karmakart/providers/trade_provider.dart';
import 'package:karmakart/screens/dashboard_page.dart';
import 'package:provider/provider.dart';
import 'package:radix_icons/radix_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'recommended_for_you_page.dart';

class TradeDetailsPage extends StatefulWidget {
  Trade trade;
  TradeDetailsPage({super.key, required this.trade});

  @override
  State<TradeDetailsPage> createState() => _TradeDetailsPageState();
}

class _TradeDetailsPageState extends State<TradeDetailsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFF020315),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              _buildBackButton(),
              SizedBox(height: 10.h),
              _buildJobTitleSection(),
              SizedBox(height: 10.h),
              _buildKarmaPoints(),
              SizedBox(height: 10.h),
              _buildUserInfo(),
              SizedBox(height: 10.h),
              _buildJobDescription(),
              SizedBox(height: 10.h),
              _buildSkillTags(),
              SizedBox(height: 10.h),
              _buildDeliveryDate(),
              SizedBox(height: 10.h),
              _buildRequestButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF10101E),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          // Navigate to RecommendedForYouPage instead of popping
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Widget _buildJobTitleSection() {
    return Text(
      widget.trade.heading,
      style: TextStyle(
        color: Colors.white,
        fontSize: 42.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildKarmaPoints() {
    return Text(
      widget.trade.price.toString(),
      style: TextStyle(
        color: Color(0xFF874FFF),
        fontSize: 36.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildUserInfo() {
    return Consumer<TradeProvider>(
      builder: (context, supa, child) {
        // final name = await supa.fetchClientUserName(widget.trade);
        return Row(
          children: [
            CircleAvatar(
              radius: 30.r,
              backgroundColor: Colors.grey[700],
              backgroundImage: AssetImage('assets/images-3.jpeg'),
            ),
            SizedBox(width: 10.w),
            Text(
              'hey',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 5.w),
            Icon(Icons.verified, color: Colors.blue, size: 30.sp),
          ],
        );
      },
    );
  }

  Widget _buildJobDescription() {
    return Text(
      widget.trade.description,
      style: TextStyle(color: Colors.grey[400], fontSize: 30.sp),
    );
  }

  Widget _buildSkillTags() {
    return Row(
      children:
          widget.trade.tags
              .map(
                (skill) => Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 3.h,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFF1D1F2E),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        skill,
                        style: TextStyle(color: Colors.white, fontSize: 20.sp),
                      ),
                      SizedBox(width: 4.w),
                      // Icon(Icons.close, color: Colors.white, size: 14.sp),
                    ],
                  ),
                ),
              )
              .toList(),
    );
  }

  Widget _buildDeliveryDate() {
    return Row(
      children: [
        Text(
          "Expected Delivery Date: ",
          style: TextStyle(color: Colors.grey[500], fontSize: 30.sp),
        ),
        Text(
          widget.trade.expectedDeliveryTime,
          style: TextStyle(color: Colors.white, fontSize: 30.sp),
        ),
      ],
    );
  }

  Widget _buildRequestButton() {
    return GestureDetector(
          onTap: () {},
          child: Center(
            child: Container(
              width: 300.w,
              height: 20.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                child: Text(
                  "Send Request",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        );
  }
}
