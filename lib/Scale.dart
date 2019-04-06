import 'package:flutter/material.dart';

enum Scalemode { zoomin, zoomout }
enum Scalecount { onetime, repeat }
enum Scalerun { onload, onevent }

class Scale extends StatefulWidget {
  final double max;
  final double min;
  final Widget child;
  final int duration;
  final scalemode;
  final count;
  final run;

  Scale(
      {@required this.min,
      @required this.max,
      @required this.child,
      @required this.duration,
      @required this.scalemode,
      @required this.count,
      @required this.run});

  @override
  Scalestate createState() => new Scalestate();
}

class Scalestate extends State<Scale> with SingleTickerProviderStateMixin {
  static Animation<double> _animationzoomin, _animationzoomout;
  static AnimationController _controller;
  static bool on = false, run = false, mod = false;

  @override
  void initState() {
    super.initState();
    try {
      _controller = new AnimationController(
        vsync: this,
        duration: new Duration(seconds: widget.duration),
      );
      if (Scalerun.onload == widget.run) {
        setState(() {
          mod = true;
        });
        Scalecount.onetime == widget.count
            ? _controller.forward()
            : _controller.repeat();
        if (Scalemode.zoomin == widget.scalemode) {
          _animationzoomin = new Tween(begin: widget.min, end: widget.max)
              .animate(_controller);
          setState(() {
            on = true;
          });
        } else {
          _animationzoomout = new Tween(begin: widget.max, end: widget.min)
              .animate(_controller);
          setState(() {
            on = false;
          });
        }
      } else {
        setState(() {
          mod = false;
        });
        if (Scalecount.onetime == widget.count) {
          setState(() {
            run = true;
          });
        } else {
          setState(() {
            run = false;
          });
        }
        if (Scalemode.zoomin == widget.scalemode) {
          _animationzoomin = new Tween(begin: widget.min, end: widget.max)
              .animate(_controller);
          setState(() {
            on = true;
          });
        } else {
          _animationzoomout = new Tween(begin: widget.max, end: widget.min)
              .animate(_controller);
          setState(() {
            on = false;
          });
        }
      }
    } catch (E) {
      print("event exception call");
    }
  }

  static void start() {
    if (mod == false) {
      if (_controller != null) {
        if (run == true) {
          _controller.forward();
        } else {
          _controller.repeat();
        }
      } else {
        print("event controller null call");
      }
    } else {
      print("on event is null call");
    }
  }

  static void stop() {
    if (mod == false) {
      if (_controller != null) {
        _controller.stop();
      } else {
        print("event controller null call");
      }
    } else {
      print("onevent is null call");
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
        return new Transform.scale(
          scale: on == true ? _animationzoomin.value : _animationzoomout.value,
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
