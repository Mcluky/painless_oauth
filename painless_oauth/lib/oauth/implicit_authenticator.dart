import 'package:flutter/material.dart';
import 'package:painless_oauth/src/oauth/widget/login_page.dart';
import 'package:painless_oauth_interface/authorization_client.dart';
import 'package:painless_oauth_interface/painless_oauth_interface.dart';

class ImplicitAuthenticator {
  void login(BuildContext context, AuthorizationClient authorizationClient,
      [Map<String, Object> platformSpecificOptions]) {
    PainlessOAuthPlatform.instance.listenForResult(authorizationClient).then((value) {
      print('----- OAUTH DONE -----');
      print(value);
    });
    showDialog(
        context: context,
        child: LoginPage(authorizationClient: authorizationClient,
            platformSpecificOptions: platformSpecificOptions)
    );
  }
}
