import 'dart:convert';
import 'dart:developer';

import 'package:cold_storage_flutter/extensions/string_extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'notification_constant.dart';
import 'notification_handler.dart';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.payload?.isNotEmpty ?? false) {
    final Map<String, dynamic> jsonPayload =
    jsonDecode(notificationResponse.payload!) as Map<String, dynamic>;
    // final PushNotificationData notificationData =
    // PushNotificationData.fromJson(jsonPayload);

    debugPrint('XXX notificationTapBackground jsonPayload $jsonPayload');
    // AppAnalytics.instance
    //     .trackPushNotificationClick(notificationData.actionType.toString());
    // NotificationHandler.instance.handleNotificationDirection(jsonPayload);
  }
}

/// Refer to
/// https://github.com/MaikuB/flutter_local_notifications/blob/master/flutter_local_notifications/example/lib/main.dart
class LocalNotificationService {
  factory LocalNotificationService() => instance;

  LocalNotificationService._() {
    initLocalNotification();
  }

  ///Singleton factory
  static final LocalNotificationService instance = LocalNotificationService._();

  // final AppLocalLogger _loggerBuilder =
  // AppLocalLogger('LocalNotificationService');
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static const List<AndroidNotificationChannel> _notificationChannelList =
      NotificationConstant.notificationChannelList;
  static const String _androidSmallIcon =
      NotificationConstant.notificationSmallIcon;

  final List<DarwinNotificationCategory> darwinNotificationCategories =
  <DarwinNotificationCategory>[
    const DarwinNotificationCategory(
      'app_update',
      options: <DarwinNotificationCategoryOption>{
        DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
        DarwinNotificationCategoryOption.hiddenPreviewShowSubtitle,
        DarwinNotificationCategoryOption.allowAnnouncement,
      },
    )
  ];

  bool _isEnabled = false;
  bool _isChannelCreated = false;

  Future<void> initLocalNotification() async {
    if (!_isEnabled) {
      await _createNotificationChannel();
      await _enableLocalNotification();
    }
  }

  Future<void> _enableLocalNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings(_androidSmallIcon);
    final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      notificationCategories: darwinNotificationCategories,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {
        _defaultSelectNotificationCallback(payload);
      },
    );

    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await flutterLocalNotificationsPlugin
        .initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse details) =>
            _defaultSelectNotificationCallback(details.payload),
        onDidReceiveBackgroundNotificationResponse:
        notificationTapBackground)
        .then((_) => _isEnabled = true);
  }

  Future<void> _createNotificationChannel() async {
    if (_isChannelCreated) {
      return;
    } else {
      for (final AndroidNotificationChannel channel
      in _notificationChannelList) {
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(channel);
        _isChannelCreated = true;
      }
    }
  }

  /// Called when when a user taps on a notification or a notification action.
  Future<void> _defaultSelectNotificationCallback(String? payload) async {
    debugPrint('XXX _defaultSelectNotificationCallback payload $payload');
    if (payload.isNullOrEmpty) {
      return;
    } else if (_isEnabled) {
      try {
        final Map<String, dynamic> jsonPayload =
        jsonDecode(payload!) as Map<String, dynamic>;
        // final PushNotificationData notificationData =
        // PushNotificationData.fromJson(jsonPayload);

        debugPrint(
            'XXX _defaultSelectNotificationCallback jsonPayload $jsonPayload');
        // AppAnalytics.instance
        //     .trackPushNotificationClick(notificationData.actionType.toString());
        // NotificationHandler.instance.handleNotificationDirection(jsonPayload);
      } on Exception catch (e, s) {
        // AppBugTracker.instance.captureException(
        //     message: '_defaultSelectNotificationCallback',
        //     exception: e,
        //     stackTrace: s,
        //     data: {'payload': payload});
      }
    }
  }

  // void notificationDebugPrint(String print) => _loggerBuilder.printDebug(print);
  void notificationDebugPrint(String print) => log(print);

}
