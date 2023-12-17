import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:switcher_button/switcher_button.dart';

import '../../../News App/Components/Constant.dart';
import '../../../News App/Cubit/DarkMode.dart';

class UsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
      Row(
        children: [
          Text(
            'Dark Mode',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Spacer(),
          SwitcherButton(
              onColor: Colors.pink,
              onChange: (value) {
                DarkCubit.get(context).changeAppMode();
              }),
        ],
      ),
      SizedBox(
        height: 20.0,
      ),

      Row(
        children: [
          OutlinedButton(
              onPressed: ()
              {
                FirebaseMessaging.instance.subscribeToTopic('announcements');          //send fcm
              },
              child: Text(
                'subscribe',
              )),
          SizedBox(
            width: 20.0,
          ),
          OutlinedButton(
              onPressed: ()
              {
                FirebaseMessaging.instance.unsubscribeFromTopic('announcements');    //not send fcm

              },
              child: Text(
                'unsubscribe',
              )),
          SizedBox(
            width: 20.0,
          ),
          OutlinedButton(
            onPressed: () {
              Signout(context);
            },
            child: Text('Sign out'),
          ),
        ],
      )
    ]);
  }
}
