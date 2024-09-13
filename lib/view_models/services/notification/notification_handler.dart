import 'dart:developer';

import 'local_notification_show.dart';
import 'notification_constant.dart';

class NotificationHandler {
  factory NotificationHandler() => instance;

  NotificationHandler._();

  ///Singleton factory
  static final NotificationHandler instance = NotificationHandler._();

  // final AppLocalLogger _loggerBuilder = AppLocalLogger('NotificationHandler');

/*  void handleOnMessageTrigger(PushNotificationData notificationData) {
    if (notificationData.isValidToExecute) {
      switch (notificationData.actionType?.toLowerCase()) {
        case NotificationConstant.notificationActionTypeChat:
          {
            _handleChatNotification(notificationData);
            break;
          }
        default:
          break;
      }
    } else {
      AppBugTracker.instance.captureException(
          message:
              'handleOnMessageTrigger pushNotificationData is not valid to execute');
    }
  }*/

  // void _handleChatNotification(PushNotificationData notificationData) {
  //   if (!notificationData.isDataValidToExecute) {
  //     AppBugTracker.instance.captureException(
  //         message: '_handleChatNotification pushNotificationData '
  //             'is not valid to execute');
  //     return;
  //   }
  //
  //   try {
  //     final ChatNotificationModel chatNotificationModel =
  //         ChatNotificationModel.fromJsonString(notificationData.actionData!);
  //
  //     /// Insert new chat if the chat detail page is alive and user is the same
  //     /// or else if chat room page is alive, insert new chat in the list
  //     /// lastly if all of them is not true, update the user message counter\
  //     /// then show local notification
  //
  //     if (ChatDetailVM.instance.isReadyToReceiveNotification &&
  //         ChatDetailVM.instance
  //             .isSameUser(chatNotificationModel.threadModel.user.id)) {
  //       ChatDetailVM.instance.insertMessage(chatNotificationModel.chatDetail);
  //     } else if (ChatRoomVM.instance.isReadyToReceiveNotification) {
  //       ChatRoomVM.instance
  //           .insertNewChatRoom(chatNotificationModel.threadModel);
  //     } else if (MainVM.instance.isLoggedIn) {
  //       MainVM.instance.addMessageCount();
  //       LocalNotificationShow.instance
  //           .showChatNotification(notificationData: notificationData);
  //     }
  //   } catch (e) {
  //     printDebug(e.toString());
  //   }
  // }

  /// App launched from notification,
  /// set pending action in the MainVM
  // void handleNotificationLaunch(PushNotificationData notificationData) {
  //   final AppPendingActionModel launchData =
  //       AppPendingActionModel.fromNotification(notificationData);
  //   MainVM.instance.setPendingAction(launchData);
  // }
  //
  // Future<void> handleNotificationDirection(
  //     Map<String, dynamic> jsonPayload) async {
  //   final PushNotificationData notificationData =
  //       PushNotificationData.fromJson(jsonPayload);
  //
  //   if (notificationData.isValidToExecute) {
  //     switch (notificationData.actionType!.toLowerCase()) {
  //       case NotificationConstant.notificationActionTypeChat:
  //         {
  //           _navigateToChatPage(notificationData);
  //           break;
  //         }
  //       default:
  //         break;
  //     }
  //   }
  // }

  // void _navigateToChatPage(PushNotificationData pushNotificationData) {
  //   if (!pushNotificationData.isValidToExecute) {
  //     AppBugTracker.instance.captureException(
  //         message:
  //             '_navigateToChatPage pushNotificationData is not valid to execute');
  //     return;
  //   }
  //
  //   final bool isLoggedIn = MainVM.instance.isLoggedIn;
  //   try {
  //     final ChatNotificationModel chatNotificationModel =
  //         ChatNotificationModel.fromJsonString(
  //             pushNotificationData.actionData!);
  //     if (isLoggedIn) {
  //       MainVM.instance.launchChatDetailPage(chatNotificationModel);
  //     } else {
  //       handleNotificationLaunch(pushNotificationData);
  //     }
  //   } on Exception catch (e, s) {
  //     AppBugTracker.instance.captureException(
  //       message: '_navigateToChatPage error',
  //       exception: e,
  //       stackTrace: s,
  //     );
  //   }
  // }

  void printDebug(String print) => log(print);
}
