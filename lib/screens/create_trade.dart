import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karmakart/core/widgets/buttons/authbuttons.dart';
import 'package:karmakart/core/widgets/custom_tag_selector.dart';
import 'package:karmakart/core/widgets/text%20fields/date_picker.dart';
import 'package:karmakart/core/widgets/text%20fields/kp_selector.dart';
import 'package:karmakart/core/widgets/text%20fields/text_field.dart';
import 'package:karmakart/models/trade.dart';
import 'package:karmakart/providers/trade_provider.dart';
import 'package:karmakart/screens/dashboard_page.dart';
import 'package:provider/provider.dart';

class TradeCreationPage extends StatelessWidget {
  final Trade? originalTrade; // The original trade being responded to
  final bool isResponseTrade; // Indicates if this is a response trade

  TradeCreationPage({
    super.key,
    this.originalTrade,
    this.isResponseTrade = false, // Default to false (new trade)
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<TradeProvider>(
      builder: (context, tradeProvider, child) {
        return Scaffold(
          backgroundColor: const Color(0XFF020315),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 48.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 32.h),
                  Text(
                    isResponseTrade ? 'Respond to Trade' : 'Create a Trade',
                    style: TextStyle(
                      fontSize: 52.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    isResponseTrade
                        ? 'Fill out the details to respond to this trade'
                        : 'Fill out the details to make a new trade',
                    style: TextStyle(fontSize: 28.sp, color: const Color(0xFF656678)),
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
                        hintText: 'Enter a detailed description for your project',
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
                      SizedBox(height: 16.h),
                      Authbuttons(
                        text: isResponseTrade ? 'Send Response' : 'Proceed',
                        backgroundColor: Colors.white,
                        onPressed: () async {
                          if (isResponseTrade && originalTrade != null) {
                            // Handle response trade creation
                            final res = await tradeProvider.createResponseTrade(
                              originalTrade: originalTrade!,
                              heading: tradeProvider.headingController.text,
                              description: tradeProvider.descriptionController.text,
                              tags: tradeProvider.myTags,
                              price: double.parse(tradeProvider.karmaPointsController.text),
                              expectedDeliveryDate: tradeProvider.deliveryDateController.text,
                            );
                            if (res == 'Response Trade Posted') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Response Trade Posted Successfully!'),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const DashboardPage(),
                                ),
                              );
                            } else {
                              print(res);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(res),
                                  duration: const Duration(seconds: 3),
                                ),
                              );
                            }
                          } else {
                            // Handle new trade creation (existing logic)
                            final res = await tradeProvider.createTrade(
                              heading: tradeProvider.headingController.text,
                              description: tradeProvider.descriptionController.text,
                              tags: tradeProvider.myTags,
                              price: double.parse(tradeProvider.karmaPointsController.text),
                              expectedDeliveryDate: tradeProvider.deliveryDateController.text,
                            );
                            if (res == 'Trade Posted') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Trade Posted Successfully!'),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const DashboardPage(),
                                ),
                              );
                            } else {
                              print(res);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(res),
                                  duration: const Duration(seconds: 3),
                                ),
                              );
                            }
                          }
                        },
                        textColor: Colors.black,
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