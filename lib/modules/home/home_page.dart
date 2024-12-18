import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tide/core/notifications/remote/i_push_notification.dart';
import 'package:task_tide/l10n/l10n.dart';
import 'package:task_tide/modules/settings/settings_page.dart';
import 'package:task_tide/modules/task/list/ui/page/task_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final selectedIndex = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    final push = context.read<IPushNotification>();
    push.requestPermision().then((hasPermission) {
      if (hasPermission) {
        push.setupInteractMessage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SafeArea(
      top: false,
      child: Material(
        child: ValueListenableBuilder<int>(
          valueListenable: selectedIndex,
          builder: (context, pos, _) {
            return Column(
              children: [
                Expanded(
                  child: IndexedStack(
                    index: pos,
                    children: const [
                      TaskPage(),
                      SettingsPage(),
                      Placeholder(
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                BottomNavigationBar(
                  currentIndex: pos,
                  onTap: (index) {
                    selectedIndex.value = index;
                  },
                  items: [
                    BottomNavigationBarItem(
                      icon: const Icon(Icons.home),
                      label: l10n.home,
                    ),
                    BottomNavigationBarItem(
                      icon: const Icon(Icons.settings),
                      label: l10n.settings,
                    ),
                    BottomNavigationBarItem(
                      icon: const Icon(Icons.notifications),
                      label: l10n.notifications,
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
