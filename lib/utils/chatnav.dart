import 'package:flutter/material.dart';

class ChatNav extends StatelessWidget {
  const ChatNav({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        "ProtoFac",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
      ),
      backgroundColor: Colors.deepOrange,
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.black),
    );
  }
}
