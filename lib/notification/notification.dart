import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:diary_app/model/Events.dart';
import 'package:flutter/material.dart';

class NotificationServices {
  static Future<void> initialiseNotiifcation(Events? event) async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'high_importance_channel${event == null ? '' : event.id}',
          channelName: 'basic_notification',
          channelDescription: 'basic_notification_desc',
          channelGroupKey: 'high_important_notification_group',
          defaultColor: Colors.transparent,
          ledColor: Colors.white,
          importance: NotificationImportance.Max,
          channelShowBadge: true,
          playSound: true,
          criticalAlerts: true,
        )
      ],
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'high_important_notification_group',
            channelGroupName: 'main_group')
      ],
    );
    await AwesomeNotifications().isNotificationAllowed().then(
      (value) async {
        if (!value) {
          await AwesomeNotifications().requestPermissionToSendNotifications();
        }
      },
    );
    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceiveMethod,
      onDismissActionReceivedMethod: onActionDismissActionReceiveMethod,
      onNotificationCreatedMethod: onNotificationCreateMethod,
      onNotificationDisplayedMethod: onNotificationDisplayMethod,
    );
    if (event != null) {
      scheduleNotification(event);
    }
  }

  static Future<void> onNotificationCreateMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('onNotificationCreateMethod');
  }

  static Future<void> onNotificationDisplayMethod(
      ReceivedNotification receiveNotification) async {
    debugPrint('onNotificationDisplayMethod');
  }

  static Future<void> onActionDismissActionReceiveMethod(
      ReceivedAction receivedAction) async {
    debugPrint('onDismissActionReceiveMEthod');
  }

  static Future<void> onActionReceiveMethod(
      ReceivedAction receivedAction) async {
    debugPrint('onActionReceivedMethod');
  }

  static Future<void> scheduleNotification(Events event) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: event.id!,
        channelKey: 'high_importance_channel${event.id}',
        title: event.title,
        body: event.description ?? '',
        category: NotificationCategory.Recommendation,
      ),
      schedule: NotificationCalendar(
        timeZone: AwesomeNotifications.localTimeZoneIdentifier,
        day: event.date.day,
        hour: event.reminderTime?.hour ?? 00,
        minute: event.reminderTime?.minute,
        year: event.date.year,
        month: event.date.month,
        repeats: false,
        second: 0,
      ),
    );
  }

  static Future<void> cancelNotification(int notificationId) async {
    await AwesomeNotifications().cancel(notificationId);
  }
}
