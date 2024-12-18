enum AppRoutes {
  splash,
  home,
  login,
  editTask,
  createTask,
  taskDetail,
}

extension AppPageExtension on AppRoutes {
  String get toPath {
    return switch (this) {
      AppRoutes.splash => '/splash',
      AppRoutes.home => '/home',
      AppRoutes.login => '/login',
      AppRoutes.editTask => '/editTask',
      AppRoutes.createTask => '/createTask',
      AppRoutes.taskDetail => '/taskDetail',
    };
  }

  String get toName {
    return switch (this) {
      AppRoutes.splash => 'splash',
      AppRoutes.home => 'home',
      AppRoutes.login => 'login',
      AppRoutes.editTask => 'editTask',
      AppRoutes.createTask => 'createTask',
      AppRoutes.taskDetail => 'taskDetail',
    };
  }
}
