import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:protofac/screens/main_screen.dart';
import 'package:protofac/locator.dart';
import 'package:protofac/services/analytics_service.dart';
import 'package:protofac/services/auth_service.dart';
import 'package:protofac/services/user_service.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  bool circular = false;

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
  Widget build (BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade200,
      body: SafeArea(
        child: Center(
          child: Column (
            children: [
              const SizedBox(height: 43,),
              Image.asset('images/logo.png'),
              Expanded(
                  child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(64),topRight: Radius.circular(64)),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            const SizedBox(height: 45,),
                            const Text(
                              'ProtoFac',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 36,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 48,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Username',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                  TextField(
                                    obscureText: false,
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      hintText: 'Placeholder',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Password',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                  TextField(
                                    obscureText: true,
                                    controller: _pwdController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      hintText: 'Placeholder',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 40,),
                            InkWell(
                              onTap: () async {
                                try {
                                  firebase_auth.UserCredential userCredential =
                                  await firebaseAuth.signInWithEmailAndPassword(
                                      email: _emailController.text, password: _pwdController.text);
                                  print(userCredential.user?.email);
                                  // setState(() {
                                  //   circular = false;
                                  // });
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (builder) => Main_screen()),
                                          (route) => false);
                                } catch (e) {
                                  final snackbar = SnackBar(content: Text(e.toString()));
                                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                                  // setState(() {
                                  //   circular = false;
                                  // });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 40),
                                margin: const EdgeInsets.symmetric(horizontal: 24),
                                decoration: BoxDecoration(
                                  color: Colors.lightBlue.shade400,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 48,),
                            InkWell(
                              onTap: () {
                                authService.loginWithGoogle().then((value) {
                                  authService.setLoggedInUser(value!);
                                  userService.checkCreateUser(value);
                                  userService.setUser(value);
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (builder) => Main_screen()),
                                          (route) => false);
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 40),
                                margin: const EdgeInsets.symmetric(horizontal: 24),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(color: Colors.blueAccent)
                                ),
                                child: const Center(
                                  child: Text(
                                    "Sign in with Google",
                                    style: TextStyle(
                                      color: Colors.lightBlue,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}