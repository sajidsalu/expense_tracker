import 'package:flutter/material.dart';
class CustomAppbar  {
  static Widget buildAppBar(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(left: 0),
              child:Text("Expense Tracker",style: TextStyle(color: Colors.black),)),
        ],
      ),
    );
  }
}

