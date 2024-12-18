import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_tide/system_design/atoms/atoms.dart';
import 'package:task_tide/system_design/tokens/colors.dart';
import 'package:task_tide/system_design/tokens/spacing.dart';

class UIAppBar extends StatelessWidget implements PreferredSizeWidget {
  const UIAppBar({
    this.title,
    super.key,
    this.backButtonFunction,
    this.backgroundColor = Colors.white,
    this.backButtonColor,
    this.statusBarColor,
    this.canBack = true,
    this.centerTitle = true,
    this.elevation = 0,
    this.fontWeight,
    this.showBottomBorder = true,
    this.showShadow = false,
    this.textColor,
    this.actions,
  });

  final String? title;
  final Color backgroundColor;
  final Color? statusBarColor;
  final VoidCallback? backButtonFunction;
  final bool canBack;
  final bool centerTitle;
  final double elevation;
  final FontWeight? fontWeight;
  final bool showBottomBorder;
  final bool showShadow;
  final Color? textColor;
  final Color? backButtonColor;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
      ),
      iconTheme: IconThemeData(
        color: textColor,
      ),
      backgroundColor: backgroundColor,
      elevation: showShadow ? 10.0 : elevation,
      toolbarHeight: 65,
      centerTitle: centerTitle,
      automaticallyImplyLeading: canBack,
      actions: actions,
      leading: canBack
          ? Padding(
              padding: const EdgeInsets.only(
                left: UISpacing.md,
              ),
              child: BackButton(
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(
                    EdgeInsets.zero,
                  ),
                ),
                color: backButtonColor ?? CColors.primaryColor,
                onPressed:
                    backButtonFunction ?? () => Navigator.of(context).pop(),
              ),
            )
          : null,
      title: UITextTitle(
        title ?? '',
      ),
    );
  }
}
