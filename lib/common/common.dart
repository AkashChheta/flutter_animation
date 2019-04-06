import 'package:flutter/material.dart';

class Com {
  BuildContext context;
  double w;
  double h;

  Com(this.context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
  }

  width() {
    if (w != null) {
      return w;
    }
  }

  height() {
    if (h != null) {
      return h;
    }
  }
}
