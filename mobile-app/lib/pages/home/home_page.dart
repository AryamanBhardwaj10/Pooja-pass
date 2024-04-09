import 'package:flutter/material.dart';
import 'package:pooja_pass/components/logo.dart';
import 'package:pooja_pass/components/my_bottom_nav.dart';
import 'package:pooja_pass/components/my_drawer.dart';
import 'package:pooja_pass/pages/home/donations_page.dart';
import 'package:pooja_pass/pages/home/temple_overview_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //scaffold key
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  //
  int _selectedIndex = 0;
  //*bottom nav bar navigation
  _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //pages
  final List<Widget> _pages = [
    const TempleOverviewPage(),
    const DonationsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).colorScheme.background,
        bottomNavigationBar: MyBottomNav(
          onTabChange: (index) => _navigateBottomBar(index),
        ),
        drawer: const MyDrawer(),
        body: Stack(
          children: [
            _pages[_selectedIndex],
            SafeArea(
              child: IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 40,
                  )),
            ),
          ],
        ));
  }
}
