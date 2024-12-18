import 'package:flutter/widgets.dart';
import 'package:task_tide/system_design/tokens/spacing.dart';

class UIVerticalSpace {
  const UIVerticalSpace._();

  static Widget xxs = const SizedBox(
    height: UISpacing.xxs,
  );

  static Widget xs = const SizedBox(
    height: UISpacing.xs,
  );

  static Widget sm = const SizedBox(
    height: UISpacing.sm,
  );

  static Widget sl = const SizedBox(
    height: UISpacing.sl,
  );

  static Widget md = const SizedBox(
    height: UISpacing.md,
  );

  static Widget lg = const SizedBox(
    height: UISpacing.lg,
  );

  static Widget xl = const SizedBox(
    height: UISpacing.xl,
  );

  static Widget xxl = const SizedBox(
    height: UISpacing.xxl,
  );
}

class UIHorizontalSpace {
  UIHorizontalSpace._();

  static Widget xxs = const SizedBox(
    width: UISpacing.xxs,
  );

  static Widget xs = const SizedBox(
    width: UISpacing.xs,
  );

  static Widget sm = const SizedBox(
    width: UISpacing.sm,
  );

  static Widget sl = const SizedBox(
    width: UISpacing.sl,
  );

  static Widget md = const SizedBox(
    width: UISpacing.md,
  );

  static Widget lg = const SizedBox(
    width: UISpacing.lg,
  );

  static Widget xl = const SizedBox(
    width: UISpacing.xl,
  );

  static Widget xxl = const SizedBox(
    width: UISpacing.xxl,
  );
}

class UIBox {
  UIBox._();

  static Widget empty = const SizedBox.shrink();
}
