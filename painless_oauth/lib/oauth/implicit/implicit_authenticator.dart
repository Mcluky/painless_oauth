import 'package:flutter/material.dart';

class ImplicitAuthenticator {
  void login(BuildContext context) {
    showDialog(
      context: context,
      child: Center(
          child: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text('Logging in...', style: Theme.of(context).textTheme.headline5),
              )
            ],
          )
        ],
      )),
    );
  }
}
