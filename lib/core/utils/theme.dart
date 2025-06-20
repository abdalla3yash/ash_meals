import 'package:ash_cart/core/resources/resources.dart';
import 'package:flutter/material.dart';

abstract class AppTheme{
  static ThemeData get lightTheme => ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    primaryColor: AppColors.primary,
  );
}