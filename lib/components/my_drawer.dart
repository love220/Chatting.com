import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

//  logout user
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // Drawer header
              const Padding(
                padding: EdgeInsets.only(top: 80.0, bottom: 90.0),
                child: Text(
                  "H A M D A R D",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),

              // const SizedBox(height: 20,)

              // home tile

              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Colors.grey[400],
                  ),
                  title: const Text(
                    "H O M E",
                    style: TextStyle(fontSize: 15),
                  ),
                  onTap: () {
                    // already the home screen so pop the drawer
                    Navigator.pop(context);
                  },
                ),
              ),

              // profile tile
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Colors.grey[400],
                  ),
                  title: const Text(
                    "P R O F I L E",
                    style: TextStyle(fontSize: 15),
                  ),
                  onTap: () {
                    // already the home screen so pop the drawer
                    Navigator.pop(context);

                    // navigate to profile page
                    Navigator.pushNamed(context, '/profile_page');
                  },
                ),
              ),

              // users tile
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: ListTile(
                  leading: Icon(
                    Icons.group,
                    color: Colors.grey[400],
                  ),
                  title: const Text(
                    "U S E R S",
                    style: TextStyle(fontSize: 15),
                  ),
                  onTap: () {
                    // already the home screen so pop the drawer
                    Navigator.pop(context);

                    // navigate to profile page
                    Navigator.pushNamed(context, '/users_page');
                  },
                ),
              ),
            ],
          ),

          // Log out

          Padding(
            padding: const EdgeInsets.only(left: 30.0, bottom: 50.0),
            child: ListTile(
              leading: Icon(
                Icons.group,
                color: Colors.grey[400],
              ),
              title: const Text(
                "L O G O U T",
                style: TextStyle(fontSize: 15),
              ),
              onTap: () {
                // already the home screen so pop the drawer
                Navigator.pop(context);

                // logout
                logout();
              },
            ),
          ),
        ],
      ),
    );
  }
}
