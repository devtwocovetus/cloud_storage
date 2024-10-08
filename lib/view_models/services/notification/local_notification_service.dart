import 'dart:convert';
import 'dart:developer';

import 'package:cold_storage_flutter/extensions/string_extension.dart';
import 'package:cold_storage_flutter/models/notification/push_notification_data.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
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
        _defaultSelectNotificationCallback(payload!);
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
            _defaultSelectNotificationCallback(details.payload!),
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
  Future<void> _defaultSelectNotificationCallback(String payload) async {
   
    if (payload.isNullOrEmpty) {
      print('<><><> calllll blank');
      return;
    } else {
       //print('XXX_payload $payload');
      try {
        Map<dynamic, dynamic> valueMap = jsonDecode(payload);
         print('XXX_payload ${valueMap.toString()}');

 



       if (valueMap['mainModule'].toString() == 'Transfer' &&
            valueMap['subModule'].toString() == 'AccountToAccount') {
          Get.toNamed(RouteName.transferIncomingMaterialScreen, arguments: [
            {
              "tranferId":valueMap['material_incoming_request_id'].toString(),
              "from": 'Notification'
            }
          ]);
        }

        if (valueMap['mainModule'].toString() == 'Transfer' &&
            valueMap['subModule'].toString() == 'EntityToEntity') {
          Get.toNamed(RouteName.entityToEntityMaterialMapping, arguments: [
            {
              "notificationId": valueMap['internal_tranfer_id'].toString(),
              "from": 'Notification',
            }
          ]);
        }

        if (valueMap['mainModule'].toString() == 'Client' &&
            valueMap['subModule'].toString() == 'ClientDetails') {
          Get.toNamed(RouteName.clientDetailsScreen, arguments: [
            {
              "clientId": valueMap['clientId'].toString(),
              "clientIsRequest": 'true',
              "clientIsManual": '0',
              "requestSent": 'false',
              "outgoingRequestAccepted": 'false',
              "incomingRequestAccepted": 'false',
              "requestIncoming": 'true',
              "from": 'Notification',
            }
          ]);
        }

        if (valueMap['mainModule'].toString() == 'Transfer' &&
            valueMap['subModule'].toString() == 'AccountToAccountAccept') {
          Get.toNamed(RouteName.transactionInOut, arguments: [
            {
              "transactionId": valueMap['transactionId'].toString(),
              "transactionDate": valueMap['transactionDate'].toString(),
              "transactionType": valueMap['transactionType'].toString(),
              "vendorClientName": valueMap['vendorClientName'].toString(),
              "senderAccount": valueMap['senderAccount'].toString(),
              "customerClientName":valueMap['customerClientName'].toString(),
              "from": 'Notification',
            }
          ]);
        }

        if (valueMap['mainModule'].toString() == 'User' &&
            valueMap['subModule'].toString() == 'Userlist') {
          Get.toNamed(RouteName.userListSetting, arguments: [
            {
              "from": 'Notification',
            }
          ])!
              .then((value) {});
        }

        if (valueMap['mainModule'].toString() == 'Entity' &&
            valueMap['subModule'].toString() == 'Entitylist') {
          Get.toNamed(RouteName.entityListScreen, arguments: [
            {"EOB": 'OLD', "from": 'Notification'}
          ])!
              .then((value) {});
        }

        if (valueMap['mainModule'].toString() == 'Client' &&
            valueMap['subModule'].toString() == 'ClientList') {
          Get.toNamed(RouteName.clientListScreen, arguments: [
            {
              "from": 'Notification',
            }
          ])!
              .then((value) {});
        }

        if (valueMap['mainModule'].toString() == 'Asset' &&
            valueMap['subModule'].toString() == 'AssetList') {
          Get.toNamed(RouteName.assetListScreen, arguments: [
            {
              "from": 'Notification',
            }
          ])!
              .then((value) {});
        }

        if (valueMap['mainModule'].toString() == 'Asset' &&
            valueMap['subModule'].toString() == 'AssignHistory') {
          Get.toNamed(RouteName.assetHistoryListScreen, arguments: [
            {
              "assetName": valueMap['assetName'].toString(),
              "assetId": valueMap['assetId'].toString(),
              "from": 'Notification',
            }
          ])!
              .then((value) {});
        }

        if (valueMap['mainModule'].toString() == 'Material' &&
            valueMap['subModule'].toString() == 'MaterialList') {
          Get.toNamed(RouteName.materialListScreen, arguments: [
            {
              "from": 'Notification',
            }
          ])!
              .then((value) {});
        }
        
      } on Exception catch (e, s) {
print('Error: $e');
        // AppBugTracker.instance.captureException(
        //     message: '_defaultSelectNotificationCallback',
        //     exception: e,
        //     stackTrace: s,
        //     data: {'payload': payload});
      }
    }
  }

   PushNotificationData? _getPNPayload(Map<String, dynamic>? message) {
    if (message == null) {
      return null;
    } else {
      try {
        return PushNotificationData.fromJson(message);
      } on Exception catch (e, s) {
        return null;
      }
    }
  }


  void notificationDebugPrint(String print) => log(print);

}
