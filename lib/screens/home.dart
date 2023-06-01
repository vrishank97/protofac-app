import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:protofac/utils/chatnav.dart';
import 'package:protofac/utils/navdrawer.dart';

class HomeScaffoldWithNavbar extends StatefulWidget {
  const HomeScaffoldWithNavbar(this.child, {super.key});
  final Widget child;
  @override
  State<HomeScaffoldWithNavbar> createState() => _HomeScaffoldWithNavbarState();
}

class _HomeScaffoldWithNavbarState extends State<HomeScaffoldWithNavbar> {
  // Get "child" since it'll be given based on route path
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ProtoFac",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      drawer: const NavDrawer(),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        currentIndex: _calculateSelectedIndex(context),
        onTap: (value) {
          // navigate to other sections (just change the pages, bottomNavigation always visible on the screen)
          switch (value) {
            case 0:
              context.go('/');
              break;
            case 1:
              context.go('/leaderboard');
              break;
            case 2:
              context.go('/profile');
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.factory),
            label: 'My Factory',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).location;

    if (location.startsWith('/leaderboard')) {
      return 1;
    }
    if (location.startsWith('/profile')) {
      return 2;
    }
    return 0;
  }
}
