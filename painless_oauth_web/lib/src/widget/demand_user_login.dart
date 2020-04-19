import 'package:flutter/material.dart';

class DemandUserLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration:
            BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
        child: Text(
          'Please log in on the newly opened window...', //todo support different languages
          style: Theme.of(context).textTheme.headline5,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
