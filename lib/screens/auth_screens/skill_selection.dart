import 'package:flutter/material.dart';
import 'package:karmakart/models/form_field_data.dart';
import 'package:karmakart/providers/authentication_provider.dart';
import 'package:karmakart/screens/auth_screens/bio_profile.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkillSelection extends StatelessWidget {
  // final int pageIndex;
  SkillSelection({super.key});
  final _formKey = GlobalKey<FormState>();

  final List<FormFieldData> formFields = const [
    FormFieldData(
      id: 'skills',
      label: 'Enter your skills in plain text',
      required: true,
      placeholder: '',
    ),
    FormFieldData(
      id: 'links',
      label: 'Add links to your social media, portfolio etc.',
      required: false,
      placeholder: 'Enter link',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthenticationProvider>(context, listen: false);
    Widget buildHeader() {
      return Column(
        children: [
          Text(
            'Skill Selection', // Fixed typo
            style: TextStyle(
              color: Colors.white,
              fontSize: 50.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 15.h),
          SizedBox(
            width: 364.w,
            child: Column(
              children: [
                Row(
                  children: List.generate(
                    4,
                    (index) => Expanded(
                      child: Container(
                        height: 8.h,
                        margin: EdgeInsets.symmetric(horizontal: 1.w),
                        decoration: BoxDecoration(
                          color:
                              index <= auth.pageIndex
                                  ? Colors.white
                                  : const Color(0xFF0F1120),
                          borderRadius: BorderRadius.circular(19.r),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Page ${auth.pageIndex + 1} of 4',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget buildButton({
      required String text,
      required Color backgroundColor,
      required Color textColor,
      required VoidCallback onPressed,
    }) {
      return GestureDetector(
        onTap: onPressed,
        child: Container(
          height: 48.h,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 27.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );
    }

    Widget buildFieldLabel(FormFieldData field) {
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: field.label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 27.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (field.required)
              TextSpan(
                text: '*',
                style: TextStyle(
                  color: Color(0xFFF24822),
                  fontSize: 27.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
      );
    }

    Widget buildTextField({
      required TextEditingController controller,
      required String placeholder,
      bool isPassword = false,
      String? Function(String?)? validator,
    }) {
      return TextFormField(
        controller: controller,
        obscureText: isPassword,
        style: TextStyle(
          color: Colors.white,
          fontSize: 27.sp,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: TextStyle(
            color: Color(0xFF656678),
            fontSize: 27.sp,
            fontWeight: FontWeight.w500,
          ),
          filled: true,
          fillColor: const Color(0xFF0F1120),
          contentPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide.none,
          ),
          errorStyle: TextStyle(color: Color(0xFFF24822), fontSize: 20.sp),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: Color(0xFFF24822), width: 1.w),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: Color(0xFFF24822), width: 1.w),
          ),
        ),
        validator: validator,
        textAlign: TextAlign.left,
      );
    }

    Widget buildFormFields() {
      return Column(
        children: [
          // Skills field
          Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildFieldLabel(formFields[0]),
                SizedBox(height: 8.h),
                buildTextField(
                  controller: auth.skillsController,
                  placeholder: formFields[0].placeholder ?? '',
                  validator: (value) {
                    if (formFields[0].required &&
                        (value == null || value.isEmpty)) {
                      return 'Skills are required';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          // Links section
          Padding(
            padding: EdgeInsets.only(bottom: 15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildFieldLabel(formFields[1]),
                SizedBox(height: 8.h),
                buildTextField(
                  controller: auth.link1Controller,
                  placeholder: formFields[1].placeholder ?? '',
                ),
                SizedBox(height: 8.h),
                buildTextField(
                  controller: auth.link2Controller,
                  placeholder: formFields[1].placeholder ?? '',
                ),
                SizedBox(height: 8.h),
                buildTextField(
                  controller: auth.link3Controller,
                  placeholder: formFields[1].placeholder ?? '',
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget buildBottomSection() {
      return Container(
        height: 45.h, // Fixed height
        color: const Color(0xFF020315),
        child: Column(
          children: [
            Container(height: 1.h, color: const Color(0xFF101123)),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: buildButton(
                        text: 'Back',
                        backgroundColor: const Color(0xFF101123),
                        textColor: Colors.white,
                        onPressed: () {
                          auth.updatePageIndex(auth.pageIndex - 1);
                          Navigator.pop(context, auth.pageIndex);
                        },
                      ),
                    ),
                    SizedBox(width: 12.h),
                    Expanded(
                      child: buildButton(
                        text: 'Next',
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            print('Form is valid, proceeding...');
                          }
                          auth.updatePageIndex(auth.pageIndex + 1);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BioProfileSetup(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Consumer<AuthenticationProvider>(
      builder: (context, pv, child) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              color: const Color(0xFF020315),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 828.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50.w),
                        child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildHeader(),
                                SizedBox(height: 20.h),
                                buildFormFields(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      buildBottomSection(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
