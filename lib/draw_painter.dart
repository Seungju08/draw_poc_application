import 'package:draw_poc_application/draw_data.dart';
import 'package:flutter/material.dart';

class DrawPainter extends CustomPainter {
  final List<DrawData?> drawData;

  DrawPainter({required this.drawData});

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < drawData.length - 1; i++) {
      final current = drawData[i];
      final next = drawData[i + 1];
      if (current != null && next != null) {
        final paint = Paint() // 페인트 선언과 동시에 색상, 굵기, 펜의 종류를 할당
          ..color = current.color
          ..strokeWidth = current.penWidth
          ..strokeCap = current.penCap;

        canvas.drawLine(current.offset, next.offset, paint); // 선을 그림
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
