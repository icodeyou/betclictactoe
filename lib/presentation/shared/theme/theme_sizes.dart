import 'package:flutter/material.dart';

/// All sizes (height and width, paddings, margins) are defined in this class

class ThemeSizes {
  /// XXXS size
  static const double xxxs = 2;

  /// XXS size
  static const double xxs = 4;

  /// XS size
  static const double xs = 8;

  /// S size
  static const double s = 12;

  /// M size
  static const double m = 16;

  /// L size
  static const double l = 20;

  /// XL size
  static const double xl = 24;

  /// XXL size
  static const double xxl = 32;

  /// XXXL size
  static const double xxxl = 40;
}

/// Size extensions on double
extension ThemeSizesExtensions on double {
  /// Transform double into EdgeInsets, applied on all sides
  EdgeInsets get asInsets => EdgeInsets.all(this);
}

/// Size extensions on EdgeInsets
extension EwaSizesInsetsExtensions on EdgeInsets {
  /// Remove vertical borders
  EdgeInsets get horizontalOnly => copyWith(top: 0, bottom: 0);

  /// Remove horizontal borders
  EdgeInsets get verticalOnly => copyWith(right: 0, left: 0);

  /// Only left border
  EdgeInsets get leftOnly => copyWith(top: 0, right: 0, bottom: 0);

  /// Only top border
  EdgeInsets get topOnly => copyWith(left: 0, right: 0, bottom: 0);

  /// Only right border
  EdgeInsets get rightOnly => copyWith(top: 0, left: 0, bottom: 0);

  /// Only bottom border
  EdgeInsets get bottomOnly => copyWith(top: 0, left: 0, right: 0);

  /// Only left border
  EdgeInsets get withoutLeft => copyWith(left: 0);

  /// Only top border
  EdgeInsets get withoutTop => copyWith(top: 0);

  /// Only right border
  EdgeInsets get withoutRight => copyWith(right: 0);

  /// Only bottom border
  EdgeInsets get withoutBottom => copyWith(bottom: 0);

  /// Override left border
  EdgeInsets withLeft(double value) => copyWith(left: value);

  /// Override top border
  EdgeInsets withTop(double value) => copyWith(top: value);

  /// Override right border
  EdgeInsets withRight(double value) => copyWith(right: value);

  /// Override bottom border
  EdgeInsets withBottom(double value) => copyWith(bottom: value);
}
