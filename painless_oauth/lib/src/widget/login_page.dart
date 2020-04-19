import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:painless_oauth_interface/authorization_client.dart';
import 'package:painless_oauth_interface/painless_oauth_interface.dart';

class LoginPage extends StatelessWidget {
  final AuthorizationClient authorizationClient;
  final Map<String, Object> platformSpecificOptions;

  LoginPage({@required this.authorizationClient, this.platformSpecificOptions = const {}});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text('Logging in...', //todo support different languages
                  style: Theme.of(context).textTheme.headline5),
            )
          ],
        ),
        PainlessOAuthPlatform.instance.authorizationPage(
            authorizationClient: authorizationClient, platformSpecificOptions: platformSpecificOptions)
      ],
    ));
  }
}
