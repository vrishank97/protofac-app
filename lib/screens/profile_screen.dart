import 'package:flutter/material.dart';
import 'package:protofac/locator.dart';
import 'package:protofac/services/user_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final userService = getIt.get<UserService>();

  @override
  Widget build(BuildContext context) {
    var name = userService.getUser()!.displayName;
    return Center(
      child: Text("Welcome $name"),
    );
  }
}
