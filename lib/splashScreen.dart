import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'chat/add_message_screen.dart';
import 'main.dart';

class SplashScreen extends StatefulWidget {
  final String? currentUserId;

  SplashScreen({this.currentUserId});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends  State<SplashScreen> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var dateNow = Timestamp.fromDate(DateTime.now().toUtc());
  _SplashScreenState() : super();

  @override
  void initState() {
    super.initState();
    //   Provider.of<GoogleSignInProvider>(context, listen:  false);
    //  _init();
    print(widget.currentUserId);
    startTime();

  }

  startTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? firstTime = prefs.getBool('first_time');

    if (firstTime != null && !firstTime) {
      // Not first time
      return Timer(Duration(seconds: 20), () =>   Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => AddMessageScreen(
            currentUserId: widget.currentUserId,

          ))));
    } else {// First time
      prefs.setBool('first_time', false);
      return Timer(Duration(seconds: 3), () =>
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) =>   MyHomePage(
                title: "Uni Dating",
                currentUserId: widget.currentUserId,

              )
          ))
      );
    }
  }
Widget ui (BuildContext context)
  {


    return SafeArea(
      top: false,
      child: Scaffold(
        key: _scaffoldKey,
      //  backgroundColor: Theme.of(context).primaryColorLight,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: CircleAvatar(
               radius: 50,
                child: Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text("Online dating app for everyone",style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ui(context);
  }


  @override
  void dispose() {
    super.dispose();

  }






}
