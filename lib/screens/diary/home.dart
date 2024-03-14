// ignore_for_file: file_names
import 'package:diary_app/color_and_fonts/colors.dart';
import 'package:diary_app/db_functions/db_functions_diary.dart';
import 'package:diary_app/screens/diary/diary_create.dart';
import 'package:diary_app/varibles_and_functions/functioins.dart';
import 'package:diary_app/varibles_and_functions/variables.dart';
import 'package:diary_app/widgets/common/calender_search.dart';
import 'package:diary_app/widgets/common/silver_bar.dart';
import 'package:diary_app/widgets/diary/diarylist.dart';
import 'package:diary_app/widgets/common/floatingbutton.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

DateTime? selectedDate;
TextEditingController searchController = TextEditingController();
bool isExpanded = false;

class _HomeState extends State<Home> {
  @override
  void initState() {
    updateDiaryValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(
              const Duration(seconds: 2
              ),
            );
            updateDiaryValues();
            selectedDate = null;
          },
          child: CustomScrollView(
            slivers: [
              SilvarBar(
                searchbar: true,
                settingsInAction: true,
                controller: searchController,
                onChanged: (value) {
                  searchDiary(value);
                },
                controllerClear: () {
                  searchController.clear();
                  updateDiaryValues();
                },
              ),
              //list

              SliverToBoxAdapter(
                child: ValueListenableBuilder(
                  valueListenable: diaryNotifier,
                  builder: (context, value, child) => Visibility(
                    visible: value.isEmpty,
                    child: SizedBox(
                      height: height / 2,
                      child: Image.asset('Assets/image/no data found.avif'),
                    ),
                  ),
                ),
              ),

              ValueListenableBuilder(
                valueListenable: diaryNotifier,
                builder: (context, value, child) {
                  List data = [];
                  if (selectedDate != null) {
                    data = value
                        .where((element) =>
                            element.dateTime.year == selectedDate!.year &&
                            element.dateTime.month == selectedDate!.month &&
                            element.dateTime.day == selectedDate!.day)
                        .toList();
                  } else {
                    data = List.from(value);
                  }
                  if (data.isEmpty) {
                    return SliverToBoxAdapter(
                      child: Container(
                        height: height / 3,
                        width: width,
                        alignment: Alignment.center,
                        child: const Text(
                            'No entries found for the selected date'),
                      ),
                    );
                  }

                  return SliverList.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return diaryList(
                        diary: data[index],
                        context: context,
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
        floatingActionButton: Wrap(
          direction: Axis.vertical,
          spacing: 10,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: primaryYellow,
                  shape: BoxShape.circle,
                ),
                child: calenderSearch(
                    context: context, updateDate: updateSelectedDate)),
            floatingButton(
              onpressed: () {
                navigatePush(
                  context,
                  const DiaryCreate(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void updateSelectedDate(DateTime? date) {
    setState(() {
      selectedDate = date;
    });
  }
}
