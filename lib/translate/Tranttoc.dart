import 'package:flutter/material.dart';

enum Runon { onload, onevent }
enum Runcount { onetime, repeat }

class Ttoptocenter extends StatefulWidget {
  final Widget child;
  final int duration;
  final runon;
  final runcount;

  Ttoptocenter(
      {@required this.child,
      @required this.duration,
      @required this.runon,
      @required this.runcount});

  @override
  Ttoptocenterstate createState() => new Ttoptocenterstate();
}

class Ttoptocenterstate extends State<Ttoptocenter>
    with SingleTickerProviderStateMixin {
  static AnimationController _controller;
  static Animation _movetoptocenter;
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
        _movetoptocenter = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
          parent: _controller,
          curve: Curves.ease,
        ));
        Runcount.onetime == widget.runcount
            ? _controller.forward()
            : _controller.repeat();
      } else {
        setState(() {
          run = false;
        });
        _movetoptocenter = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
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
    final double h = MediaQuery.of(_context).size.height;
    return AnimatedBuilder(
        animation: _controller,
        child: widget.child,
        builder: (BuildContext context, Widget child) {
          return Transform(
            transform:
                Matrix4.translationValues(0.0, _movetoptocenter.value * h, 0.0),
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
