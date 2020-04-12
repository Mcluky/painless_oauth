import 'package:flutter/material.dart';
import 'package:painless_oauth/clients/spotify_oauth_client.dart';
import 'package:painless_oauth/oauth/implicit_authenticator.dart';

import 'oauth_properties.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Painless OAuth Demo',
      home: MyHomePage(title: 'Painless OAuth Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SpotifyImplicitFlowOAuthClient _spotifyImplicitFlowOAuthClient;
  ImplicitAuthenticator _implicitAuthenticator;

  @override
  void initState() {
    _spotifyImplicitFlowOAuthClient =
        SpotifyImplicitFlowOAuthClient(redirectUri: OAuthProperties.redirectUri, clientId: OAuthProperties.clientId);
    _implicitAuthenticator = ImplicitAuthenticator();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Material(
          child: Center(
            child: RaisedButton(
              child: Text('Login'),
              color: Colors.green,
              onPressed: () {
                _implicitAuthenticator.login(context, _spotifyImplicitFlowOAuthClient).then((response) {
                  print('------------- SUCCESS -------------');
                  print('access token: ${response.accessToken}');
                }).catchError((error) {
                  print('------------- SUCCESSN\'T -------------');
                  print('error: ${error.error}');
                  print('error description: ${error.errorDescription}');
                });
              },
            ),
          ),
        ));
  }
}
