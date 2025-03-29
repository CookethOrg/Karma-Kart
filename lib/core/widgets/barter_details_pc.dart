import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'barter_item_pc.dart';

class BarterDetails extends StatelessWidget {
  final List<BarterItem> items;

  const BarterDetails({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Barter Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 42.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12.h),
        ...items.map(
          (item) => Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: BarterItemWidget(
              name: item.name,
              service: item.service,
              points: item.points,
            ),
          ),
        ),
      ],
    );
  }
}

class BarterItem {
  final String name;
  final String service;
  final int points;

  BarterItem({required this.name, required this.service, required this.points});
}
