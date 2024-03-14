// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

var width;
var height;

GlobalKey<FormState> key = GlobalKey<FormState>();
GlobalKey<FormState> key2 = GlobalKey<FormState>();
var userName;
String? profilepicture;

var password;
late Box settingsDb;
const paddingXS = EdgeInsets.all(10);
const paddingS = EdgeInsets.all(15);
const listTileBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(15),
  ),
);
const borderradiusS = BorderRadius.all(Radius.circular(15));
const borderRadiusOnlyS = Radius.circular(15);
