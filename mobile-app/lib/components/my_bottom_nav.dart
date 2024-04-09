import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyBottomNav extends StatelessWidget {
  final void Function(int)? onTabChange;
  const MyBottomNav({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 26),
      child: GNav(
          color: Colors.grey[400],
          activeColor: Colors.grey.shade900,
          tabActiveBorder: Border.all(color: Colors.white),
          tabBackgroundColor: Theme.of(context).colorScheme.secondary,
          mainAxisAlignment: MainAxisAlignment.center,
          tabBorderRadius: 16,
          onTabChange: onTabChange,
          tabs: [
            GButton(
              icon: Icons.home,
              iconSize: 28,
              text: "Home",
            ),
            GButton(
              icon: Icons.how_to_vote,
              text: "Donate",
            )
          ]),
    );
  }
}
