import 'package:flutter/material.dart';

enum Runon { onload, onevent }
enum Runcount { onetime, repeat }

class Tlefttoright extends StatefulWidget {
  final Widget child;
  final int duration;
  final runon;
  final runcount;

  Tlefttoright(
      {@required this.child,
      @required this.duration,
      @required this.runon,
      @required this.runcount});

  @override
  Tlefttorightstate createState() => new Tlefttorightstate();
}

class Tlefttorightstate extends State<Tlefttoright>
    with SingleTickerProviderStateMixin {
  static AnimationController _controller;
  static Animation _move;
  static bool run = false, count = false;

  @override
  void initState() {
    super.initState();
    try {
      _controller = AnimationController(
          vsync: this, duration: Duration(seconds: widget.duration));
      if (Runon.onload == widget.runon) {
        setState(() {
          run = true;
        });
        _move = Tween(begin: -1.0, end: 1.0).animate(CurvedAnimation(
          parent: _controller,
          curve: Curves.ease,
        )..addStatusListener((animationstatus) {}));
        Runcount.onetime == widget.runcount
            ? _controller.forward()
            : _controller.repeat();
      } else {
        setState(() {
          run = false;
        });
        _move = Tween(begin: -1.0, end: 1.0).animate(CurvedAnimation(
          parent: _controller,
          curve: Curves.ease,
        ));
        if (Runcount.onetime == widget.runcount) {
          setState(() {
            count = true;
          });
        } else {
          setState(() {
            count = false;
          });
        }
      }
    } catch (e) {
      print("exception call");
    }
  }

  @override
  Widget build(BuildContext _context) {
    final double w = MediaQuery.of(_context).size.width;
    return AnimatedBuilder(
        animation: _controller,
        child: widget.child,
        builder: (BuildContext context, Widget child) {
          return Transform(
            transform: Matrix4.translationValues(_move.value * w, 0.0, 0.0),
            child: child,
          );
        });
  }

  static void start() {
    if (_controller != null) {
      if (run == false) {
        if (count == true) {
          _controller.forward();
        } else {
          _controller.repeat();
        }
      }
    }
  }

  static void stop() {
    if (run == false) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
