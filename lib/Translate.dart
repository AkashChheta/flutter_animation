import 'package:flutter/material.dart';

enum Translatecount { onetime, repeat }
enum Translatemode { forward, backward }

class Translate extends StatefulWidget {
  final int duration;
  final Widget child;
  final double stratpoint;
  final double endpoint;
  final count;
  final mode;

  Translate(
      {@required this.duration,
      @required this.child,
      @required this.stratpoint,
      @required this.endpoint,
      @required this.count,
      @required this.mode});

  @override
  Translatestate createState() => new Translatestate();
}

class Translatestate extends State<Translate>
    with SingleTickerProviderStateMixin {
  Animation<double> _animationmove;
  AnimationController _controller;
  bool on = false;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: widget.duration),
    );
    if (Translatemode.forward == widget.mode) {
      _animationmove = new Tween(begin: widget.stratpoint, end: widget.endpoint)
          .animate(_controller);
    } else {
      _animationmove = new Tween(begin: widget.endpoint, end: widget.stratpoint)
          .animate(_controller);
    }
    Translatecount.onetime == widget.count
        ? _controller.forward()
        : _controller.repeat();
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
          offset: Offset(_animationmove.value, _animationmove.value),
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
