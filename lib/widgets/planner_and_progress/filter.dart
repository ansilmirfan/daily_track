// ignore_for_file: must_be_immutable

import 'package:diary_app/color_and_fonts/colors.dart';
import 'package:diary_app/varibles_and_functions/variables.dart';
import 'package:flutter/material.dart';

class Filter extends StatefulWidget {
  int selectedIndex;
   final Function(int) onIndexChanged;
   Filter({super.key,this.selectedIndex=0,required this.onIndexChanged});

  @override
  State<Filter> createState() => _FilterState();
}

List<String> category = [
  'All',
  'Work',
  'Personal',
  'Hobby',
  'Lifestyle',
  'Other'
];

class _FilterState extends State<Filter> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: paddingXS,
        child: Wrap(
          spacing: 10,
          children: List.generate(
            category.length,
            (index) => ChoiceChip(
              
              selectedColor: primaryYellow,
              disabledColor: Colors.grey,
              showCheckmark: false,
              pressElevation: 10,
              label: Text(category[index]),
              onSelected: (value) {
                setState(
                  () {
                    if (value) {
                      widget.selectedIndex = index;
                      widget.onIndexChanged(index);
                    
                    } else {
                     widget.selectedIndex = index;
                    }
                  },
                );
              },
              selected: widget.selectedIndex == index,
            ),
          ),
        ),
      ),
    );
  }
}
