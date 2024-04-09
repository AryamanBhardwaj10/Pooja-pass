import 'package:flutter/material.dart';
import 'package:pooja_pass/services/auth_services.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  void logout(BuildContext context) {
    AuthService().logout(context);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      child: Column(
        children: [
          //*logo
          SizedBox(
            height: 300,
            child: DrawerHeader(
                child: Image.asset(
              'assets/images/logo_bg_removed.png',
              fit: BoxFit.cover,
            )),
          ),

          //*other pages
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: ListTile(
              onTap: () => Navigator.pop(context),
              leading: const Icon(
                Icons.home,
                size: 29,
              ),
              title: Text(
                "Home",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: ListTile(
              leading: Icon(
                Icons.person,
                size: 29,
              ),
              title: Text(
                "Profile",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: ListTile(
              leading: Icon(
                Icons.settings,
                size: 29,
              ),
              title: Text(
                "Settings",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: ListTile(
              leading: Icon(
                Icons.info,
                size: 29,
              ),
              title: Text(
                "About",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 35),
            child: ListTile(
              onTap: () {
                logout(context);
              },
              leading: Icon(
                Icons.logout,
                size: 29,
              ),
              title: Text(
                "Logout",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
