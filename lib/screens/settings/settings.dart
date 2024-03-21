// ignore_for_file: library_private_types_in_public_api, camel_case_types

import 'dart:io';
import 'package:diary_app/screens/settings/privacy_policy.dart';
import 'package:diary_app/screens/settings/change_password.dart';
import 'package:diary_app/screens/settings/faq.dart';
import 'package:diary_app/screens/intro_screens/user_details.dart';
import 'package:diary_app/varibles_and_functions/functioins.dart';
import 'package:diary_app/varibles_and_functions/variables.dart';
import 'package:diary_app/widgets/common/rating.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Settings'),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop('update'),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const ListTile(
                title: Text(
                  'General',
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
              ),
              //change profile
              ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: FileImage(
                    File(profilepicture!),
                  ),
                ),
                title: Text(
                  userName,
                  style: const TextStyle(fontSize: 25),
                ),
                trailing: GestureDetector(
                  onTap: () async {
                    await Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (context) =>
                            UserDetails(alreadyloggedin: true),
                      ),
                    )
                        .then((value) {
                      setState(() {});
                    });
                  },
                  child: const Wrap(
                    children: [
                      Text(
                        'Change profile',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      Icon(Icons.arrow_forward_ios_rounded)
                    ],
                  ),
                ),
              ),
              //change password
              ListTile(
                leading: const Icon(Icons.lock),
                title: const Text(
                  'Change password',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () => navigatePush(
                  context,
                  changePassword(alreadyloggein: true),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(),
              ),
              //about
              const ListTile(
                title: Text(
                  'About',
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
              ),
              //rate
              ListTile(
                leading: const Icon(Icons.star_border),
                title: const Text('Rate us'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => Rating(
                      context: context,
                    ),
                  );
                },
              ),
              //faq
              ListTile(
                leading: const Icon(Icons.question_mark_outlined),
                title: const Text('FAQ'),
                onTap: () {
                  navigatePush(
                    context,
                    const Faq(),
                  );
                },
              ),

              //privacy policy
              ListTile(
                leading: const Icon(
                  Icons.shield_outlined,
                ),
                title: const Text(
                  'Privacy policy',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  navigatePush(
                    context,
                    PrivacyPolicy(),
                  );
                },
              ),
              const ListTile(
                leading: Icon(Icons.layers_outlined),
                title: Text('Version:1.0.0'),
              )
            ],
          ),
        ],
      ),
    );
  }
}

Future<String> initPlatformState() async {
  String platformVersion;

  try {
    platformVersion = Platform.version;
  } on PlatformException {
    platformVersion = 'Failed to get platform version.';
  }
  return platformVersion;
}
