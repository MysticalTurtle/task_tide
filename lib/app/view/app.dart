import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_tide/app/widgets/app_notification_listener.dart';
import 'package:task_tide/app/widgets/authenticated_user_listener.dart';
import 'package:task_tide/app/widgets/network_listener.dart';
import 'package:task_tide/core/injections/providers/providers.dart';
import 'package:task_tide/core/injections/repositories/repositories.dart';
import 'package:task_tide/core/notifications/local/local_notification.dart';
import 'package:task_tide/core/notifications/remote/push_notification.dart';
import 'package:task_tide/core/routes/router.dart';
import 'package:task_tide/l10n/l10n.dart';
import 'package:task_tide/system_design/atoms/toast/msg_default.dart';

class App extends StatefulWidget {
  const App({
    required SharedPreferences prefs,
    required LocalNotification localNotification,
    required PushNotification remoteNotification,
    super.key,
  })  : _localNotification = localNotification,
        _remoteNotification = remoteNotification,
        _prefs = prefs;

  final LocalNotification _localNotification;
  final PushNotification _remoteNotification;
  final SharedPreferences _prefs;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with RouterMixin {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: Repositories.all(
        prefs: widget._prefs,
        localNotification: widget._localNotification,
        remoteNotification: widget._remoteNotification,
      ),
      child: MultiBlocProvider(
        providers: Providers.all(),
        child: AppNotificationListener(
          child: AuthenticatedUserListener(
            router: router,
            child: NetworkListener(
              child: MaterialApp.router(
                themeMode: ThemeMode.light,
                // theme: ligthThemeDefault,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                routerConfig: router,
                builder: UIToast.toastInit,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
