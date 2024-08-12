import 'package:expense_tracker/pages/borrow.dart';
import 'package:expense_tracker/pages/chatbot.dart';
import 'package:expense_tracker/pages/lend.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'calendernote.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: kColorScheme.primaryContainer,
        child: ListView(
          children: [
            DrawerHeader(
              // Example with a simple header
              decoration: BoxDecoration(
                color: kColorScheme.primary,
              ),
              child: const Center(
                child: Text(
                  'Expenses Manager',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.note_alt_outlined),
              title: const Text('Note'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CalendarScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.monetization_on_outlined),
              title: const Text('Money Borrowed'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BorrowPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.monetization_on),
              title: const Text('Money Lend'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LendPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.chat_bubble_outline),
              title: const Text('ChatBot'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatBotPage()));
              },
            ),
          ],
        ));
  }
}
