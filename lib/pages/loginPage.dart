import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../util/authenticationService.dart';
//import '../common/design.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login to HappiDo'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(10.0, 80, 0.0, 0.0),
                    child: Text(
                      'HappiDo',
                      style: TextStyle(
                        fontSize: 80.0, fontWeight: FontWeight.bold, color: Colors.orange.shade400)
                      )
                    ),
                  Container(
                    padding: EdgeInsets.fromLTRB(320, 80, 0.0, 0.0),
                    child: Text(
                      '.',
                      style: TextStyle(
                        fontSize: 80.0, fontWeight: FontWeight.bold, color: Colors.deepOrange)
                      ),
                    )
                  ]
                  ),
                 ),
            Container(
              alignment: Alignment.centerRight,
              width: 410.0,
              height: 460.0,
              transform: Matrix4.rotationZ(0.50),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.orange.shade100,
              ),

             child: Container(
               child: Stack(
                  fit: StackFit.loose,
                  children: <Widget> [
                    ElevatedButton(
                      onPressed: () {
                        context.read<AuthenticationService>().signInWithGoogle();
                      },
                      child: Text("Sign in with Google"),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                )
                            )
                        ),
                      //style: defaultTheme.elevatedButtonTheme.style,
                    ),
               ]
             ),
               transform: Matrix4.rotationZ(-0.50),
             ),
            ),
            ]
        ),
      ),
    );
  }
}