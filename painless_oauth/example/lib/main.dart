import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:painless_oauth/clients/spotify_oauth_client.dart';
import 'package:painless_oauth/oauth/implicit_authenticator.dart';
import 'package:painless_oauth/oauth/responses/implicit_flow_response.dart';

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
  String _response;

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: 500,
                    child: Text(_response ?? '')),
                RaisedButton(
                  child: Text('Sample Spotify Login IFrame(not working)'),
                  color: Colors.green,
                  onPressed: () {
                    var futureResponse = _implicitAuthenticator
                        .login(context, _spotifyImplicitFlowOAuthClient, {'web.useComponent': 'iframe'});
                    printResult(futureResponse);
                  },
                ),
                RaisedButton(
                  child: Text('Sample Spotify Login PopUp'),
                  color: Colors.green,
                  onPressed: () {
                    var futureResponse = _implicitAuthenticator
                        .login(context, _spotifyImplicitFlowOAuthClient, {'web.useComponent': 'popUp'});
                    printResult(futureResponse);
                  },
                ),
                RaisedButton(
                  child: Text('Sample Spotify Login new Tab'),
                  color: Colors.green,
                  onPressed: () {
                    var futureResponse = _implicitAuthenticator
                        .login(context, _spotifyImplicitFlowOAuthClient, {'web.useComponent': 'tab'});
                    printResult(futureResponse);
                  },
                ),
              ],
            ),
          ),
        ));
  }

  void printResult(Future<ImplicitFlowResponse> futureResponse) {
    futureResponse.then((response) {
      print('------------- SUCCESS -------------');
      print('access token: ${response.accessToken}');
      setState(() {
        _response = mapToPrettyFormattedString(response.allResponseParameters);
      });
    }).catchError((error) {
      print('------------- SUCCESSN\'T -------------');
      print('error: ${error.error}');
      print('error description: ${error.errorDescription}');
      setState(() {
        Map errorResponseMap = {'error': error.error, 'errorDescription': error.errorDescription};
        _response = mapToPrettyFormattedString(errorResponseMap);
      });
    });
  }

  String mapToPrettyFormattedString(Map response){
    JsonEncoder encoder = JsonEncoder.withIndent('   ');
    String prettyFormattedString = encoder.convert(response);
    return prettyFormattedString;
  }
}
