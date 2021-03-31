import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _email = TextEditingController(),
      _pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(),
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snap) {
            if (snap.hasData) {
              return Container(
                color: Colors.green,
              );
            }
            return Center(
              child: Container(
                child: Column(
                  children: [
                    TextField(
                      controller: _email,
                      decoration: InputDecoration(hintText: "Email"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _pass,
                      decoration: InputDecoration(
                        hintText: "Password",
                        icon: const Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: const Icon(Icons.lock),
                        ),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        String email = _email.text.trim();
                        String pass = _pass.text.trim();
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: email,
                          password: pass,
                        );
                      },
                      child: Text("Sign Up"),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
