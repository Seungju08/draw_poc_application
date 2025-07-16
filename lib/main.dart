import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: DrawPocApplication()));
}

class DrawPocApplication extends StatefulWidget {
  const DrawPocApplication({super.key});

  @override
  State<DrawPocApplication> createState() => _DrawPocApplicationState();
}

class _DrawPocApplicationState extends State<DrawPocApplication> {
  void updateScreen() => setState(() {});

  List<DrawPoint?> points = [];
  Color selectedColor = Colors.black;

  double _value = 0;

  @override
  void initState() {
    super.initState();
    updateScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                points.add(DrawPoint(details.localPosition, selectedColor));
              });
            },
            onPanEnd: (details) {
              setState(() => points.add(null));
            },
            child: CustomPaint(
              painter: DrawPainter(points: points),
              size: Size.infinite,
            ),
          ),
          Positioned(
            top: 50,
            left: 20,
            child: Row(
              children: [
                colorPicker(Colors.black),
                SizedBox(width: 10),
                colorPicker(Colors.red),
                SizedBox(width: 10),
                colorPicker(Colors.blue),
                SizedBox(width: 10),
                colorPicker(Colors.green),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          TabBar(tabs: [

          ]);
        },
        child: Icon(Icons.palette, color: Colors.grey),
      ),
    );
  }

  Widget colorPicker(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
        });
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: Border.all(
            color: Colors.grey,
            width: selectedColor == color ? 3 : 1,
          ),
        ),
      ),
    );
  }
}

class DrawPoint {
  final Offset offset;
  final Color color;

  DrawPoint(this.offset, this.color);
}

class DrawPainter extends CustomPainter {
  final List<DrawPoint?> points;

  DrawPainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < points.length - 1; i++) {
      final current = points[i];
      final next = points[i + 1];
      if (current != null && next != null) {
        final paint = Paint()
          ..color = current.color
          ..strokeWidth = 10.0
          ..strokeCap = StrokeCap.round;
        canvas.drawLine(current.offset, next.offset, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
