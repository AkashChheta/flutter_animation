import 'package:flutter/material.dart';

enum RotateCount { oneTime, repeat }
enum Rotatemode { clockwise, anticlockwise }
enum Rotaterun { onload, onevent }

class Rotate extends StatefulWidget {
  final int duration;
  final Widget child;
  final count;
  final mode;
  final run;

  Rotate({
    @required this.duration,
    @required this.child,
    @required this.count,
    @required this.mode,
    @required this.run,
  });

  @override
  Rotatestate createState() => new Rotatestate();
}

class Rotatestate extends State<Rotate> with SingleTickerProviderStateMixin {
  static AnimationController _controller;
  static bool on = false, run = false, mode = false;

  @override
  void initState() {
    super.initState();
    try {
      _controller = new AnimationController(
        vsync: this,
        duration: new Duration(seconds: widget.duration),
      );
      if (Rotaterun.onload == widget.run) {
        setState(() {
          mode = true;
        });
        RotateCount.repeat == widget.count
            ? _controller.repeat()
            : _controller.forward();
        if (Rotatemode.anticlockwise == widget.mode) {
          setState(() {
            on = false;
          });
        } else {
          setState(() {
            on = true;
          });
        }
      } else {
        setState(() {
          mode = false;
        });
        if (RotateCount.repeat == widget.count) {
          setState(() {
            run = true;
          });
        } else {
          setState(() {
            run = false;
          });
        }
        if (Rotatemode.anticlockwise == widget.mode) {
          setState(() {
            on = false;
          });
        } else {
          setState(() {
            on = true;
          });
        }
      }
    } catch (E) {
      print("handle");
    }
  }

  static void start() {
    if (mode == false) {
      if (_controller != null) {
        if (run == true) {
          _controller.repeat();
        } else {
          _controller.forward();
        }
      } else {
        print("controller is null call");
      }
    } else {
      print("event null call");
    }
  }

  static void stop() {
    if (mode == false) {
      if (_controller != null) {
        _controller.stop();
      } else {
        print("controller is null call");
      }
    } else {
      print("event null call");
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
        return new Transform.rotate(
          angle:
              on == true ? _controller.value * 6.3 : -_controller.value * 6.3,
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
