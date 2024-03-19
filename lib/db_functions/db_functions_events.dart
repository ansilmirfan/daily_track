// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, non_constant_identifier_names
import 'package:diary_app/model/Events.dart';
import 'package:diary_app/notification/notification.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

ValueNotifier<Map<DateTime, List<Events>>> eventNotifier = ValueNotifier({});
//adding event
Future<void> addEvents(Events event, DateTime selectedDate) async {
  final eventDb = await Hive.openBox<Events>('eventsdb');
  event.id = await eventDb.add(event);
  eventDb.put(event.id, event);
  if (!eventNotifier.value.containsKey(selectedDate)) {
    eventNotifier.value[selectedDate] = [];
  }
  eventNotifier.value[selectedDate]!.add(event);
  if (event.notification) {
    NotificationServices.initialiseNotiifcation(event);
  }
  eventNotifier.notifyListeners();
}

//updating events
Future<void> updateEvents() async {
  final eventDb = await Hive.openBox<Events>('eventsdb');
  eventNotifier.value.clear();
  for (var value in eventDb.values) {
    DateTime date = value.date;
    if (!eventNotifier.value.containsKey(date)) {
      eventNotifier.value[date] = [];
    }
    eventNotifier.value[date]!.add(value);
  }
  eventNotifier.notifyListeners();
}

//delete event
Future<void> deleteEvents(int id) async {
  final eventDb = await Hive.openBox<Events>('eventsdb');
  Events data = eventDb.get(id)!;
  if (data.notification) {
    NotificationServices.cancelNotification(id);
  }
  eventDb.delete(id);
  updateEvents();
}

//edit event
Future<void> editEvents(int id, Events value) async {
  final eventDb = await Hive.openBox<Events>('eventsdb');
  if (value.notification) {
    NotificationServices.scheduleNotification(value);
  }
  if (value.notification == false) {
    NotificationServices.cancelNotification(value.id!);
  }
  eventDb.put(id, value);
  updateEvents();
}

//searching
Future<void> searchEvent(String search) async {
  final eventDb = await Hive.openBox<Events>('eventsdb');
  eventNotifier.value.clear();
  for (var value in eventDb.values) {
    if (value.title.toLowerCase().contains(search.toLowerCase())) {
      DateTime date = value.date;
      if (!eventNotifier.value.containsKey(date)) {
        eventNotifier.value[date] = [];
      }
      eventNotifier.value[date]!.add(value);
    }
  }
  eventNotifier.notifyListeners();
}

//sort by title
Future<void> sortByTitleEvent({bool asc = true}) async {
  final eventDb = await Hive.openBox<Events>('eventsdb');
  eventNotifier.value.clear();
  List<Events> event = List.from(eventDb.values)
    ..sort((a, b) => a.title.compareTo(b.title));
  if (!asc) {
    event = List.from(event.reversed);
  }
  for (var value in event) {
    DateTime date = value.date;
    if (!eventNotifier.value.containsKey(date)) {
      eventNotifier.value[date] = [];
    }
    eventNotifier.value[date]?.add(value);
  }
  eventNotifier.notifyListeners();
}

//sort by date
Future<void> sortByDateEvent({bool asc = true}) async {
  final eventdb = await Hive.openBox<Events>('eventsdb');
  eventNotifier.value.clear();
  List<Events> event = List.from(eventdb.values)
    ..sort((a, b) => a.date.compareTo(b.date));
  if (!asc) {
    event = List.from(event.reversed);
  }
  for (var value in event) {
    DateTime date = value.date;
    if (!eventNotifier.value.containsKey(date)) {
      eventNotifier.value[date] = [];
    }
    eventNotifier.value[date]?.add(value);
  }
  eventNotifier.notifyListeners();
}
