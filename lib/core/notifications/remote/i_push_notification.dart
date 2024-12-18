abstract class IPushNotification {
  Future<void> getFCMToken();
  Future<bool> requestPermision();
  Future<void> setupInteractMessage();
  Future<void> init();
}
