import 'package:chat_app/widgets/chat_messages.dart';
import 'package:chat_app/widgets/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void setupPushNotifications() async {
    final fcm = FirebaseMessaging.instance;

    // Must call this method first
    // To Ask permission to receive Notif.
    final notificationSettings = await fcm.requestPermission();
    // We can use `notificationSettings` for Fine Tuning

    // This gets the Address of Device on which App is Running
    final token = await fcm.getToken();
    print(token);
    // You can send this token to Backend via HTTP/SDK..
    // To use by other Apps to send Notifications to this device

    fcm.subscribeToTopic('chat');
  }

  @override
  void initState() {
    super.initState();

    // We cant use `async` in initState
    // Hence using a Helper Function
    setupPushNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chat'),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: ChatMessages()),
          NewMessage(),
        ],
      ),
    );
  }
}
