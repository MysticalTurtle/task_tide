import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

part 'animations.dart';


class UIAnimation extends StatelessWidget {
  const UIAnimation(
    this.path, {
    super.key,
    this.width,
    this.height,
    this.fit,
    this.alignment = Alignment.center,
  });

  final String path;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      path,
      width: width ?? 200,
      height: height ?? 200,
      fit: fit ?? BoxFit.contain,
      alignment: alignment,
    );
  }
}
