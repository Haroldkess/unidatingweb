import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:unidatingwebapp/backend/google_sign_in.dart';
import 'package:unidatingwebapp/model/test_model.dart';
import 'package:unidatingwebapp/model/user_model.dart';


import 'action_button.dart';
import 'constants.dart';
enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}
class SignUp extends StatefulWidget {

  final Function onLogInSelected;

  SignUp({required this.onLogInSelected});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  TextEditingController _cContactNo = new TextEditingController();
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  final otpController2 = TextEditingController();
  final otpController3 = TextEditingController();
  final otpController4 = TextEditingController();
  final otpController5 = TextEditingController();
  final otpController6 = TextEditingController();
  String? verId;
  String? phone;
  bool? codeSent = false;
  User? user;

  FocusNode _fNum2 = FocusNode();
  FocusNode _fNum3 = FocusNode();
  FocusNode _fNum4 = FocusNode();
  FocusNode _fNum5 = FocusNode();
  FocusNode _fNum6 = FocusNode();
  FocusNode _fNum7 = FocusNode();

  var _scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseAuth _auth = FirebaseAuth.instance;

  String? verificationId;

  String? code;

  bool? showLoading = false;

  Future<void> verifyPhone() async {
    setState(() {
      phone = phoneController.text;
      showLoading = true;
    });
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneController.text.toString(),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          final snackBar = SnackBar(content: Text("Login Success"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        verificationFailed: (FirebaseAuthException e) {
          final snackBar = SnackBar(content: Text("${e.message}"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          setState(() {
            showLoading = false;
            currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
          });
        },

        codeSent: (String? verficationId, int? resendToken) {
          setState(() {
            codeSent = true;
            verId = verficationId;
            showLoading = false;
          });
        },

        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            verId = verificationId;
            showLoading = false;

          });
        },

        timeout: Duration(seconds: 20),forceResendingToken: 1  );
  }


  Future<void> verifyPin(String pin) async {
    PhoneAuthCredential credential =
    PhoneAuthProvider.credential(verificationId: verId!, smsCode: pin);

    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      final snackBar = SnackBar(content: Text("Login Success"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } on FirebaseAuthException catch (e) {
      final snackBar = SnackBar(content: Text("${e.message}"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }


  Widget phoneUi(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(size.height > 770 ? 64 : size.height > 670 ? 32 : 16),
      child: Center(
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: size.height * (size.height > 770 ? 0.7 : size.height > 670 ? 0.8 : 0.9),
            width: 500,
            color: Colors.white,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[700],
                        ),
                      ),

                      SizedBox(
                        height: 8,
                      ),

                      Container(
                        width: 30,
                        child: Divider(
                          color: kPrimaryColor,
                          thickness: 2,
                        ),
                      ),

                      SizedBox(
                        height: 32,
                      ),

                      // TextField(
                      //   decoration: InputDecoration(
                      //     hintText: 'Name',
                      //     labelText: 'Name',
                      //     suffixIcon: Icon(
                      //       Icons.person_outline,
                      //     ),
                      //   ),
                      // ),

                      SizedBox(
                        height: 32,
                      ),

                      // TextField(
                      //   decoration: InputDecoration(
                      //     hintText: 'Email',
                      //     labelText: 'Email',
                      //     suffixIcon: Icon(
                      //       Icons.mail_outline,
                      //     ),
                      //   ),
                      // ),

                      SizedBox(
                        height: 32,
                      ),

                      // TextField(
                      //   decoration: InputDecoration(
                      //     hintText: 'Phone',
                      //     labelText: 'Phone',
                      //     suffixIcon: Icon(
                      //       Icons.phone_android,
                      //     ),
                      //   ),
                      // ),
                      Container(
                        decoration: BoxDecoration(
                          color:  Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(35),
                        ),
                        height: 55,
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(20),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                        Icons.phone
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Phone',
                                      style: Theme.of(context).primaryTextTheme.subtitle2,
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.all(4.0),
                                  //   child: Icon(
                                  //     Icons.expand_more,
                                  //     color: Theme.of(context).iconTheme.color,
                                  //   ),
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: VerticalDivider(
                                      thickness: 2,
                                      color: Theme.of(context).iconTheme.color,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 64,
                      ),


                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            showLoading = true;
                          });


                          //   signInWithPhoneAuthCredential(phoneAuthCredential);
                          // setState(() {
                          //   user = FirebaseAuth.instance.currentUser as User?;
                          // });
                          //
                          // await _auth.verifyPhoneNumber(
                          //   phoneNumber: phoneController.text,
                          //   verificationCompleted: (phoneAuthCredential) async {
                          //     setState(() {
                          //       showLoading = false;
                          //     });
                          //     //signInWithPhoneAuthCredential(phoneAuthCredential);
                          //   },
                          //   verificationFailed: (verificationFailed) async {
                          //     ScaffoldMessenger.of(
                          //         context)
                          //         .showSnackBar(
                          //         SnackBar(
                          //           duration: Duration(
                          //               seconds: 3),
                          //           content: Text(
                          //               verificationFailed.message!),
                          //           backgroundColor: Theme
                          //               .of(context)
                          //               .primaryColorLight,
                          //         ));
                          //
                          //     setState(() {
                          //       showLoading = false;
                          //     });
                          //     print(verificationFailed.message!);
                          //     // _scaffoldKey.currentState!.showSnackBar(
                          //     //     SnackBar(content: Text(verificationFailed.message!)));
                          //   },
                          //   codeSent: (verificationId, resendingToken) async {
                          //     setState(() {
                          //       showLoading = false;
                          //       currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
                          //       this.verificationId = verificationId;
                          //     });
                          //   },
                          //   codeAutoRetrievalTimeout: (verificationId) async {},
                          // );
                          // PhoneAuthCredential phoneAuthCredential =
                          // PhoneAuthProvider.credential(
                          //     verificationId: verificationId!, smsCode: code!);
                          var provider =  Provider.of<GoogleSignInProvider>(context, listen:  false );
                          await  provider.signInWithPhoneAuthCredential(phoneController.text);
                          setState(() {
                            showLoading = false;
                          });

                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: kPrimaryColor.withOpacity(0.2),
                                spreadRadius: 4,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Login in with',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(left: 7.0),
                                  child: Icon(FontAwesomeIcons.phone,color: Colors.grey,),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 32,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Try other options ?",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),

                          SizedBox(
                            width: 8,
                          ),

                          GestureDetector(
                            onTap: () {
                              widget.onLogInSelected();
                            },
                            child: Row(
                              children: [

                                Text(
                                  "Google",
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                SizedBox(
                                  width: 8,
                                ),

                                Icon(
                                  Icons.arrow_forward,
                                  color: kPrimaryColor,
                                ),

                              ],
                            ),
                          ),

                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

  }

  getOtpFromWidget(context){
    return Center(
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Verify",
                style: Theme.of(context).primaryTextTheme.headline1,
              ),
            ),
            Text(
              "Please enter the 6-digit code",
              style: Theme.of(context).primaryTextTheme.subtitle2,
            ),
            Text(
              "sent to your number",
              style: Theme.of(context).primaryTextTheme.subtitle2,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                  padding: EdgeInsets.all(1.2),
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(35),
                    ),
                    height: 30,
                    width: 30,
                    child: TextFormField(
                      controller: otpController,
                      inputFormatters: [LengthLimitingTextInputFormatter(1)],
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(contentPadding: EdgeInsets.all(5)),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      style: Theme.of(context).primaryTextTheme.subtitle2,
                      onChanged: (v) {
                        FocusScope.of(context).requestFocus(_fNum2);

                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                  padding: EdgeInsets.all(1.2),
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(35),
                    ),
                    height: 30,
                    width: 30,
                    child: TextFormField(
                      controller: otpController2,
                      focusNode: _fNum2,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [LengthLimitingTextInputFormatter(1)],
                      decoration: InputDecoration(contentPadding: EdgeInsets.all(5)),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      style: Theme.of(context).primaryTextTheme.subtitle2,
                      onChanged: (v) {
                        FocusScope.of(context).requestFocus(_fNum3);
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                  padding: EdgeInsets.all(1.2),
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color:  Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(35),
                    ),
                    height: 30,
                    width: 30,
                    child: TextFormField(
                      controller: otpController3,
                      focusNode: _fNum3,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [LengthLimitingTextInputFormatter(1)],
                      decoration: InputDecoration(contentPadding: EdgeInsets.all(5)),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      style: Theme.of(context).primaryTextTheme.subtitle2,
                      onChanged: (v) {
                        FocusScope.of(context).requestFocus(_fNum4);
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                  padding: EdgeInsets.all(1.2),
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color:  Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(35),
                    ),
                    height: 30,
                    width: 30,
                    child: TextFormField(
                      controller: otpController4,
                      focusNode: _fNum4,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [LengthLimitingTextInputFormatter(1)],
                      decoration: InputDecoration(contentPadding: EdgeInsets.all(5)),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      style: Theme.of(context).primaryTextTheme.subtitle2,
                      onChanged: (v) {
                        FocusScope.of(context).requestFocus(_fNum5);
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                  padding: EdgeInsets.all(1.2),
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(35),
                    ),
                    height: 30,
                    width: 30,
                    child: TextFormField(
                      controller: otpController5,
                      focusNode: _fNum5,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [LengthLimitingTextInputFormatter(1)],
                      decoration: InputDecoration(contentPadding: EdgeInsets.all(5)),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      style: Theme.of(context).primaryTextTheme.subtitle2,
                      onChanged: (v) {
                        FocusScope.of(context).requestFocus(_fNum6);
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                  padding: EdgeInsets.all(1.2),
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(35),
                    ),
                    height: 55,
                    width: 55,
                    child: TextFormField(
                      controller: otpController6,
                      focusNode: _fNum6,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [LengthLimitingTextInputFormatter(1)],
                      decoration: InputDecoration(contentPadding: EdgeInsets.all(5)),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      style: Theme.of(context).primaryTextTheme.subtitle2,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),

              ),
              child: TextButton(
                onPressed: () async {
                  setState(() {
                    code = '${otpController.text+otpController2.text+otpController3.text+otpController4.text+otpController5.text+otpController6.text}';
                  });
                  print(code);
                  PhoneAuthCredential phoneAuthCredential =
                  PhoneAuthProvider.credential(
                      verificationId: verificationId!, smsCode: code!);

                  var provider =  Provider.of<GoogleSignInProvider>(context, listen:  false );
                 // await  provider.signInWithPhoneAuthCredential(phoneAuthCredential);

                  //   signInWithPhoneAuthCredential(phoneAuthCredential);
                  setState(() {
                    user = FirebaseAuth.instance.currentUser as User?;
                  });

                },
                child: Text(
                  "Submit",
                  style: Theme.of(context).textButtonTheme.style!.textStyle!.resolve({
                    MaterialState.pressed,
                  }),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

   // Size size = MediaQuery.of(context).size;
    
    return  Container(
      child: showLoading!
          ? Center(
        child: CircularProgressIndicator(),
      )
          :phoneUi(context),

      padding: const EdgeInsets.all(16),
    );
  }
}