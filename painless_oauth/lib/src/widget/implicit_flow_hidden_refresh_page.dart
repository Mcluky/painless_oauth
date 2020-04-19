import 'package:flutter/material.dart';
import 'package:painless_oauth_interface/authorization_client.dart';
import 'package:painless_oauth_interface/painless_oauth_interface.dart';

class ImplicitFlowHiddenRefreshPage extends StatelessWidget {
  final AuthorizationClient authorizationClient;
  final Map<String, Object> platformSpecificOptions;

  ImplicitFlowHiddenRefreshPage({@required this.authorizationClient, this.platformSpecificOptions = const {}});

  @override
  Widget build(BuildContext context) {
    return PainlessOAuthPlatform.instance.authorizationPage(
        authorizationClient: authorizationClient, platformSpecificOptions: platformSpecificOptions);
  }
}
