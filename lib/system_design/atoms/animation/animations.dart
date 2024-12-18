part of 'widget.dart';

class UIAnimationData {
  const UIAnimationData(this.assetPath);

  final String assetPath;
}

extension AnimationDataExt on UIAnimationData {
  Widget animation({
    Key? key,
    double? width,
    double? height,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    BlendMode? colorBlendMode,
  }) {
    return UIAnimation(
      assetPath,
      key: key,
      width: width ?? 24,
      height: height ?? 24,
      fit: fit ?? BoxFit.contain,
      alignment: alignment,
    );
  }
}
