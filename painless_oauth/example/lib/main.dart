import 'package:flutter/material.dart';
import 'package:painless_oauth/oauth/implicit/implicit_authenticator.dart';

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
  ImplicitAuthenticator _implicitAuthenticator;

  @override
  void initState() {
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
            onPressed: () => _implicitAuthenticator.login(context),
          ),
        ),
      )
    );
  }
}
