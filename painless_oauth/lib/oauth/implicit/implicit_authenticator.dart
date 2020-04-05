import 'package:flutter/material.dart';
import 'package:painless_oauth_interface/authorization_client.dart';
import 'package:painless_oauth_interface/painless_oauth_interface.dart';

class ImplicitAuthenticator {
  void login(BuildContext context, AuthorizationClient authorizationClient, [Map<String, Object> platformSpecificOptions]) {
    PainlessOAuthPlatform.instance.listenForResult().then((value) {
      print('----- OAUTH DONE -----');
      print(value);
    });
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
              ),
              PainlessOAuthPlatform.instance.authorizationPage(authorizationClient: authorizationClient, platformSpecificOptions: platformSpecificOptions)
            ],
      )),
    );
  }
}
