import 'package:flutter/material.dart';

class AppNotificationListener extends StatefulWidget {
  const AppNotificationListener({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  State<AppNotificationListener> createState() =>
      _AppNotificationListenerState();
}

class _AppNotificationListenerState extends State<AppNotificationListener> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
