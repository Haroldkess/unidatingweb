import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:unidatingwebapp/chat/add_message_screen.dart';
import 'package:unidatingwebapp/responsive.dart';

import 'access/constants.dart';
import 'access/login.dart';

import 'access/signup.dart';
import 'backend/google_sign_in.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // MaterialApp(
  // title: 'Uni Dating',
  // theme: ThemeData(
  // primaryColor: kPrimaryColor,
  // visualDensity: VisualDensity.adaptivePlatformDensity,
  // textTheme: GoogleFonts.secularOneTextTheme(),
  // primarySwatch: Colors.blue,
  // ),
  //
  // home: MyHomePage(title: 'UNI'),
  //
  // );
  Widget _getScreenId() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(),);
        }
        else if (snapshot.hasError)
        {
          return Center(
            child: Text("Something went wrong!!!"),
          );
        }
        if (snapshot.hasData)
        {
          Provider.of<GoogleSignInProvider>(context, listen:  false);
          final user = FirebaseAuth.instance.currentUser!;
          print("this is your id ${user.uid}");

          return AddMessageScreen(
            currentUserId: user.uid,

          );
        }

        else {
          // Provider.of<GoogleSignInProvider>(context, listen: false);
          return MyHomePage(
            title: "Uni Dating",
            );
        }

      },
    );

  }
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      builder: (context, child){
        return MaterialApp(
          title: 'Uni Dating',
          theme: ThemeData(
            primaryColor: kPrimaryColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: GoogleFonts.secularOneTextTheme(),
            primarySwatch: Colors.blue,
          ),
          home: _getScreenId()

        );
      },

    );
  }


}

class MyHomePage extends StatefulWidget {
  final String? currentUserId;
  MyHomePage({Key? key, required this.title, this.currentUserId}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;


  bool login = true;
  Option selectedOption = Option.LogIn;


  Widget homeUi(BuildContext context)
  {
    Size size = MediaQuery.of(context).size;

    print(size.height);
    print(size.width);
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [

            Row(
              children: [
                Container(
                  height: double.infinity,
                  width: size.width / 2,
                  color: kPrimaryColor,
                ),
                Container(
                    height: double.infinity,
                    width: size.width / 2,
                    color: Colors.white
                ),
              ],
            ),

            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Text(
                  "Welcome",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      "Find Someone Now !",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      "It's easy",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),

                  ],
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Row(
                  children: [

                    Icon(
                      Icons.keyboard_arrow_left,
                      color: Colors.white,
                      size: 28,
                    ),

                    SizedBox(
                      width: 8,
                    ),

                    Text(
                      "HOME",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),

                  ],
                ),
              ),
            ),

            // Align(
            //   alignment: Alignment.topRight,
            //   child: Padding(
            //     padding: EdgeInsets.all(32),
            //     child: Icon(
            //       Icons.menu,
            //       color: Color(0xFFFE4350),
            //       size: 28,
            //     ),
            //   ),
            // ),

            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    Icon(
                      Icons.copyright,
                      color: Colors.grey,
                      size: 24,
                    ),

                    SizedBox(
                      width: 8,
                    ),

                    Text(
                      "Copyright 2020",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),

                  ],
                ),
              ),
            ),

            AnimatedSwitcher(
              duration: Duration(milliseconds: 500),

              //Animation 1
              transitionBuilder: (widget, animation) => RotationTransition(
                turns: animation,
                child: widget,
              ),
              switchOutCurve: Curves.easeInOutCubic,
              switchInCurve: Curves.fastLinearToSlowEaseIn,

              //Animation 2
              // transitionBuilder: (widget, animation) => ScaleTransition(
              //     child: widget,
              //     scale: animation
              // ),

              child: selectedOption == Option.LogIn
                  ? LogIn(
                onSignUpSelected: () {
                  setState(() {
                    selectedOption = Option.SignUp;
                  });
                },
              )
                  : SignUp(
                onLogInSelected: () {
                  setState(() {
                    selectedOption = Option.LogIn;
                  });
                },
              ),
            ),

          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {


    return homeUi(context);
  }
}



