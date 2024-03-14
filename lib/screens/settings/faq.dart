
import 'package:diary_app/varibles_and_functions/variables.dart';
import 'package:flutter/material.dart';

class Faq extends StatefulWidget {
  const Faq({super.key});

  @override
  State<Faq> createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('FAQ'),
        actions: const [Icon(Icons.info_outline_rounded)],
      ),
      body: ListView(
        children: const [
          ExpansionTile(
            title: Text('Tips on solving laggy issue when text input'),
            children: [
              Padding(
                padding: paddingXS,
                child: Text(
                    'Laggy issues are attributed to Samsung\'s latest system update (Android 13), which introduced a text correction feature called Grammarly to the Samsung keyboard. You may meet some unusual text input experience when editing notes, not just our EasyNotes, such as'),
              ),
              Padding(
                padding: paddingXS,
                child: Text('''
• The cursor jumping up and down

• Text disappearing on its own

• The keyboard slowing down when writing longer notes

Before Samsung completely fix this problem, you can try the following solution:

• Turning Grammarly OFF in keyboard setting

1. Open keyboard settings with the small gear icon above keyboard

2. Select Suggest text corrections

3. Disable writing assistant

Hope above solutions are helpful to your note-taking experience. Any feedback
'''),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('How to set reminder ?'),
            children: [
              Padding(
                padding: paddingXS,
                child: Text('''
1. Click "More" on the top right of the edit page, then select the reminder option.

2. Set your date, then click "Save".

3. Last, save your note, and your reminder will be successfully set.
'''),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('Why does my  reminder not work?'),
            children: [
              Padding(
                padding: paddingXS,
                child: Text('''
To use Reminder normally, you should:

1. Make sure you have saved reminder successfully after editing the reminder time.

2. Turn on the display of reminders and notification sounds in your phone settings.

3. Turn on the relevant settings for application prompts in your phone settings.
'''),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('Does MyDiary Support the iOS or web vesion?'),
            children: [
              Padding(
                padding: paddingXS,
                child: Text(
                    'We currently only support Andriod phones and tablets.We are developing adaptations to other systems,so stay tuned!'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
