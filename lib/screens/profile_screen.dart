import 'package:flutter/material.dart';
import 'package:protofac/locator.dart';
import 'package:protofac/services/user_service.dart';

class Profile_screen extends StatefulWidget {
  const Profile_screen({super.key});

  @override
  State<Profile_screen> createState() => _Profile_screenState();
}

class _Profile_screenState extends State<Profile_screen> {
  final userService = getIt.get<UserService>();

  @override
  Widget build(BuildContext context) {
    var name = userService.getUser()!.displayName;
    return Center(
      child: Text("Welcome $name"),
    );
  }
}
