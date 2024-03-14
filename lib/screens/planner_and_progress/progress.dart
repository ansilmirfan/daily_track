import 'package:diary_app/db_functions/db_functions_planner.dart';
import 'package:diary_app/screens/planner_and_progress/linear_progress.dart';
import 'package:diary_app/varibles_and_functions/functioins.dart';
import 'package:diary_app/varibles_and_functions/variables.dart';
import 'package:diary_app/widgets/common/silver_bar.dart';
import 'package:diary_app/widgets/planner_and_progress/all_progress.dart';
import 'package:flutter/material.dart';

class Progress extends StatefulWidget {
  const Progress({super.key});

  @override
  State<Progress> createState() => _ProgressState();
}

List<String> category = [
  'Work',
  'Personal',
  'Hobby',
  'Lifestyle',
  'Other',
];

class _ProgressState extends State<Progress> {
  @override
  void initState() {
    super.initState();
    updatePlanner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SilvarBar(
            searchbar: false,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ValueListenableBuilder(
                  valueListenable: plannerNotifier,
                  builder: (context, value, child) {
                    return Padding(
                      padding: paddingXS,
                      child: Wrap(
                        runSpacing: 10,
                        alignment: WrapAlignment.center,
                        children: [
                          allCircularProgress(
                            doneCount: doneCount('All', value),
                            totalCount: totalCount('All', value),
                          ),
                          ...List.generate(
                            category.length,
                            (index) => linearProgress(
                              category: category[index],
                              doneCount: doneCount(category[index], value),
                              totalCount: totalCount(category[index], value),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
