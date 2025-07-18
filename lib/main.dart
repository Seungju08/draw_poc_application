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
  bool isEraser = false;
  bool _isVisible = false;
  bool _isPallete = false;
  double _width = 2.0;
  StrokeCap _strokeCap = StrokeCap.square;

  void updateScreen() => setState(() {});

  List<DrawPoint?> points = [];
  Color selectedColor = Colors.black;

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
            onTap: () {
              setState(() {
                _isVisible = false;
              });
            },
            onPanUpdate: (details) {
              setState(() {
                points.add(
                  DrawPoint(
                    details.localPosition,
                    selectedColor,
                    _width,
                    _strokeCap,
                    // isEraser,
                  ),
                );
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
          Visibility(
            visible: _isVisible,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: 390,
                height: 530,
                decoration: BoxDecoration(
                  color: Color(0xff383839),
                  borderRadius: BorderRadiusGeometry.circular(20),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        colorPicker(Color(0xffFFFFFF)),
                        colorPicker(Color(0xffEAECE9)),
                        colorPicker(Color(0xffD4D5D1)),
                        colorPicker(Color(0xffC2C2C2)),
                        colorPicker(Color(0xffADADAC)),
                        colorPicker(Color(0xff999998)),
                        colorPicker(Color(0xff848583)),
                        colorPicker(Color(0xff707174)),
                        colorPicker(Color(0xff5C5C5C)),
                        colorPicker(Color(0xff474747)),
                        colorPicker(Color(0xff333333)),
                        colorPicker(Color(0xff000000)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        colorPicker(Color(0xff01374B)),
                        colorPicker(Color(0xff061A56)),
                        colorPicker(Color(0xff100739)),
                        colorPicker(Color(0xff2E053D)),
                        colorPicker(Color(0xff3D061B)),
                        colorPicker(Color(0xff5E0600)),
                        colorPicker(Color(0xff581C02)),
                        colorPicker(Color(0xff593200)),
                        colorPicker(Color(0xff563E02)),
                        colorPicker(Color(0xff656103)),
                        colorPicker(Color(0xff505509)),
                        colorPicker(Color(0xff263E0F)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        colorPicker(Color(0xff024D63)),
                        colorPicker(Color(0xff012F7C)),
                        colorPicker(Color(0xff1B0A4E)),
                        colorPicker(Color(0xff460B5B)),
                        colorPicker(Color(0xff550F29)),
                        colorPicker(Color(0xff811200)),
                        colorPicker(Color(0xff792700)),
                        colorPicker(Color(0xff794900)),
                        colorPicker(Color(0xff7A5802)),
                        colorPicker(Color(0xff8B8701)),
                        colorPicker(Color(0xff6E750B)),
                        colorPicker(Color(0xff38571D)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        colorPicker(Color(0xff006C8D)),
                        colorPicker(Color(0xff0442AA)),
                        colorPicker(Color(0xff2D0877)),
                        colorPicker(Color(0xff61177F)),
                        colorPicker(Color(0xff7B1C37)),
                        colorPicker(Color(0xffB61904)),
                        colorPicker(Color(0xffB03C01)),
                        colorPicker(Color(0xffA96803)),
                        colorPicker(Color(0xffA57903)),
                        colorPicker(Color(0xffC4BD02)),
                        colorPicker(Color(0xff9CA50E)),
                        colorPicker(Color(0xff507A29)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        colorPicker(Color(0xff038BB5)),
                        colorPicker(Color(0xff0456D8)),
                        colorPicker(Color(0xff381B94)),
                        colorPicker(Color(0xff7B21A0)),
                        colorPicker(Color(0xff9A2255)),
                        colorPicker(Color(0xffE42500)),
                        colorPicker(Color(0xffDB5201)),
                        colorPicker(Color(0xffD28303)),
                        colorPicker(Color(0xffD49D05)),
                        colorPicker(Color(0xffF8ED04)),
                        colorPicker(Color(0xffC2D11A)),
                        colorPicker(Color(0xff669E36)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        colorPicker(Color(0xff00A1D3)),
                        colorPicker(Color(0xff0561FF)),
                        colorPicker(Color(0xff4C22B1)),
                        colorPicker(Color(0xff962CBF)),
                        colorPicker(Color(0xffB82E5D)),
                        colorPicker(Color(0xffFE4017)),
                        colorPicker(Color(0xffFF6900)),
                        colorPicker(Color(0xffFEAB06)),
                        colorPicker(Color(0xffFCC700)),
                        colorPicker(Color(0xffFFFB43)),
                        colorPicker(Color(0xffD8EC37)),
                        colorPicker(Color(0xff78BB3F)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        colorPicker(Color(0xff05C9FF)),
                        colorPicker(Color(0xff3688FF)),
                        colorPicker(Color(0xff5E30EB)),
                        colorPicker(Color(0xffBE37F1)),
                        colorPicker(Color(0xffE7397E)),
                        colorPicker(Color(0xffFE6350)),
                        colorPicker(Color(0xffFF8649)),
                        colorPicker(Color(0xffFFB23E)),
                        colorPicker(Color(0xffFFCA3D)),
                        colorPicker(Color(0xffFEF769)),
                        colorPicker(Color(0xffE3EF67)),
                        colorPicker(Color(0xff98D25C)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        colorPicker(Color(0xff55D6FC)),
                        colorPicker(Color(0xff72A7FF)),
                        colorPicker(Color(0xff874EFB)),
                        colorPicker(Color(0xffD256FE)),
                        colorPicker(Color(0xffF0719E)),
                        colorPicker(Color(0xffFF8B83)),
                        colorPicker(Color(0xffFFA37C)),
                        colorPicker(Color(0xffFCC876)),
                        colorPicker(Color(0xffFEDA77)),
                        colorPicker(Color(0xffFEF994)),
                        colorPicker(Color(0xffECF08F)),
                        colorPicker(Color(0xffB1DE8A)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        colorPicker(Color(0xff93E3FC)),
                        colorPicker(Color(0xffA9C5FF)),
                        colorPicker(Color(0xffB18CFF)),
                        colorPicker(Color(0xffE391FE)),
                        colorPicker(Color(0xffF3A4C1)),
                        colorPicker(Color(0xffFEB5B0)),
                        colorPicker(Color(0xffFEC4A8)),
                        colorPicker(Color(0xffFDD9A9)),
                        colorPicker(Color(0xffFCE5A7)),
                        colorPicker(Color(0xffFEFCB9)),
                        colorPicker(Color(0xffF1F7B5)),
                        colorPicker(Color(0xffCFE7B3)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        colorPicker(Color(0xffCBEFFE)),
                        colorPicker(Color(0xffD2E0FE)),
                        colorPicker(Color(0xffDAC8FF)),
                        colorPicker(Color(0xffEDCBFC)),
                        colorPicker(Color(0xffFAD4E0)),
                        colorPicker(Color(0xffFFDAD8)),
                        colorPicker(Color(0xffFBE1D8)),
                        colorPicker(Color(0xffFEECD3)),
                        colorPicker(Color(0xffFEF2D6)),
                        colorPicker(Color(0xffFFFBDC)),
                        colorPicker(Color(0xffF5F9D8)),
                        colorPicker(Color(0xffDEECD4)),
                      ],
                    ),
                    SizedBox(height: 30),
                    SliderTheme(
                      data: SliderTheme.of(
                        context,
                      ).copyWith(trackHeight: _width),
                      child: Slider(
                        value: _width,
                        inactiveColor: Colors.white,
                        onChanged: (value) {
                          setState(() {
                            _width = value;
                          });
                        },
                        divisions: 1000,
                        label: _width.toStringAsFixed(1),
                        activeColor: selectedColor,
                        min: 0.1,
                        max: 40,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () =>
                              setState(() => _strokeCap = StrokeCap.square),
                          child: Container(
                            width: 90,
                            height: 50,
                            color: _strokeCap == StrokeCap.square
                                ? Colors.grey
                                : Colors.white,
                            child: Center(
                              child: Container(
                                width: 40,
                                height: 20,
                                decoration: BoxDecoration(
                                  border: BoxBorder.fromLTRB(
                                    right: BorderSide(),
                                    top: BorderSide(),
                                    bottom: BorderSide(),
                                  ),
                                ),
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: double.infinity,
                                  height: 1,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () =>
                              setState(() => _strokeCap = StrokeCap.butt),
                          child: Container(
                            width: 90,
                            height: 50,
                            color: _strokeCap == StrokeCap.butt
                                ? Colors.grey
                                : Colors.white,
                            child: Center(
                              child: Container(
                                width: 40,
                                height: 20,
                                decoration: BoxDecoration(
                                  border: BoxBorder.fromLTRB(
                                    right: BorderSide(),
                                    top: BorderSide(),
                                    bottom: BorderSide(),
                                  ),
                                ),
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: 30,
                                  height: 1,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () =>
                              setState(() => _strokeCap = StrokeCap.round),
                          child: Container(
                            width: 90,
                            height: 50,
                            color: _strokeCap == StrokeCap.round
                                ? Colors.grey
                                : Colors.white,
                            child: Center(
                              child: Container(
                                width: 40,
                                height: 20,
                                decoration: BoxDecoration(
                                  border: BoxBorder.fromLTRB(
                                    right: BorderSide(),
                                    top: BorderSide(),
                                    bottom: BorderSide(),
                                  ),
                                  borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(20),
                                  ),
                                ),
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: 30,
                                  height: 1,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 2),
            right: 25,
            bottom: 50,
            child: AnimatedSlide(
              duration: Duration(milliseconds: 300),
              offset: _isPallete ? Offset(0, 0) : Offset(0, -2),
              child: GestureDetector(
                onTap: () => setState(() => selectedColor = Colors.red),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 2),
            right: 25,
            bottom: 50,
            child: AnimatedSlide(
              duration: Duration(milliseconds: 300),
              offset: _isPallete ? Offset(0, 0) : Offset(0, -3.2),
              child: GestureDetector(
                onTap: () => setState(() => selectedColor = Colors.blue),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 2),
            right: 25,
            bottom: 50,
            child: AnimatedSlide(
              duration: Duration(milliseconds: 300),
              offset: _isPallete ? Offset(0, 0) : Offset(0, -4.4),
              child: GestureDetector(
                onTap: () => setState(() => selectedColor = Colors.green),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 2),
            right: 25,
            bottom: 50,
            child: AnimatedSlide(
              duration: Duration(milliseconds: 300),
              offset: _isPallete ? Offset(0, 0) : Offset(0, -5.6),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isPallete = true;
                    _isVisible = true;
                  });
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.red,
                        Colors.orange,
                        Colors.yellow,
                        Colors.green,
                        Colors.blue,
                        Colors.purple,
                      ],
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 2),
            right: 25,
            bottom: 50,
            child: AnimatedSlide(
              duration: Duration(milliseconds: 300),
              offset: _isPallete ? Offset(0, 0) : Offset(0, -6.8),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedColor = Colors.white;
                    // isEraser = true;
                  });
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 15,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                      ),
                      Container(
                        width: 15,
                        height: 15,
                        color: Colors.grey.shade400,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 2),
            right: 25,
            bottom: 50,
            child: AnimatedSlide(
              duration: Duration(milliseconds: 300),
              offset: _isPallete ? Offset(0, 0) : Offset(0, -8),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    points.clear();
                  });
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.redAccent),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.cleaning_services_rounded,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: AnimatedRotation(
        duration: Duration(milliseconds: 300),
        turns: _isPallete ? -1 : -1.5,
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          shape: CircleBorder(),
          onPressed: () {
            setState(() {
              // _isVisible = !_isVisible;
              _isPallete = !_isPallete;
            });
          },
          child: Icon(Icons.palette, color: Colors.grey),
        ),
      ),
    );
  }

  Widget colorPicker(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          // isEraser = false;
          selectedColor = color;
        });
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: selectedColor == Color(0xffFFFFFF)
                ? Colors.black
                : Colors.white,
            width: selectedColor == color ? 3 : 0.000001,
          ),
        ),
      ),
    );
  }
}

class DrawPoint {
  final Offset offset;
  final Color color;
  final double _width;
  final StrokeCap _strokeCap;

  // final bool isEraser;

  DrawPoint(
    this.offset,
    this.color,
    this._width,
    this._strokeCap,
    // this.isEraser,
  );
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
          ..strokeWidth = current._width
          ..strokeCap = current._strokeCap;

        // if (current.isEraser) {
        //   paint.blendMode = BlendMode.clear;
        // }

        canvas.drawLine(current.offset, next.offset, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
