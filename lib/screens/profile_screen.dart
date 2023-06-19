import 'package:flutter/cupertino.dart';

class Porfile_screen extends StatefulWidget {
  const Porfile_screen({super.key});

  @override
  State<Porfile_screen> createState() => _Porfile_screenState();
}

class _Porfile_screenState extends State<Porfile_screen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Text('Profile '),
      ),
    );
  }
}