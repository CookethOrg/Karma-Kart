import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final IconData? prefixIcon;
  final int? maxLines;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final void Function(String)? onChanged;
  final bool isRequired;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    this.prefixIcon,
    this.maxLines,
    this.obscureText,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.isRequired = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: labelText,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.w500,
            ),
            children: isRequired
                ? [
                    TextSpan(
                      text: ' *',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 24.sp,
                      ),
                    ),
                  ]
                : [],
          ),
        ),
        SizedBox(height: 4.h),
        TextFormField(
          controller: controller,
          maxLines: maxLines ?? 1,
          obscureText: obscureText ?? false,
          keyboardType: keyboardType,
          validator: validator,
          onChanged: onChanged,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.sp,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Color(0xFF656678),
              fontSize: 24.sp,
            ),
            prefixIcon: prefixIcon != null
                ? Icon(
                    prefixIcon,
                    color: Color(0xFF0F1120),
                  )
                : null,

            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),

            // Focused border
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF874FFF),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),

            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red.withOpacity(0.7),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),

            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),

            filled: true,
            fillColor: Colors.white.withOpacity(0.05),

            contentPadding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 4.h,
            ),
          ),
        ),
      ],
    );
  }
}
