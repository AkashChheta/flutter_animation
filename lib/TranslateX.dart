import 'package:flutter/material.dart';

enum Translatecount { onetime, repeat }
enum Translaterun { onload, onevent }

class TranslateX extends StatefulWidget {
  final int duration;
  final Widget child;
  final double begin;
  final double end;
  final count;
  final run;

  TranslateX({
    @required this.duration,
    @required this.child,
    @required this.begin,
    @required this.end,
    @required this.count,
    @required this.run,
  });

  @override
  Translatestatex createState() => new Translatestatex();
}

class Translatestatex extends State<TranslateX>
    with SingleTickerProviderStateMixin {
  static Animation<double> _animationmove;
  static AnimationController _controller;
  static bool on = false, run = false, mode = false;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: widget.duration),
    );
    if (Translaterun.onload == widget.run) {
      setState(() {
        run = true;
      });
      _animationmove = new Tween(begin: widget.begin, end: widget.end)
          .animate(_controller);
      Translatecount.onetime == widget.count
          ? _controller.forward()
          : _controller.repeat();
    } else {
      _animationmove = new Tween(begin: widget.begin, end: widget.end)
          .animate(_controller);
      setState(() {
        run = false;
      });
      if (Translatecount.onetime == widget.count) {
        setState(() {
          mode = true;
        });
      } else {
        setState(() {
          mode = false;
        });
      }
    }
  }

  static void start() {
    if (_controller != null) {
      if (run == false) {
        mode == true ? _controller.forward() : _controller.repeat();
      }
    } else {
      print("event is null call");
    }
  }

  static void stop() {
    if (_controller != null) {
      if (run == false) {
        _controller.stop();
      }
    } else {
      print("event is null call");
    }
  }

  @override
  Widget build(BuildContext context) {
    return new AnimatedBuilder(
      animation: _controller,
      child: new Container(
        child: widget.child,
      ),
      builder: (BuildContext context, Widget _widget) {
        return new Transform.translate(
          offset: Offset(_animationmove.value, 0.0),
          child: _widget,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
