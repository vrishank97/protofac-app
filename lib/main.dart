import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:protofac/components/Workflow_list.dart';
import 'package:protofac/router.dart';
import 'package:protofac/screens/main_screen.dart';
import 'package:protofac/screens/new_task_page.dart';
import 'package:protofac/screens/report_screen.dart';
import 'package:protofac/screens/task.dart';
import 'package:protofac/screens/workflowformwidget.dart';
import 'package:protofac/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'locator.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupLocator();
  runApp(const MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//         debugShowCheckedModeBanner: false,
//         routerConfig: gorouter,
//         theme: ThemeData(
//             primarySwatch: Colors.deepOrange,
//             textTheme: GoogleFonts.poppinsTextTheme(
//               Theme.of(context).textTheme,
//             ))

//             );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: Main_screen(),
      routes: appRoutes,
    );
  }
}

Map<String, WidgetBuilder> appRoutes = {
  "/": (context) => Main_screen(),
  "/page2": (context) => Report_screen(),
};

