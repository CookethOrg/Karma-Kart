import 'package:flutter/material.dart';
import 'package:karmakart/models/form_field_data.dart';
import 'package:karmakart/providers/authentication_provider.dart';
import 'package:karmakart/screens/auth_screens/bio_profile.dart';
import 'package:provider/provider.dart';

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
          const Text(
            'Skill Selection', // Fixed typo
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 27),
          SizedBox(
            width: 164,
            child: Column(
              children: [
                Row(
                  children: List.generate(
                    4,
                    (index) => Expanded(
                      child: Container(
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 1),
                        decoration: BoxDecoration(
                          color:
                              index <= auth.pageIndex
                                  ? Colors.white
                                  : const Color(0xFF0F1120),
                          borderRadius: BorderRadius.circular(19),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 11),
                Text(
                  'Page ${auth.pageIndex + 1} of 4',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
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
          height: 48,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 12,
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
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (field.required)
              const TextSpan(
                text: '*',
                style: TextStyle(
                  color: Color(0xFFF24822),
                  fontSize: 12,
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
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: const TextStyle(
            color: Color(0xFF656678),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          filled: true,
          fillColor: const Color(0xFF0F1120),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          errorStyle: const TextStyle(color: Color(0xFFF24822), fontSize: 10),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFF24822), width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFF24822), width: 1),
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
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildFieldLabel(formFields[0]),
                const SizedBox(height: 8),
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
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildFieldLabel(formFields[1]),
                const SizedBox(height: 8),
                buildTextField(
                  controller: auth.link1Controller,
                  placeholder: formFields[1].placeholder ?? '',
                ),
                const SizedBox(height: 8),
                buildTextField(
                  controller: auth.link2Controller,
                  placeholder: formFields[1].placeholder ?? '',
                ),
                const SizedBox(height: 8),
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
        height: 97, // Fixed height
        color: const Color(0xFF020315),
        child: Column(
          children: [
            Container(height: 1, color: const Color(0xFF101123)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 36,
                  vertical: 24,
                ),
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
                    const SizedBox(width: 12),
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
                  constraints: const BoxConstraints(maxWidth: 428),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 37),
                        child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildHeader(),
                                const SizedBox(height: 40),
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
