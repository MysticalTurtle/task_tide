import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task_tide/system_design/tokens/colors.dart';
import 'package:task_tide/system_design/tokens/spacing.dart';


class UICachedNetworkImage extends StatelessWidget {
  const UICachedNetworkImage({
    required this.imageUrl,
    super.key,
    this.width,
    this.height,
    this.fit,
    this.useImageBuilder = false,
    this.errorWidget,
  });
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final bool useImageBuilder;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    if (useImageBuilder) {
      return CachedNetworkImage(
        width: width,
        height: height,
        imageUrl: imageUrl,
        fit: fit ?? BoxFit.cover,
        imageBuilder: (context, imageProvioder) {
          return DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvioder,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        placeholder: (context, url) => const ShimmerLoadImage(),
        errorWidget: (context, url, error) =>
            errorWidget ??
            Container(
              padding: const EdgeInsets.all(
                UISpacing.md,
              ),
              color: CColors.secondaryColor,
              child: const Icon(Icons.error),
            ),
      );
    }
    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: imageUrl,
      fit: fit ?? BoxFit.cover,
      placeholder: (context, url) => const ShimmerLoadImage(),
      errorWidget: (context, url, error) =>
          errorWidget ??
          Container(
            padding: const EdgeInsets.all(
              UISpacing.md,
            ),
            color: CColors.secondaryColor,
            child: const Icon(Icons.error),
          ),
    );
  }
}

class ShimmerLoadImage extends StatelessWidget {
  const ShimmerLoadImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      margin: const EdgeInsets.all(4),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: const Card(color: Colors.grey),
      ),
    );
  }
}
