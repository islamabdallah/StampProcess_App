import 'dart:io';

import 'package:flutter/material.dart';

class FileAvatar extends StatelessWidget {
  final double radius;
  final File image;

  const FileAvatar({
    Key? key,
    required this.radius,
    required this.image,
  })  :super(key: key);

  @override
  Widget  build(BuildContext context) {
    return Container(
      // width: ScreenUtil().setWidth(radius * 2).toDouble(),
      // height: ScreenUtil().setWidth(radius * 2).toDouble(),
      child: ClipOval(
        child: Image.file(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
