import 'package:flutter/material.dart';

class Fadinout extends StatefulWidget {
  final bool visiblity;
  final int duration;
  final Widget child;
  final double transparency;

  Fadinout(
      {@required this.visiblity,
      @required this.duration,
      @required this.child,
      @required this.transparency});

  @override
  Fadinoutstate createState() => new Fadinoutstate();
}

class Fadinoutstate extends State<Fadinout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          AnimatedOpacity(
            opacity: widget.visiblity == true ? 1.0 : 0.0,
            duration: Duration(milliseconds: widget.duration),
            child: widget.child,
          )
        ],
      ),
    );
  }
}
