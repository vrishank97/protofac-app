import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:protofac/locator.dart';
import 'package:protofac/services/analytics_service.dart';
import 'package:protofac/services/auth_service.dart';
import 'package:protofac/services/user_service.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final authService = getIt.get<AuthService>();
  final analyticsService = getIt.get<AnalyticsService>();
  final userService = getIt.get<UserService>();

  @override
  void initState() {
    super.initState();
    analyticsService.logScreenView("SignIn");
    authService.addListener(update);
  }

  void update() => setState(() => {});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ProtoFac",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Wrap(
              children: const [
                Text(
                  "Making Order Tracking Easier!",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/google_logo.png",
                      height: 24,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Sign in with Google',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              onPressed: () {
                authService.loginWithGoogle().then((value) {
                  authService.setLoggedInUser(value!);
                  userService.checkCreateUser(value);
                  userService.setUser(value);
                  context.go('/');
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
