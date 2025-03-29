import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:radix_icons/radix_icons.dart';

class CustomDatePickerField extends StatelessWidget {
  final String label;
  final DateTime? startDate;
  final DateTime? endDate;
  final ValueChanged<DateTime?> onStartDateChanged;
  final ValueChanged<DateTime?> onEndDateChanged;

  const CustomDatePickerField({
    Key? key,
    required this.label,
    this.startDate,
    this.endDate,
    required this.onStartDateChanged,
    required this.onEndDateChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: label,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              TextSpan(
                text: '*',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4.h),
        Row(
          children: [
            Expanded(
              child: _buildDatePickerButton(
                context,
                'Start Date',
                startDate,
                onStartDateChanged,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: _buildDatePickerButton(
                context,
                'End Date',
                endDate,
                onEndDateChanged,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDatePickerButton(
    BuildContext context,
    String buttonText,
    DateTime? selectedDate,
    ValueChanged<DateTime?> onDateChanged,
  ) {
    return ElevatedButton(
      onPressed: () async {
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        onDateChanged(pickedDate);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0F1120),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 24.w),
        elevation: 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            selectedDate != null
                ? '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'
                : buttonText,
            style: TextStyle(
              fontSize: 24.sp,
              color: Color(0xFF656678),
            ),
          ),
          Icon(
            RadixIcons.Calendar,
            size: 32.sp,
            color: Color(0XFF874FFF),
          ),
        ],
      ),
    );
  }
}