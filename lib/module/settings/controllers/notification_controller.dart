import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationController extends GetxController {
  static const String _notificationKey = 'notifications_enabled';

  bool notificationsEnabled = true;
  bool isLoading = true;

  late SharedPreferences _preferences;

  @override
  void onInit() {
    super.onInit();
    _loadNotificationSetting();
  }

  Future<void> _loadNotificationSetting() async {

    _preferences = await SharedPreferences.getInstance();
    notificationsEnabled = _preferences.getBool(_notificationKey) ?? true;
    isLoading = false;
    update();
  }

  Future<void> toggleNotifications(bool value) async {
    notificationsEnabled = value;
    update();
    await _preferences.setBool(_notificationKey, value);
    
  }
}
