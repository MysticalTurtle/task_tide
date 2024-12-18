import 'package:flutter/material.dart';
import 'package:task_tide/system_design/atoms/text/i_text.dart';
import 'package:task_tide/system_design/tokens/colors.dart';
import 'package:task_tide/system_design/tokens/typography.dart';

class UITextTitle extends IText {
  const UITextTitle(
    super.label, {
    super.key,
    super.textAlign,
    super.weight,
    super.color,
    super.textOverflow,
    super.letterSpacing,
    super.maxLines,
    super.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      key: key,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize ?? TTypography.title,
        color: color ?? CColors.black,
        fontStyle: FontStyle.normal,
        fontWeight: weight ?? FontWeight.w500,
        letterSpacing: letterSpacing,
      ),
      overflow: textOverflow,
      maxLines: maxLines,
    );
  }
}

class UITextBody extends IText {
  const UITextBody(
    super.label, {
    super.key,
    super.textAlign,
    super.weight,
    super.color,
    super.textOverflow,
    super.letterSpacing,
    super.maxLines,
    super.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      key: key,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize ?? TTypography.body1,
        color: color ?? CColors.black,
        fontStyle: FontStyle.normal,
        fontWeight: weight ?? FontWeight.w500,
        letterSpacing: letterSpacing,
      ),
      overflow: textOverflow,
      maxLines: maxLines,
    );
  }
}
