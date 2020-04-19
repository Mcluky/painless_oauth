import 'dart:html';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:painless_oauth_interface/authorization_client.dart';

import 'iframe_size_wrapper.dart';

class IframeAuthorizationPage extends StatefulWidget {
  final AuthorizationClient authorizationClient;

  IframeAuthorizationPage({@required this.authorizationClient});

  @override
  _IframeAuthorizationPageState createState() => _IframeAuthorizationPageState();
}

class _IframeAuthorizationPageState extends State<IframeAuthorizationPage> {
  IFrameElement _iframeElement;

  @override
  void initState() {
    _iframeElement = IFrameElement();
    _iframeElement.src = widget.authorizationClient.authorizationUri.toString();
    _iframeElement.style.border = 'none';

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'iframeElement',
      (int viewId) => _iframeElement,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IFrameSizeWrapper(
      child: HtmlElementView(viewType: 'iframeElement'),
    );
  }
}
