import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationConstant {
  static const String fcmDefaultTopic = 'all_topic';
  static const String notificationActionTypeChat = 'chat_update';

  // static const String notificationSmallIcon = 'notification_small_icon';
  static const String notificationSmallIcon = '@mipmap/ic_launcher';
  // static const String notificationBigIcon = 'notification_big_icon';
  static const String notificationBigIcon = '@mipmap/ic_launcher';

  static const String androidDefaultNotificationSound =
      'default_notification_sound';
  static const String iosDefaultNotificationSound =
      'default_notification_sound.aiff';

  /// Notification Id
  static const int defaultNotificationID = 100;
  // static const int defaultChatNotificationID = 2000;

  /// Android notification channel start
  static const String defaultChannelID = 'ag_tech_default_notification';
  // static const String chatChannelID = 'soundsplore_chat_notification';
  static const AndroidNotificationChannel defaultNotificationChannel =
  AndroidNotificationChannel(
    defaultChannelID,
    'AgTech Notification',
    description: 'AgTech default notification channel',
    importance: Importance.high,
    sound: RawResourceAndroidNotificationSound(androidDefaultNotificationSound),
  );

  // static const AndroidNotificationChannel chatNotificationChannel =
  // AndroidNotificationChannel(
  //   chatChannelID,
  //   'Soundsplore Chat Notification',
  //   description: 'Soundsplore chat notification channel',
  //   importance: Importance.high,
  //   sound: RawResourceAndroidNotificationSound(androidDefaultNotificationSound),
  // );

  static const List<AndroidNotificationChannel> notificationChannelList =
  <AndroidNotificationChannel>[
    defaultNotificationChannel,
    // chatNotificationChannel,
  ];

/// Android notification channel end

}
