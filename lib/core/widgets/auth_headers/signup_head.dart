import 'package:flutter/material.dart';

class SignupHead extends StatelessWidget {
  int pageIndex;
  SignupHead({super.key, required this.pageIndex});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Sign up Account',
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
                            index <= pageIndex
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
                'Page ${pageIndex + 1} of 4',
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
}
