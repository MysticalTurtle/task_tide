import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_tide/app/view/app.dart';
import 'package:task_tide/core/routes/my_routes.dart';
import 'package:task_tide/modules/auth/ui/login/login_page.dart';
import 'package:task_tide/modules/home/home_page.dart';
import 'package:task_tide/modules/splash/ui/page/splash_page.dart';
import 'package:task_tide/modules/task/create/ui/page/create_task_page.dart';
import 'package:task_tide/modules/task/edit/ui/page/edit_task_page.dart';
import 'package:task_tide/modules/task/list/domain/entities/task_entity.dart';
import 'package:task_tide/modules/task/list/ui/widgets/task_detail_page.dart';
import 'package:task_tide/system_design/atoms/toast/msg_default.dart';
import 'package:task_tide/system_design/templates/error_page.dart';

mixin RouterMixin on State<App> {
  GoRouter get router => _goRouter;

  late final GoRouter _goRouter = GoRouter(
    observers: [UIToast.toastObserver],
    initialLocation: AppRoutes.splash.toPath,
    routes: <GoRoute>[
      GoRoute(
        path: AppRoutes.splash.toPath,
        name: AppRoutes.splash.toName,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.home.toPath,
        name: AppRoutes.home.toName,
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            path: AppRoutes.editTask.toPath,
            name: AppRoutes.editTask.toName,
            pageBuilder: (context, state) {
              final extra = state.extra as Map<String, dynamic>? ?? {};
              final task = extra['task'] as TaskEntity;

              return MaterialPage<void>(
                key: state.pageKey,
                child: EditTaskPage(
                  task: task,
                ),
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.login.toPath,
        name: AppRoutes.login.toName,
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: const LoginPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.createTask.toPath,
        name: AppRoutes.createTask.toName,
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: const CreateTaskPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.taskDetail.toPath,
        name: AppRoutes.taskDetail.toName,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final task = extra['task'] as TaskEntity;

          return MaterialPage<void>(
            key: state.pageKey,
            child: TaskDetailPage(task: task),
          );
        },
      ),
    ],
    errorBuilder: (context, state) => const ErrorPage(),
  );
}
