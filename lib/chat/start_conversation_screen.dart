import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unidatingwebapp/chat/chat_screen.dart';
import 'package:unidatingwebapp/model/user_model.dart';

class StartConversationScreen extends StatefulWidget {
  final String? currentUserId;
  final User2? matchedUserData;
  StartConversationScreen({this.currentUserId, this.matchedUserData});
  @override
  _StartConversationScreenState createState() => _StartConversationScreenState();
}

class _StartConversationScreenState extends State<StartConversationScreen> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                    'assets/images/match_new_remove.png',
                      fit: BoxFit.fitWidth,
                    ),
                    Text("Congrats", style: Theme.of(context).primaryTextTheme.headline1),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        "Its a match!",
                        style: Theme.of(context).primaryTextTheme.subtitle2,
                      ),
                    ),
                    Text('${widget.matchedUserData!.name} and You both Liked each other', style: Theme.of(context).primaryTextTheme.subtitle2),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      overlayColor: MaterialStateProperty.all(Colors.transparent),
                      highlightColor: Colors.transparent,
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => ChatScreen(
                              currentUserId: widget.currentUserId,
                              matchedUserData: widget.matchedUserData,
                            )));
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: IconButton(
                              iconSize: 0,
                              padding: EdgeInsets.all(0),
                              icon: Icon(
                                FontAwesomeIcons.facebookMessenger,
                                color: Theme.of(context).iconTheme.color,
                              ),
                              onPressed: () {},
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Text(
                              "Start Conversation",
                              style: TextStyle(
                                color:  Theme.of(context).primaryColorLight,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 20, bottom: 20, right: 10),
                          child: ShaderMask(
                            blendMode: BlendMode.srcIn,
                            shaderCallback: (Rect bounds) {
                              return LinearGradient(
                                colors: [Colors.pink,Colors.white],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ).createShader(bounds);
                            },
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              overlayColor: MaterialStateProperty.all(Colors.transparent),
                              highlightColor: Colors.transparent,
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Keep Dating",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
