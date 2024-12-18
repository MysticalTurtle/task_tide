import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:task_tide/system_design/atoms/atoms.dart';
import 'package:task_tide/system_design/tokens/colors.dart';
import 'package:task_tide/system_design/tokens/radius.dart';
import 'package:task_tide/system_design/tokens/spacing.dart';

class UIToastNotication {
  UIToastNotication.show({
    required String description,
    required IconData icon,
  }) {
    BotToast.showCustomNotification(
      duration: const Duration(seconds: 5),
      align: Alignment.topCenter,
      animationDuration: const Duration(milliseconds: 200),
      wrapToastAnimation: (controller, cancel, child) => CustomAnimationWidget(
        controller: controller,
        child: child,
      ),
      toastBuilder: (void Function() cancelFunc) {
        return Padding(
          padding: const EdgeInsets.all(UISpacing.md),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(UIRadius.md),
            child: SizedBox(
              width: double.infinity,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: UIRadius.sm,
                  horizontal: UIRadius.md,
                ),
                decoration: BoxDecoration(
                  color: CColors.white,
                  borderRadius: BorderRadius.circular(UIRadius.md),
                  border: Border.all(),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: UISpacing.md,
                        ),
                        child: Icon(icon),
                      ),
                    ),
                    Expanded(
                      child: UITextBody(
                        description,
                      ),
                    ),
                    GestureDetector(
                      onTap: cancelFunc,
                      child: const SizedBox(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: UISpacing.sm,
                          ),
                          child: Icon(
                            Icons.close,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static NavigatorObserver get toastObserver => BotToastNavigatorObserver();

  static TransitionBuilder get toastInit => BotToastInit();
}

class CustomAnimationWidget extends StatefulWidget {
  const CustomAnimationWidget({
    required this.controller,
    required this.child,
    super.key,
  });
  final AnimationController controller;
  final Widget child;

  @override
  State<CustomAnimationWidget> createState() => _CustomAnimationWidgetState();
}

class _CustomAnimationWidgetState extends State<CustomAnimationWidget> {
  static final Tween<Offset> tweenOffset = Tween<Offset>(
    begin: const Offset(0, 40),
    end: Offset.zero,
  );

  static final Tween<double> tweenScale = Tween<double>(begin: 0.7, end: 1);
  late Animation<double> animation;

  @override
  void initState() {
    animation =
        CurvedAnimation(parent: widget.controller, curve: Curves.decelerate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return Transform.translate(
          offset: tweenOffset.evaluate(animation),
          child: Transform.scale(
            scale: tweenScale.evaluate(animation),
            child: Opacity(
              opacity: animation.value,
              child: child,
            ),
          ),
        );
      },
      child: widget.child,
    );
  }
}

class CustomOffsetAnimation extends StatefulWidget {
  const CustomOffsetAnimation({
    required this.controller,
    required this.child,
    super.key,
    this.reverse = false,
  });
  final AnimationController controller;
  final Widget child;
  final bool reverse;

  @override
  State<CustomOffsetAnimation> createState() => _CustomOffsetAnimationState();
}

class _CustomOffsetAnimationState extends State<CustomOffsetAnimation> {
  late Tween<Offset> tweenOffset;

  late Animation<double> animation;

  @override
  void initState() {
    tweenOffset = Tween<Offset>(
      begin: Offset(widget.reverse ? -0.8 : 0.8, 0),
      end: Offset.zero,
    );
    animation =
        CurvedAnimation(parent: widget.controller, curve: Curves.decelerate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (BuildContext context, Widget? child) {
        return FractionalTranslation(
          translation: tweenOffset.evaluate(animation),
          child: Opacity(
            opacity: animation.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
