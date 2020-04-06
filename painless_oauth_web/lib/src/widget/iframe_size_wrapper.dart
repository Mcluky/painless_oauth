import 'package:flutter/widgets.dart';

class IFrameSizeWrapper extends StatelessWidget {
  final Widget child;

  IFrameSizeWrapper({@required this.child});

  @override
  Widget build(BuildContext context) {
    bool shouldTakeFullScreen = MediaQuery.of(context).size.height < 650 || MediaQuery.of(context).size.width < 750;
    print('height: ' + MediaQuery.of(context).size.height.toString());
    print('width: ' + MediaQuery.of(context).size.width.toString());
    return shouldTakeFullScreen ?
    IFrameSizeWrapperMobile(child: child):
    IFrameSizeWrapperDesktop(child: child);
  }
}

class IFrameSizeWrapperMobile extends StatelessWidget {
  final Widget child;

  IFrameSizeWrapperMobile({@required this.child});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      heightFactor: 1 ,
      child: Align(
        alignment: Alignment.center,
          child: child
      ),
    );
  }
}

class IFrameSizeWrapperDesktop extends StatelessWidget {
  final Widget child;

  IFrameSizeWrapperDesktop({@required this.child});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.6 ,
      heightFactor: 0.7 ,
      child: Align(
        alignment: Alignment.center,
        child: AspectRatio(
          aspectRatio: 5 / 6,
          child: child
        ),
      ),
    );
  }
}
