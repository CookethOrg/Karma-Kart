import 'package:flutter/material.dart';
import 'package:karmakart/core/widgets/auth_headers/signup_head.dart';
import 'package:karmakart/core/widgets/buttons/authbuttons.dart';
import 'package:karmakart/core/widgets/textformfields/auth_form_field.dart';
import 'package:karmakart/models/form_field_data.dart';
import 'package:karmakart/providers/authentication_provider.dart';
import 'package:karmakart/screens/auth_screens/skill_selection.dart';
import 'package:provider/provider.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  final _formKey = GlobalKey<FormState>();

  final List<FormFieldData> formFields = const [
    FormFieldData(id: 'name', label: 'Name', required: true, type: 'name'),
    FormFieldData(
      id: 'username',
      label: 'Username',
      required: true,
      placeholder: 'Enter your username',
    ),
    FormFieldData(
      id: 'email',
      label: 'Email',
      required: true,
      placeholder: 'Enter your email id',
    ),
    FormFieldData(
      id: 'password',
      label: 'Password',
      required: true,
      placeholder: 'Enter your password',
      hint: 'Must be of 8 characters',
    ),
  ];

  @override
  Widget build(BuildContext context) {
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

    Widget buildNameFields() {
      final pv = Provider.of<AuthenticationProvider>(context, listen: false);
      return Row(
        children: [
          Expanded(
            child: AuthFormField(
              controller: pv.firstNameController,
              placeholder: 'First Name',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'First name is required';
                }
                return null;
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: AuthFormField(
              controller: pv.lastNameController,
              placeholder: 'Last Name',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Last name is required';
                }
                return null;
              },
            ),
          ),
        ],
      );
    }

    Widget buildInputField(FormFieldData field) {
      final pv = Provider.of<AuthenticationProvider>(context, listen: false);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AuthFormField(
            controller:
                field.id == 'username'
                    ? pv.usernameController
                    : field.id == 'email'
                    ? pv.emailController
                    : pv.passwordController,
            placeholder: field.placeholder ?? '',
            isPassword: field.id == 'password',
            validator: (value) {
              if (field.required && (value == null || value.isEmpty)) {
                return '${field.label} is required';
              }
              if (field.id == 'email' && value != null) {
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return 'Enter a valid email';
                }
              }
              if (field.id == 'password' && value != null) {
                if (value.length < 8) {
                  return 'Password must be at least 8 characters';
                }
              }
              return null;
            },
          ),
          if (field.hint != null &&
              field.id == 'password' &&
              pv.passwordController.text.length >= 8)
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 8),
              child: Text(
                field.hint!,
                style: const TextStyle(
                  color: Color(0xFF656678),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      );
    }

    Widget buildFormFields() {
      return Column(
        children:
            formFields.map((field) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildFieldLabel(field),
                    const SizedBox(height: 8),
                    if (field.id == 'name')
                      buildNameFields()
                    else
                      buildInputField(field),
                  ],
                ),
              );
            }).toList(),
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
                                SignupHead(pageIndex: pv.pageIndex),
                                const SizedBox(height: 40),
                                buildFormFields(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SignupBottom(pageIndex: pv.pageIndex, formKey: _formKey,),
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

class SignupBottom extends StatefulWidget {
  SignupBottom({super.key, required this.pageIndex, required this.formKey});
  int pageIndex;
  GlobalKey<FormState> formKey;
  @override
  State<SignupBottom> createState() => _SignupBottomState();
}

class _SignupBottomState extends State<SignupBottom> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProvider>(
      builder: (context, pv, child) {
        return Container(
          height: 97,
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
                        child: Authbuttons(
                          text: 'Log in',
                          backgroundColor: const Color(0xFF101123),
                          textColor: Colors.white,
                          onPressed: () {
                            // Navigate to login screen
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Authbuttons(
                          text: 'Next',
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                          onPressed: () async {
                            if (widget.formKey.currentState!.validate()) {
                              // Navigate to SkillSelection and wait for the result
                              pv.updatePageIndex(1);
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                           SkillSelection(),
                                ),
                              );
                              // Update pageIndex based on the result
                              if (result != null && result is int) {
                                setState(() {
                                  widget.pageIndex = result;
                                });
                              }
                            }
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
      },
    );
  }
}
