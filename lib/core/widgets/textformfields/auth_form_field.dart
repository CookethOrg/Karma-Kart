import 'package:flutter/material.dart';
import 'package:karmakart/providers/authentication_provider.dart';
import 'package:provider/provider.dart';

class AuthFormField extends StatelessWidget {
  AuthFormField({super.key, required this.controller, this.isPassword = false, required this.placeholder, required this.validator});
  TextEditingController controller;
  String placeholder;
  bool isPassword;
  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProvider>(
      builder: (context, pv, child) {
        return TextFormField(
          controller: controller,
          obscureText: isPassword && !pv.isPasswordVisible,
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
            suffixIcon:
                isPassword
                    ? IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        pv.isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: const Color(0xFF656678),
                        size: 16,
                      ),
                      onPressed: pv.setPasswordVisibility,
                    )
                    : null,
          ),
          validator: validator,
          textAlign: TextAlign.left,
        );
      }
    );
  }
}
