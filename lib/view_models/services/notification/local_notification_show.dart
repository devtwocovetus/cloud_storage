import 'dart:developer';

import 'package:cold_storage_flutter/extensions/string_extension.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../../res/colors/app_color.dart';
import 'local_notification_service.dart';
import 'notification_constant.dart';

class LocalNotificationShow {
  factory LocalNotificationShow() => instance;

  LocalNotificationShow._() {
    init();
  }

  ///Singleton factory
  static final LocalNotificationShow instance = LocalNotificationShow._();

  // final AppLocalLogger _loggerBuilder = AppLocalLogger('LocalNotificationShow');

  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  bool _isEnabled = false;
  int _simpleNotificationIDIncrement = 0;
  int _simpleWithPayloadNotificationIDIncrement = 0;

  void init() {
    if (!_isEnabled) {
      flutterLocalNotificationsPlugin =
          LocalNotificationService.instance.flutterLocalNotificationsPlugin;
      _isEnabled = true;
    }
  }

  /// Cancel notification
  Future<void> cancelNotification({
    int notificationID = NotificationConstant.defaultNotificationID,
  }) async =>
      await flutterLocalNotificationsPlugin?.cancel(notificationID);

  /// Show notification start
  Future<void> showSimpleNotification({
    required String title,
    String? body,
    int notificationID = NotificationConstant.defaultNotificationID,
    bool cancelSameNotification = false,
    String? payload,
  }) async {
    final int notificationId = notificationID + _simpleNotificationIDIncrement;
    if (cancelSameNotification) {
      await cancelNotification(notificationID: notificationId);
    }
    flutterLocalNotificationsPlugin?.show(
      notificationId,
      title,
      body,
      platformNotificationDetails(),
      payload: payload,
    );
    _simpleNotificationIDIncrement++;
  }

  /// Show notification start
  Future<void> showSimpleNotificationWithPayload({
    required String title,
    String? body,
    String? payload,
    int notificationID = NotificationConstant.defaultNotificationID,
    bool cancelSameNotification = false,
  }) async {
    if (cancelSameNotification) {
      await cancelNotification(
          notificationID:
          notificationID + _simpleWithPayloadNotificationIDIncrement);
    }
    flutterLocalNotificationsPlugin?.show(
        notificationID + _simpleWithPayloadNotificationIDIncrement,
        title,
        body,
        platformNotificationDetails(),
        payload: payload);
    _simpleWithPayloadNotificationIDIncrement++;
  }
  //
  // Future<void> showChatNotification({
  //   required PushNotificationData notificationData,
  //   bool cancelSameNotification = true,
  // }) async {
  //   if (!notificationData.isDataValidToExecute) {
  //     return;
  //   }
  //
  //   try {
  //     final ChatNotificationModel chatNotificationModel =
  //     ChatNotificationModel.fromJson(
  //         jsonDecode(notificationData.actionData!) as Map<String, dynamic>);
  //
  //     final int notificationID =
  //         NotificationConstant.defaultChatNotificationID +
  //             chatNotificationModel.chatDetail.id;
  //
  //     if (cancelSameNotification) {
  //       await cancelNotification(notificationID: notificationID);
  //     }
  //
  //     flutterLocalNotificationsPlugin?.show(
  //         notificationID,
  //         notificationData.title,
  //         notificationData.body,
  //         platformNotificationDetails(
  //             channelID: NotificationConstant.chatChannelID),
  //         payload: notificationData.toJsonString);
  //   } on Exception catch (e, s) {
  //     AppBugTracker.instance.captureException(
  //       message: 'showChatNotification error',
  //       exception: e,
  //       stackTrace: s,
  //     );
  //   }
  // }

  NotificationDetails platformNotificationDetails({
    String? channelID,
    bool useAndroidSound = true,
    bool useBigIcon = false,
    bool useBigText = true,
  }) {
    final AndroidNotificationDetails androidDetail =
    aosNotificationDetails(channelID: channelID, useBigIcon: useBigIcon);
    final DarwinNotificationDetails iOSDetail = iosNotificationDetails();
    return NotificationDetails(android: androidDetail, iOS: iOSDetail);
  }

  AndroidNotificationDetails aosNotificationDetails({
    String? channelID,
    bool useAndroidSound = true,
    bool useBigIcon = false,
    bool useBigText = true,
  }) {
    AndroidNotificationChannel androidNotificationChannel =
        NotificationConstant.defaultNotificationChannel;

    if (channelID != null) {
      try {
        androidNotificationChannel = NotificationConstant
            .notificationChannelList
            .firstWhere((AndroidNotificationChannel element) {
              return element.id.ignoreCase(channelID);
            });
      } catch (e) {
        printDebug('AndroidNotificationDetails not found $e');
      }
    }

    return AndroidNotificationDetails(
      androidNotificationChannel.id,
      androidNotificationChannel.name,
      channelDescription: androidNotificationChannel.description,
      icon: NotificationConstant.notificationSmallIcon,
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      onlyAlertOnce: true,
      largeIcon: useBigIcon
          ? const DrawableResourceAndroidBitmap(
          NotificationConstant.notificationBigIcon)
          : null,
      styleInformation: useBigText ? const BigTextStyleInformation('') : null,
      color: kAppPrimary,
    );
  }

  DarwinNotificationDetails iosNotificationDetails({
    bool useIOSSound = true,
  }) {
    return DarwinNotificationDetails(
        sound: useIOSSound
            ? NotificationConstant.iosDefaultNotificationSound
            : null,
        presentSound: true);
  }

  // void printDebug(String print) => _loggerBuilder.printDebug(print);
  void printDebug(String print) => log(print);

}
