import 'package:task_tide/core/models/user_model.dart';
import 'package:task_tide/modules/splash/data/local/i_splash.dart';

class Splash extends ISplash {
  @override
  Future<String?> getToken() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    return 'goiwajsrgopsid';
  }

  @override
  Future<UserModel?> getUser() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    return UserModel(
      data: const Data(
        id: 654,
        email: 'sefvius',
        firstName: 'firstName',
        lastName: 'lastName',
        avatar: 'avatar',
      ),
      support: Support(url: 'url', text: 'text'),
    );
  }
}
