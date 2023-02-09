// import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smart_parents/pages/option.dart';
// import 'dart:html' as html;
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  String? email = FirebaseAuth.instance.currentUser!.email;
  // final creationTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;
  // final storage = new FlutterSecureStorage();
  User? user = FirebaseAuth.instance.currentUser;
  // String ve = "Verify Email";
  final _prefs = SharedPreferences.getInstance();

  // verifyEmail() async {
  //   if (user != null && !user!.emailVerified) {
  //     await user!.sendEmailVerification();
  //     print('Verification Email has been sent');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         backgroundColor: Colors.lightBlueAccent,
  //         content: Text(
  //           'Verification Email has been sent',
  //           style: TextStyle(fontSize: 18.0, color: Colors.black),
  //         ),
  //       ),
  //     );
  //   }
  // }

  delete() async {
    final SharedPreferences prefs = await _prefs;
    final success = await prefs.clear();
    print(success);
  }

  login() async {
    FirebaseAuth.instance.signOut();
    final SharedPreferences prefs = await _prefs;
    email = prefs.getString('email');
    String? pass = prefs.getString('pass');
    print("signout");
    try {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: "$email", password: "$pass")
          .then(
            (value) => print("login $email"),
          );
      print("login");
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    login();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
  //     child: Column(
  //       children: [
  //         Row(
  //           children: [
  //             Text(
  //               'User ID: $uid',
  //               style: TextStyle(fontSize: 18.0),
  //             ),
  //           ],
  //         ),
  //         Row(
  //           children: [
  //             Text(
  //               'Email: $email',
  //               style: TextStyle(fontSize: 18.0),
  //             ),
  //             // refresh(),
  //             user!.emailVerified
  //                 ? Text(
  //                     // '$ve',
  //                     'Verified',
  //                     style: TextStyle(fontSize: 18.0, color: Colors.blueGrey),
  //                   )
  //                 : TextButton(
  //                     onPressed: () => {verifyEmail()},
  //                     // child: Text('$ve')),
  //                     child: Text('Verify Email')),
  //           ],
  //         ),
  //         Row(
  //           children: [
  //             Text(
  //               'Created: $creationTime',
  //               style: TextStyle(fontSize: 18.0),
  //             ),
  //           ],
  //         ),
  //         Row(
  //           children: [
  //             ElevatedButton(
  //               onPressed: () async => {
  //                 await FirebaseAuth.instance.signOut(),
  //                 delete(),
  //                 // await storage.delete(key: "uid"),
  //                 Navigator.pushAndRemoveUntil(
  //                     context,
  //                     MaterialPageRoute(
  //                       builder: (context) => const Option(),
  //                     ),
  //                     (route) => false)
  //               },
  //               child: Text('Logout'),
  //               style:
  //                   ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
  //             ),
  //           ],
  //         )
  //       ],
  //     ),
  //     // ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    
    return Center(
      child: Container(
        height: 590.0,
        width: 414.0,
        color: Colors.blue[50],
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/images/man.png'),
            ),
            Text(
              'Admin',
              style: TextStyle(
                fontSize: 30,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            Container(
              height: 470.0,
              width: 365.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Color.fromARGB(255, 37, 86, 116),
              ),
              // alignment: Alignment(0.0, -0.9),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "User ID: $uid",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        Text(
                          // alignment: Alignment(0.0, -0.8),
                          "Email: $email",
                          // ignore: prefer_const_constructors
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Align(
                  //   alignment: Alignment(0, 0),
                  // child:
                  Container(
                    alignment: Alignment(0, 0),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
                          onPressed: () async => {
                            await FirebaseAuth.instance.signOut(),
                            delete(),
                            // await storage.delete(key: "uid"),
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Option(),
                                ),
                                (route) => false)
                          },
                          tooltip: 'logout',
                        ),
                        Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
