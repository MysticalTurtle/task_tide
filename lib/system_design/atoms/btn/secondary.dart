import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UIBtnSecondary extends StatelessWidget {
  const UIBtnSecondary({
    required this.label,
    required this.onTap,
    super.key,
    this.showShadow = false,
    this.borderRadius,
  });

  final String label;
  final VoidCallback? onTap;
  final bool showShadow;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? ElevatedButton(
            key: key,
            onPressed: onTap,
            child: Text(label),
          )
        : CupertinoButton(
            key: key,
            onPressed: onTap,
            child: Text(label),
          );
  }
}
