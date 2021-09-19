import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../util/authenticationService.dart';
import '../common/design.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:flutter_circular_text/circular_text.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: defaultTheme,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: defaultTheme.primaryColor,
              ),
              child:
              Text('HappiDo',
                  //textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 60.0, fontWeight: FontWeight.bold, color: Colors.white70)),
            ),
            ListTile(
              title: Text('👨‍👩‍👧‍👦 Profile',
                  style: TextStyle(
                  fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.grey.shade600)
              ),
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
              title: Text('🏆 Rewards',
                  style: TextStyle(
                      fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.grey.shade600)
              ),
              onTap: () {
                Navigator.pushNamed(context, '/rewards');
              },
            ),
            ListTile(
              title: Text('✅ Tasks',
                  style: TextStyle(
                      fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.grey.shade600)
              ),
              onTap: () {
                Navigator.pushNamed(context, '/tasks');
              },
            ),
            ListTile(
              title: Text('💪 Sign Out',
                  style: TextStyle(
                      fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.grey.shade600)
              ),
              onTap: () {
                context.read<AuthenticationService>().signOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/', (Route<dynamic> route) => false);
              },
            ),
          ],

        ),

      ),
    );
  }
}
