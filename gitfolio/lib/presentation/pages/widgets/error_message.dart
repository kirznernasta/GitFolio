import 'package:flutter/material.dart';
import 'package:gitfolio/presentation/utils/constants/app_dimensions.dart';
import 'package:gitfolio/presentation/utils/constants/app_fonts.dart';

class ErrorMessage extends StatelessWidget {
  final String message;

  const ErrorMessage({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.bigMargin),
      child: Text(
       message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: AppFonts.headlineSmall,
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
