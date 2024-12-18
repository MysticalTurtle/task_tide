import 'package:flutter/material.dart';

abstract class IText extends StatelessWidget {
  const IText(
    this.label, {
    super.key,
    this.fontSize,
    this.color,
    this.fontStyle,
    this.weight,
    this.textOverflow,
    this.textAlign,
    this.letterSpacing,
    this.maxLines,
    this.textStyle,
    this.decoration,
    this.fontFamily,
    this.shadows,
  });

  final String label;
  final double? fontSize;
  final TextOverflow? textOverflow;
  final Color? color;
  final FontWeight? weight;
  final FontStyle? fontStyle;
  final TextAlign? textAlign;
  final double? letterSpacing;
  final int? maxLines;
  final TextStyle? textStyle;
  final TextDecoration? decoration;
  final String? fontFamily;
  final List<Shadow>? shadows;
}
