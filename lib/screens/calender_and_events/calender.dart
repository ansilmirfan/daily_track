// ignore_for_file: camel_case_types, unused_element, must_be_immutable, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:diary_app/db_functions/db_functions_events.dart';
import 'package:diary_app/screens/calender_and_events/add_event.dart';
import 'package:diary_app/varibles_and_functions/functioins.dart';
import 'package:diary_app/varibles_and_functions/variables.dart';
import 'package:diary_app/widgets/calender_and_event/expansion_tile.dart';
import 'package:diary_app/widgets/common/slidable.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:diary_app/widgets/common/floatingbutton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../model/Events.dart';

class Calender extends StatefulWidget {
  const Calender({super.key});

  @override
  State<Calender> createState() => _CalenderState();
}

bool isBottomSheetOpen = false;
late DateTime today;
DateTime? selectedday;
DateTime? focusDay;
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class _CalenderState extends State<Calender> {
  @override
  void initState() {
    super.initState();
    today = DateTime.now();
    updateEvents();
    selectedday = today;
    focusDay = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                DateFormat(
                  'dd MMM yyyy ',
                ).format(today),
                style: GoogleFonts.kaushanScript(),
              ),
              background: Image.asset(
                'Assets/image/images.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ValueListenableBuilder(
                  valueListenable: eventNotifier,
                  builder: (context, value, child) => TableCalendar(
                    firstDay: DateTime.utc(2010, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: focusDay ?? today,
                    availableGestures: AvailableGestures.all,
                    selectedDayPredicate: (day) {
                      return isSameDay(selectedday, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        selectedday = selectedDay;
                        focusDay = focusedDay;
                      });
                    },
                    eventLoader: (day) {
                      return value[day] ?? [];
                    },
                  ),
                ),
              ],
            ),
          ),
          ValueListenableBuilder(
            valueListenable: eventNotifier,
            builder: (context, value, child) {
              final data = value[focusDay ?? today];
              if (data == null) {
                //if no evnets
                return SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        alignment: AlignmentDirectional.center,
                        height: height / 4,
                        child: const Text('No events today'),
                      )
                    ],
                  ),
                );
              } else {
                return SliverList.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: paddingXS,
                      child: slidableWidget(
                        delete: () => deleteAlert(context, () {
                          deleteEvents(data[index].id!);
                        }),
                        edit: () {
                          showEventDialog(context,
                              edit: true, value: data[index]);
                        },
                        child: Expansiontile(
                          context,
                          event: data[index],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: !isBottomSheetOpen,
        child: floatingButton(
          onpressed: () {
            showEventDialog(context);
          },
        ),
      ),
    );
  }

  void showEventDialog(
    BuildContext context, {
    bool edit = false,
    Events? value,
  }) {
    scaffoldKey.currentState
        ?.showBottomSheet(
          (context) => AddEvent(
            selectedDay: selectedday ?? today,
            edit: edit,
            value: value,
          ),
        )
        .closed
        .whenComplete(() => setState(() {
              isBottomSheetOpen = false;
            }));
    setState(() {
      isBottomSheetOpen = true;
    });
  }
}
