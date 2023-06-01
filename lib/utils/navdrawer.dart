import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:protofac/locator.dart';
import 'package:protofac/services/auth_service.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = getIt<AuthService>();

    return Drawer(
        surfaceTintColor: Colors.black,
        backgroundColor: Colors.white,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.yellow,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(authService.loggedInUser!.photoURL!),
                          radius: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(authService.loggedInUser!.displayName!),
                      ],
                    ),
                  ],
                )),
            ListTile(
              title: const Text('Home'),
              onTap: () async {
                context.go('/');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Sign Out'),
              onTap: () async {
                await authService
                    .loginOutWithGoogle()
                    .then((value) => context.go('/login'));
              },
            ),
          ],
        ));
  }
}
