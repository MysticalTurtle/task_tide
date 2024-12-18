import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:task_tide/system_design/atoms/atoms.dart';
import 'package:task_tide/system_design/tokens/colors.dart';
import 'package:task_tide/system_design/tokens/radius.dart';
import 'package:task_tide/system_design/tokens/spacing.dart';

class UIToast {
  UIToast.show({
    required String description,
    ToastAlign toastAlign = ToastAlign.small,
    Alignment? alignment,
    Duration? duration,
  }) {

    BotToast.showCustomText(
      duration: duration ?? const Duration(seconds: 2),
      align: alignment ?? Alignment.bottomCenter,
      toastBuilder: (cancelFunc) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
              constraints: constraints.copyWith(
                maxWidth: constraints.biggest.width * 0.6,
                maxHeight: constraints.biggest.height * 0.6,
              ),
              child: Padding(
                padding: EdgeInsets.only(bottom: toastAlign.value),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(UIRadius.md),
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      color: CColors.blueGreen9,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: UISpacing.sm,
                        horizontal: UISpacing.md,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(
                          UIRadius.md,
                        ),
                        border: Border.all(),
                      ),
                      child: UITextBody(
                        description,
                        color: CColors.white,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  UIToast.dismiss() {
    BotToast.cleanAll();
  }
  static NavigatorObserver get toastObserver => BotToastNavigatorObserver();

  static TransitionBuilder get toastInit => BotToastInit();
}
