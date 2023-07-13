import 'package:chat_app/widgets/chat_messages.dart';
import 'package:chat_app/widgets/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void setupPushNotification() async {
    final fcm = FirebaseMessaging.instance;

    //final NotificationSettings = await fcm.requestPermission();
    await fcm.requestPermission();

    // final token = await fcm.getToken();

    //print(token);//you could send this token (via HTTP or the Firestore SDK)to a backend

    fcm.subscribeToTopic('chat');
  }

  @override
  void initState() {
    super.initState();

    // final fcm = FirebaseMessaging.instance;

    //fcm.requestPermission();//this return a future but we init state not expects to receive future.

    setupPushNotification();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('FlutterChat'),
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                icon: Icon(
                  Icons.exit_to_app,
                  color: Theme.of(context).colorScheme.primary,
                ))
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child:
                  ChatMessages(), //wrap with expanded to allow chat_message widget to take up as much space as it can get.
            ),
            NewMessage(),
          ],
        ));
  }
}
