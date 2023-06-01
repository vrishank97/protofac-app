import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:protofac/locator.dart';
import 'package:protofac/services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final authService = getIt<AuthService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Add a workflow",
                  style: TextStyle(fontSize: 30),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepOrange,
          onPressed: () {
            context.go('/buildworkflow');
          },
          tooltip: 'Add Workflow',
          child: const Icon(Icons.add),
        ));
  }
}
