import 'package:flutter/material.dart';
import 'package:flutter_animation/common/common.dart';

enum Motioncount { onetime, repeat }
enum Motionrun { onload, onevent }

class Motiontoptobottom extends StatefulWidget {
  final Widget child;
  final int duration;
  final Curve curve;
  final count;
  final run;

  Motiontoptobottom(
      {@required this.child,
      @required this.duration,
      @required this.curve,
      @required this.count,
      @required this.run});

  @override
  Motiontoptobottomstate createState() => new Motiontoptobottomstate();
}

class Motiontoptobottomstate extends State<Motiontoptobottom>
    with SingleTickerProviderStateMixin {
  static AnimationController _controller;
  static Animation _move;
  static bool run = false;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: Duration(seconds: widget.duration));
    try {
      if (_controller != null) {
        if (Motionrun.onload == widget.run) {
          setState(() {
            run = true;
          });
          onconfig();
        } else {
          setState(() {
            run = false;
          });
          _move = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
            parent: _controller,
            curve: widget.curve,
          ))
            ..addStatusListener(Statusonload);
        }
      }
    } catch (e) {
      print("eception ocurres");
    }
    super.initState();
  }

  void start() {
    if (_controller != null) {
      if (run == false) {
        _controller.forward();
      } else {
        print("_onload event call");
      }
    }
  }

  void stop() {
    if (_controller != null) {
      if (run == false) {
        _controller.stop();
      }
    }
  }

  @override
  Widget build(BuildContext _context) {
    return AnimatedBuilder(
        animation: _controller,
        child: widget.child,
        builder: (BuildContext context, Widget child) {
          return Transform(
            transform: Matrix4.translationValues(
                0.0, _move.value * new Com(context).h, 0.0),
            child: child,
          );
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void Statusonload(s) {
    if (s == AnimationStatus.completed) {
      _move.removeStatusListener(Statusonload);
      _controller.reset();
      _move = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      ))
        ..addStatusListener((s) => Statusondone(s));
      _controller.forward();
    }
  }

  void Statusondone(s) {
    if (s == AnimationStatus.completed) {
      _move.removeStatusListener(Statusondone);
      _controller.reset();
      if (Motioncount.repeat == widget.count) {
        onconfig();
      } else {
        _move = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
          parent: _controller,
          curve: widget.curve,
        ))
          ..addStatusListener(Statusonload);
      }
    }
  }

  void onconfig() {
    _move = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ))
      ..addStatusListener(Statusonload);
    _controller.forward();
  }
}
