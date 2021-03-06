import 'dart:ui' as ui;
import 'package:flutter/material.dart';


class ShadowText extends StatelessWidget {
  ShadowText(this.data, { this.style }) : assert(data != null);

  final String data;
  final TextStyle? style;

  Widget  build(BuildContext context) {
    return new ClipRect(
      child: new Stack(
        children: [
          new Positioned(
            top: 2.0,
//            left: 2.0,
            right: 2.8,

            child: new Text(
              data,
              style: style?.copyWith(color: Colors.grey.withOpacity(0.5)),
            ),
          ),
          new BackdropFilter(
            filter: new ui.ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
            child: new Text(data, style: style),
          ),
        ],
      ),
    );
  }
}
