import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavigation extends StatelessWidget {
  void Function(int)? onTabChange;

  BottomNavigation({
    super.key,
    required this.onTabChange
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: GNav(
          color: Colors.grey,
          activeColor: Colors.blue,
          tabActiveBorder: Border.all(color: Colors.white),
          tabBackgroundColor: Colors.grey.shade100,
          gap: 8,
          mainAxisAlignment: MainAxisAlignment.center,
          tabBorderRadius: 16,
          onTabChange: (value) => onTabChange!(value),
          tabs: [
            GButton(
              icon: Icons.home,
              text: "Home",
            ),
            GButton(
              icon: Icons.shopping_bag_rounded,
              text: "Quiz",
            ),
            GButton(
              icon: Icons.list,
              text: "Profile",
            ),
          ]),
    );
  }
}
