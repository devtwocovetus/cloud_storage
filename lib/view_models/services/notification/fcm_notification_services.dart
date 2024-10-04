import 'dart:developer';
import 'dart:io';

import 'package:cold_storage_flutter/models/notification/push_notification_data.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/view_models/services/notification/notification_handler.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import 'local_notification_show.dart';

class FCMNotificationService {
  factory FCMNotificationService() => instance;

  FCMNotificationService._();

  ///Singleton factory
  static final FCMNotificationService instance = FCMNotificationService._();

  final FirebaseMessaging _fireBaseMessaging = FirebaseMessaging.instance;

  bool _isFcmEnabled = false;
  bool _iosWebPermissionRequested = false;
  String? _fbToken;

  /// Disable / Enable FCM service
  void enableFCMNotification(
    bool enable, {
    bool autoRegisterToken = true,
    bool autoRequestPermissionIos = true,
  }) {
    if (enable) {
      _enableFCM(
        autoRegisterToken: autoRegisterToken,
        autoRequestPermissionIos: autoRequestPermissionIos,
      );
    } else {
      _disableFCM();
    }
  }

  /// Enable FCM service
  void _enableFCM({
    bool autoRegisterToken = true,
    bool autoRequestPermissionIos = true,
  }) {
    if (_isFcmEnabled) {
      /// FCM service already enabled, check whether iOS permission is requested
      _fcmPermissionIOS();

      /// FCM service already enabled, register token to server
      _registerTokenToServer();

      print('enabled, FCM services registered');
    } else {
      /// Enable FCM
      _setFcmListener();

      if (autoRequestPermissionIos) {
        _fcmPermissionIOS();
      }

      if (autoRegisterToken) {
        /// Register FCM token to the server
        _registerTokenToServer();
      }

      _isFcmEnabled = true;
      print('enabled');
    }
  }

  /// Disable FCM and unregister FCM token to server
  void _disableFCM() {
    _isFcmEnabled = false;
    _iosWebPermissionRequested = false;
    _apiDeleteToken();
    print('disabled');
  }

  /// FireBase Cloud Messaging Setting
  Future<void> _setFcmListener() async {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) => _defaultOnMessage(message),
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) => _defaultOnResume(message),
    );

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  /// IOS Specific Permission to display Notification
  Future<void> _fcmPermissionIOS() async {
    if (_iosWebPermissionRequested) {
      return;
    } else if (Platform.isIOS) {
      await _fireBaseMessaging
          .requestPermission(
        sound: true,
        badge: true,
        alert: true,
        announcement: false,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
      )
          .then((NotificationSettings settings) {
        print('iOS setting registered: $settings');
        _iosWebPermissionRequested = true;
      });
    } else {
      _iosWebPermissionRequested = true;
    }
  }

  /// Save FCM token to the server
  Future<void> _registerTokenToServer() async {
    final String fcmToken = await getFbToken;

    print('FCM Token = $fcmToken');
    _apiSaveToken(token: fcmToken);
  }

  /// This is needed to clear the user token in the server
  /// so the user will not receive any push notification anymore
  void _apiDeleteToken() {
    _apiSaveToken();
  }

  /// API call to save FCM token to the server
  void _apiSaveToken({String? token}) {
    try {
      /// Register fcm token to server
      // AuthApiController().updatePushNotificationToken(token: token);
    } on Exception catch (e, s) {
      // AppBugTracker.instance.captureException(
      //   message: '_apiSaveToken error',
      //   exception: e,
      //   stackTrace: s,
      // );
    }
  }

  /// Called when push notification received when app is on foreground
  Future<void> _defaultOnMessage(RemoteMessage message) async {
    print('Foreground push notification received : ${message.toMap()}');

    try {
      // final PushNotificationData? notificationData =
      // _getPNPayload(message.data);
      //
      // if (notificationData == null) {
      //   return;
      // } else if (notificationData.isValidToExecute) {
      //   NotificationHandler.instance.handleOnMessageTrigger(notificationData);
      // } else if (notificationData.body.isNotNullOrEmpty) {
      //   LocalNotificationShow.instance.showSimpleNotification(
      //     title: notificationData.title,
      //     body: notificationData.body,
      //   );
      // }

      LocalNotificationShow.instance.showSimpleNotification(
        title: message.notification?.title.toString() ?? '',
        body: message.notification?.body ?? '',
      );
    } on Exception catch (e, s) {
      // AppBugTracker.instance.captureException(
      //   message: '_defaultOnMessage error',
      //   exception: e,
      //   stackTrace: s,
      // );
    }
  }

  /// Called when push notification received when app is on background
  /// and notification clicked while app is still on background
  /// to push app to foreground with notification
  Future<void> _defaultOnResume(RemoteMessage message) async {
    onClickNotificationHandler(message, 'onResume');
  }

  /// Called when push notification received when app is dead
  /// and notification clicked to launch the app
  Future<void> defaultOnLaunch(RemoteMessage? message) async {
    if (message == null) {
      return;
    }

    print('OnLaunch push notification received : $message');

    try {
      final PushNotificationData? notificationData =
          _getPNPayload(message.data);
      if (notificationData != null) {
        if (notificationData.mainModule == 'Transfer' &&
            notificationData.subModule == 'AccountToAccount') {
          Get.toNamed(RouteName.transferIncomingMaterialScreen, arguments: [
            {
              "tranferId":
                  notificationData.materialIncomingRequestId.toString(),
              "from": 'Notification'
            }
          ]);
        }

        if (notificationData.mainModule == 'Transfer' &&
            notificationData.subModule == 'EntityToEntity') {
          Get.toNamed(RouteName.entityToEntityTransferScreen, arguments: [
            {
              "toEntityName": notificationData.toEntityName.toString(),
              "toEntityId": notificationData.toEntityId.toString(),
              "toEntityType": notificationData.toEntityType.toString(),
              "entityName": notificationData.entityName.toString(),
              "entityId": notificationData.entityId.toString(),
              "entityType": notificationData.entityType.toString(),
              "from": 'Notification',
            }
          ]);
        }

        if (notificationData.mainModule == 'Client' &&
            notificationData.subModule == 'ClientDetails') {
          Get.toNamed(RouteName.clientDetailsScreen, arguments: [
            {
              "clientId": notificationData.clientId.toString(),
              "clientIsRequest": notificationData.clientIsRequest.toString(),
              "clientIsManual": notificationData.clientIsManual.toString(),
              "requestSent": notificationData.requestSent.toString(),
              "outgoingRequestAccepted":
                  notificationData.outgoingRequestAccepted.toString(),
              "incomingRequestAccepted":
                  notificationData.incomingRequestAccepted.toString(),
              "requestIncoming": notificationData.requestIncoming.toString(),
              "from": 'Notification',
            }
          ]);
        }
      }
    } on Exception catch (e, s) {
      // AppBugTrsacker.instance.captureException(
      //   message: 'defaultOnLaunch error',
      //   exception: e,
      //   stackTrace: s,
      // );
    }
  }

  void defaultNotificationHandler(RemoteMessage message, String fromState) {
    print('$fromState Push Notification received : ${message.data.toString()}');
    try {
      // final PushNotificationData? notificationData =
      // _getPNPayload(message.data);
      // if (notificationData != null) {
      //   AppAnalytics.instance
      //       .trackPushNotificationClick(notificationData.actionType.toString());
      //   NotificationHandler.instance
      //       .handleNotificationDirection(notificationData.toJson());
      // }
    } on Exception catch (e, s) {
      // AppBugTracker.instance.captureException(
      //   message: 'defaultNotificationHandler error',
      //   exception: e,
      //   stackTrace: s,
      // );
    }
  }

  void onClickNotificationHandler(RemoteMessage message, String fromState) {
    print('$fromState Push Notification received : ${message.data.toString()}');
    try {
     final PushNotificationData? notificationData =
          _getPNPayload(message.data);
      if (notificationData != null) {
        if (notificationData.mainModule == 'Transfer' &&
            notificationData.subModule == 'AccountToAccount') {
          Get.toNamed(RouteName.transferIncomingMaterialScreen, arguments: [
            {
              "tranferId":
                  notificationData.materialIncomingRequestId.toString(),
              "from": 'Notification'
            }
          ]);
        }

        if (notificationData.mainModule == 'Transfer' &&
            notificationData.subModule == 'EntityToEntity') {
          Get.toNamed(RouteName.entityToEntityTransferScreen, arguments: [
            {
              "toEntityName": notificationData.toEntityName.toString(),
              "toEntityId": notificationData.toEntityId.toString(),
              "toEntityType": notificationData.toEntityType.toString(),
              "entityName": notificationData.entityName.toString(),
              "entityId": notificationData.entityId.toString(),
              "entityType": notificationData.entityType.toString(),
              "from": 'Notification',
            }
          ]);
        }

        if (notificationData.mainModule == 'Client' &&
            notificationData.subModule == 'ClientDetails') {
          Get.toNamed(RouteName.clientDetailsScreen, arguments: [
            {
              "clientId": notificationData.clientId.toString(),
              "clientIsRequest": notificationData.clientIsRequest.toString(),
              "clientIsManual": notificationData.clientIsManual.toString(),
              "requestSent": notificationData.requestSent.toString(),
              "outgoingRequestAccepted":
                  notificationData.outgoingRequestAccepted.toString(),
              "incomingRequestAccepted":
                  notificationData.incomingRequestAccepted.toString(),
              "requestIncoming": notificationData.requestIncoming.toString(),
              "from": 'Notification',
            }
          ]);
        }
      }
    } on Exception catch (e, s) {
      // AppBugTracker.instance.captureException(
      //   message: 'defaultNotificationHandler error',
      //   exception: e,
      //   stackTrace: s,
      // );
    }
  }

  Future<String> get getFbToken async {
    _fbToken ??= await _fireBaseMessaging.getToken();
    return _fbToken!;
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
}
