import 'package:flutter/material.dart';

class DrawData {
  final Offset offset; // 펜의 이동 경로
  final Color color; // 펜의 색상
  final double penWidth; // 펜의 두께
  final StrokeCap penCap; // 펜의 종류

  DrawData(
      this.offset,
      this.color,
      this.penWidth,
      this.penCap
      );
}
