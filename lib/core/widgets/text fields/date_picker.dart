import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:radix_icons/radix_icons.dart';

class CustomDatePickerField extends StatefulWidget {
  final String label;
  final String buttonText;
  final TextEditingController controller;
  final ValueChanged<DateTime?>? onDateChanged;

  const CustomDatePickerField({
    super.key,
    required this.label,
    required this.buttonText,
    required this.controller,
    this.onDateChanged,
  });

  @override
  State<CustomDatePickerField> createState() => _CustomDatePickerFieldState();
}

class _CustomDatePickerFieldState extends State<CustomDatePickerField> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    // Initialize from controller if it has a value
    if (widget.controller.text.isNotEmpty) {
      try {
        final parts = widget.controller.text.split('/');
        if (parts.length == 3) {
          _selectedDate = DateTime(
            int.parse(parts[2]), 
            int.parse(parts[1]), 
            int.parse(parts[0])
          );
        }
      } catch (e) {
        // Handle parsing error
        _selectedDate = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: widget.label,
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
              child: _buildDatePickerButton(context),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDatePickerButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: _selectedDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        
        if (pickedDate != null) {
          setState(() {
            _selectedDate = pickedDate;
          });
          
          // Format date as DD/MM/YYYY and save to controller
          final formattedDate = '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
          widget.controller.text = formattedDate;
          
          // Call the callback if provided
          if (widget.onDateChanged != null) {
            widget.onDateChanged!(pickedDate);
          }
        }
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
            _selectedDate != null
                ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                : widget.buttonText,
            style: TextStyle(
              fontSize: 24.sp,
              color: _selectedDate != null ? Colors.white : const Color(0xFF656678),
            ),
          ),
          Icon(
            RadixIcons.Calendar,
            size: 32.sp,
            color: const Color(0XFF874FFF),
          ),
        ],
      ),
    );
  }
}