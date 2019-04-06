import 'package:flutter/material.dart';

class Reveal extends StatefulWidget {
  final int duration;
  final Widget child;
  final double width;
  final double height;
  final Color color;

  Reveal(
      {@required this.width,
      @required this.height,
      @required this.child,
      @required this.color,
      @required this.duration});

  @override
  Revelstate createState() => new Revelstate();
}

class Revelstate extends State<Reveal> with SingleTickerProviderStateMixin {
  static AnimationController _controller;
  static Animation<double> _move;

  @override
  void initState() {
    super.initState();
    _controller =
        new AnimationController(vsync: this, duration: Duration(seconds: 4));
    _move = Tween<double>(begin: 0.0, end: widget.width).animate(
        CurvedAnimation(
            parent: _controller,
            curve: new Interval(0.0, 0.250, curve: Curves.linear)));
  }

  static void start() {
    if (_controller != null) {
      _controller.forward();
    }
  }

  static void stop() {
    if (_controller != null) {
      _controller.stop();
    }
  }

  static void reverse() {
    if (_controller != null) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        child: widget.child,
        builder: (BuildContext context, Widget child) {
          return GestureDetector(
              child: new Container(
                  width: _move.value,
                  height: widget.height,
                  color: widget.color,
                  alignment: FractionalOffset.center,
                  child: child));
        });
  }
}
