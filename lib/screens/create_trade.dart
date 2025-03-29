import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karmakart/core/widgets/custom_tag_selector.dart';
import 'package:karmakart/providers/trade_provider.dart';
import 'package:provider/provider.dart';
import 'package:radix_icons/radix_icons.dart';
import 'package:karmakart/core/widgets/text fields/text_field.dart';
import 'package:karmakart/core/widgets/text fields/date_picker.dart';
// import 'package:karmakart/core/widgets/text fields/tag_selector.dart';
import 'package:karmakart/core/widgets/text fields/kp_selector.dart';

class TradeCreationPage extends StatelessWidget {
  TradeCreationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TradeProvider>(
      builder: (context, tradeProvider, child) {
        return Scaffold(
          backgroundColor: Color(0XFF020315),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 48.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 32.h),
                  Text(
                    'Create a Trade',
                    style: TextStyle(
                      fontSize: 52.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Fill out the details to make a new trade',
                    style: TextStyle(fontSize: 28.sp, color: Color(0xFF656678)),
                  ),
                  SizedBox(height: 24.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        controller: tradeProvider.headingController,
                        hintText: 'Enter a heading for your trade',
                        labelText: 'Heading',
                        maxLines: 1,
                        isRequired: true,
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        controller: tradeProvider.descriptionController,
                        hintText:
                            'Enter a detailed description for your project',
                        labelText: 'Description of your trade',
                        maxLines: 4,
                      ),
                      SizedBox(height: 16.h),
                      CustomDatePickerField(
                        label: 'Delivery Time',
                        buttonText: 'Expected Delivery Time',
                        controller: tradeProvider.deliveryDateController,
                        onDateChanged: (date) {
                          print('selected date: $date');
                        },
                      ),
                      SizedBox(height: 16.h),
                      CustomTagSelector(initialTags: tradeProvider.myTags),
                      SizedBox(height: 16.h),
                      CustomKarmaPointsField(
                        controller: tradeProvider.karmaPointsController,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
