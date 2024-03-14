// ignore_for_file: camel_case_types, unused_element

import 'package:diary_app/color_and_fonts/colors.dart';
import 'package:diary_app/db_functions/db_functions_events.dart';
import 'package:diary_app/model/Events.dart';
import 'package:diary_app/screens/calender_and_events/add_event.dart';
import 'package:diary_app/varibles_and_functions/functioins.dart';
import 'package:diary_app/varibles_and_functions/variables.dart';
import 'package:diary_app/widgets/calender_and_event/expansion_tile.dart';
import 'package:diary_app/widgets/common/calender_search.dart';
import 'package:diary_app/widgets/common/inputfield.dart';
import 'package:diary_app/widgets/common/sort.dart';
import 'package:diary_app/widgets/common/slidable.dart';
import 'package:flutter/material.dart';

class EventSceen extends StatefulWidget {
  const EventSceen({super.key});

  @override
  State<EventSceen> createState() => _EventSceenState();
}

DateTime? selectedDate;
TextEditingController controller = TextEditingController();

class _EventSceenState extends State<EventSceen> {
  @override
  void initState() {
    super.initState();
    updateEvents();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Events'),
          actions: [
            calenderSearch(context: context, updateDate: updateDate),
            const SizedBox(
              width: 15,
            ),
            sort(
              event: true,
            ),
            const SizedBox(
              width: 15,
            )
          ],
        ),
        body: Column(
          children: [
            Wrap(
              children: [
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: paddingS,
                    child: inputField(
                      labeltext: 'Search',
                      labelcolor: primaryBlack,
                      field_textcolor: primaryBlack,
                      controller: controller,
                      hinttext: 'Search...',
                      leading: const Icon(Icons.search),
                      trailing: IconButton(
                        onPressed: () {
                          controller.clear();
                          updateEvents();
                        },
                        icon: const Icon(Icons.close),
                      ),
                      onChanged: (value) {
                        searchEvent(value);
                      },
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: eventNotifier,
                builder: (context, value, child) {
                  List<Events> allEvents = [];
                  value.forEach((key, values) {
                    allEvents.addAll(values);
                  });
                  if (selectedDate != null) {
                    allEvents = allEvents
                        .where((element) =>
                            element.date.year == selectedDate!.year &&
                            element.date.month == selectedDate!.month &&
                            element.date.day == selectedDate!.day)
                        .toList();
                  }
                  if (value.isEmpty) {
                    return Center(
                      child: Image.asset('Assets/image/no data found.avif'),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      await Future.delayed(
                        const Duration(seconds: 2),
                      );
                      updateEvents();
                      selectedDate = null;
                    },
                    child: ListView.builder(
                      itemCount: allEvents.length,
                      itemBuilder: (context, index) {
                        var event = allEvents[index];
                        return Padding(
                          padding: paddingXS,
                          child: slidableWidget(
                            delete: () => deleteAlert(
                              context,
                              () {
                                deleteEvents(event.id!);
                              },
                            ),
                            edit: () {
                              showEventDialog(context,
                                  edit: true, event: event);
                            },
                            child: Expansiontile(
                              context,
                              event: event,
                              trailing: true,
                              onChanged: (v) {
                                event.notification = v;
                                editEvents(event.id!, event);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void showEventDialog(
    BuildContext context, {
    bool edit = false,
    Events? event,
  }) {
    showBottomSheet(
      elevation: 10,
      context: context,
      builder: (context) => AddEvent(
        selectedDay: event!.date,
        edit: edit,
        value: event,
      ),
    );
  }

  void updateDate(DateTime? date) {
    setState(() {
      selectedDate = date;
    });
  }
}
