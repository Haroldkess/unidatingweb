import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


import 'constants.dart';

Widget actionButton(String text, IconData iconData){
  return Container(
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
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 7.0),
            child: Icon(iconData,color: Colors.grey,),
          )
        ],
      ),
    ),
  );
}