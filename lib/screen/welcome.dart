import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form/screen/home.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Column(children: [
            Text(
              "อีเมลของคุณคือ : " + auth.currentUser!.email.toString(),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePgae()));
              },
              child: Text("ออกจากระบบ"),
            )
          ]),
        ),
      ),
    );
  }
}
