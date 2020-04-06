import 'dart:html';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'iframe_size_wrapper.dart';

class AuthorizationPage extends StatefulWidget {
  @override
  _AuthorizationPageState createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  IFrameElement _iframeElement;

  @override
  void initState() {
    _iframeElement = IFrameElement();
    _iframeElement.src = 'https://www.youtube.com/embed/QH2-TGUlwu4';
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
