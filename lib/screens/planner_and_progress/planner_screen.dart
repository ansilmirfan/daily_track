// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:diary_app/db_functions/db_functions_planner.dart';
import 'package:diary_app/screens/planner_and_progress/planner_create.dart';
import 'package:diary_app/varibles_and_functions/variables.dart';
import 'package:diary_app/widgets/common/floatingbutton.dart';
import 'package:diary_app/widgets/common/silver_bar.dart';
import 'package:diary_app/widgets/common/calender_search.dart';
import 'package:diary_app/widgets/planner_and_progress/filter.dart';
import 'package:diary_app/widgets/planner_and_progress/planner_list.dart';
import 'package:diary_app/widgets/common/slidable.dart';
import 'package:diary_app/widgets/common/sort.dart';
import 'package:flutter/material.dart';

class Planner extends StatefulWidget {
  const Planner({super.key});
  @override
  State<Planner> createState() => _PlannerState();
}

bool isExpanded = false;
TextEditingController searchController = TextEditingController();

int selectedChipIndex = 0;
List<String> category = [
  'All',
  'Work',
  'Personal',
  'Hobby',
  'Lifestyle',
  'Other'
];
DateTime? selectedDate;

class _PlannerState extends State<Planner> {
  @override
  void initState() {
    super.initState();
    updatePlanner();
    selectedChipIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(
              const Duration(seconds: 2),
            );
            updatePlanner();
            selectedDate = null;
          },
          child: CustomScrollView(
            slivers: [
              SilvarBar(
                searchbar: true,
                controllerClear: () => searchController.clear(),
                onChanged: (value) {
                  searchplanner(value);
                },
                controller: searchController,
                settingsInAction: true,
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.only(right: 15, top: 10),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Wrap(
                          spacing: 10,
                          children: [
                            calenderSearch(
                              context: context,
                              updateDate: updateSelectedDate,
                            ),
                            sort(event: false),
                          ],
                        ),
                      ),
                    ),
                    Filter(
                      onIndexChanged: updateSelectedIndex,
                      selectedIndex: selectedChipIndex,
                    ),
                  ],
                ),
              ),
              ValueListenableBuilder(
                valueListenable: plannerNotifier,
                builder: (context, value, child) {
                  var data = value.toList();
                  if (selectedDate != null) {
                    data = value
                        .where(
                          (element) =>
                              element.date.year == selectedDate!.year &&
                              element.date.month == selectedDate!.month &&
                              element.date.day == selectedDate!.day,
                        )
                        .toList();
                  }
                  if (data.isNotEmpty) {
                    if (selectedChipIndex == 0) {
                      data = data.toList();
                    } else {
                      data = data
                          .where((element) =>
                              element.category == category[selectedChipIndex])
                          .toList();
                    }
                  }
                  if (data.isEmpty) {
                    return SliverList(
                      delegate: SliverChildListDelegate([
                        Image.asset('Assets/image/no data found.avif'),
                      ]),
                    );
                  } else {
                    return SliverList.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) => Padding(
                        padding: paddingXS,
                        child: slidableWidget(
                          delete: () => deletePlanner(data[index].id!),
                          edit: () => showBottomSheet(
                            context: context,
                            builder: (context) => CreatePlanner(
                              edit: true,
                              planner: data[index],
                              context: context,
                            ),
                          ),
                          child: plannerList(
                            planner: data[index],
                          ),
                        ),
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
        floatingActionButton: floatingButton(
          onpressed: () {
            showBottomSheet(
              context: context,
              builder: (context) => CreatePlanner(
                context: context,
              ),
            );
          },
        ),
      ),
    );
  }

  void updateSelectedIndex(int index) {
    setState(() {
      selectedChipIndex = index;
    });
  }

  void updateSelectedDate(DateTime? date) {
    setState(() {
      selectedDate = date;
    });
  }
}
