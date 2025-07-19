import 'dart:io';
import 'dart:ui' as ui;

import 'package:draw_poc_application/custom_color_button.dart';
import 'package:draw_poc_application/draw_data.dart';
import 'package:draw_poc_application/draw_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DrawPocApplication extends StatefulWidget {
  const DrawPocApplication({super.key});

  @override
  State<DrawPocApplication> createState() => _DrawPocApplicationState();
}

class _DrawPocApplicationState extends State<DrawPocApplication> {
  TransformationController controller = TransformationController();
  GlobalKey key = GlobalKey();

  // UI
  bool isShowMenu = false; // 메뉴 가시 여부
  bool isShowPalette = false; // 팔레트 가시 여부
  bool isPenMode = true; // 그리기 모드
  bool isShowImage = false;

  // Setting And Data
  Color penColor = Colors.black; // 펜 색깔
  double penWidth = 5.0; // 펜의 두께
  StrokeCap penCap = StrokeCap.round; // 펜 촉의 종류
  List<DrawData?> points = []; // 펜의 데이터

  String? imagePath; // 이미지의 경로

  Future<void> saveToImage() async {
    final boundary =
        key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage();
    final bytes = (await image.toByteData(
      format: ui.ImageByteFormat.png,
    ))!.buffer.asUint8List();
    final tempDir = Directory.systemTemp; // 임시 디렉토리
    final file = File(
      '${tempDir.path}/drawing_${DateTime.now().millisecondsSinceEpoch}.png',
    );
    await file.writeAsBytes(bytes);

    setState(() {
      imagePath = file.path;
      isShowImage = true;
    });

    print('저장됨: ${file.path}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          InteractiveViewer(
            transformationController: controller,
            minScale: 1,
            maxScale: 5,
            panEnabled: !isPenMode,
            // 펜 모드에서는 이동 비활성화
            scaleEnabled: !isPenMode,
            child: RepaintBoundary(
              key: key,
              child: CustomPaint(
                painter: DrawPainter(drawData: points),
                size: Size.infinite,
              ),
            ),
          ),
          if (isPenMode)
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onPanUpdate: (details) {
                final matrix = controller.value;
                final inverseMatrix = Matrix4.inverted(matrix);
                final transformedOffset = MatrixUtils.transformPoint(
                  inverseMatrix,
                  details.localPosition,
                );
                setState(
                  () => points.add(
                    DrawData(transformedOffset, penColor, penWidth, penCap),
                  ),
                );
              }, // 팬을 움직일 때 위치, 색, 두께, 팬으 종류를 넘겨줌
              onPanEnd: (details) =>
                  setState(() => points.add(null)), // 펜의 움직임이 끝났을 때 (손을 놓음)
            ),
          Center(
            child: Visibility(
              visible: isShowImage,
              child: GestureDetector(
                onTap: () {
                  setState(() => isShowImage = false);
                },
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(color: Colors.white),
                  child: imagePath != null
                      ? Image.file(File(imagePath!), fit: BoxFit.contain)
                      : Icon(Icons.arrow_back),
                ),
              ),
            ),
          ),
          Center(
            child: Visibility(
              visible: isShowPalette,
              child: Container(
                width: 350,
                height: 450,
                decoration: BoxDecoration(
                  color: Color(0xff383839),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            CustomColorButton(
                              color: Color(0xffFDFEFE),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffFDFEFE)),
                              isSelected: penColor == Color(0xffFDFEFE),
                            ),
                            CustomColorButton(
                              color: Color(0xff01374B),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff01374B)),
                              isSelected: penColor == Color(0xff01374B),
                            ),
                            CustomColorButton(
                              color: Color(0xff024D63),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff024D63)),
                              isSelected: penColor == Color(0xff024D63),
                            ),
                            CustomColorButton(
                              color: Color(0xff006E8F),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff006E8F)),
                              isSelected: penColor == Color(0xff006E8F),
                            ),
                            CustomColorButton(
                              color: Color(0xff038BB5),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff038BB5)),
                              isSelected: penColor == Color(0xff038BB5),
                            ),
                            CustomColorButton(
                              color: Color(0xff00A1D7),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff00A1D7)),
                              isSelected: penColor == Color(0xff00A1D7),
                            ),
                            CustomColorButton(
                              color: Color(0xff03C7FF),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff03C7FF)),
                              isSelected: penColor == Color(0xff03C7FF),
                            ),
                            CustomColorButton(
                              color: Color(0xff55D6FC),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff55D6FC)),
                              isSelected: penColor == Color(0xff55D6FC),
                            ),
                            CustomColorButton(
                              color: Color(0xff93E4F9),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff93E4F9)),
                              isSelected: penColor == Color(0xff93E4F9),
                            ),
                            CustomColorButton(
                              color: Color(0xffCBEFFF),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffCBEFFF)),
                              isSelected: penColor == Color(0xffCBEFFF),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            CustomColorButton(
                              color: Color(0xffEBEBEB),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffEBEBEB)),
                              isSelected: penColor == Color(0xffEBEBEB),
                            ),
                            CustomColorButton(
                              color: Color(0xff051A59),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff051A59)),
                              isSelected: penColor == Color(0xff051A59),
                            ),
                            CustomColorButton(
                              color: Color(0xff01307C),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff01307C)),
                              isSelected: penColor == Color(0xff01307C),
                            ),
                            CustomColorButton(
                              color: Color(0xff0242AB),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff0242AB)),
                              isSelected: penColor == Color(0xff0242AB),
                            ),
                            CustomColorButton(
                              color: Color(0xff0456D8),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff0456D8)),
                              isSelected: penColor == Color(0xff0456D8),
                            ),
                            CustomColorButton(
                              color: Color(0xff0262FD),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff0262FD)),
                              isSelected: penColor == Color(0xff0262FD),
                            ),
                            CustomColorButton(
                              color: Color(0xff3B87FF),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff3B87FF)),
                              isSelected: penColor == Color(0xff3B87FF),
                            ),
                            CustomColorButton(
                              color: Color(0xff76A6FF),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff76A6FF)),
                              isSelected: penColor == Color(0xff76A6FF),
                            ),
                            CustomColorButton(
                              color: Color(0xffA9C5FF),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffA9C5FF)),
                              isSelected: penColor == Color(0xffA9C5FF),
                            ),
                            CustomColorButton(
                              color: Color(0xffD0E0FE),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffD0E0FE)),
                              isSelected: penColor == Color(0xffD0E0FE),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            CustomColorButton(
                              color: Color(0xffD5D5D5),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffD5D5D5)),
                              isSelected: penColor == Color(0xffD5D5D5),
                            ),
                            CustomColorButton(
                              color: Color(0xff1B0A4E),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff1B0A4E)),
                              isSelected: penColor == Color(0xff1B0A4E),
                            ),
                            CustomColorButton(
                              color: Color(0xff1B0A4E),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff1B0A4E)),
                              isSelected: penColor == Color(0xff1B0A4E),
                            ),
                            CustomColorButton(
                              color: Color(0xff2D0877),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff2D0877)),
                              isSelected: penColor == Color(0xff2D0877),
                            ),
                            CustomColorButton(
                              color: Color(0xff381B94),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff381B94)),
                              isSelected: penColor == Color(0xff381B94),
                            ),
                            CustomColorButton(
                              color: Color(0xff4E22B2),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff4E22B2)),
                              isSelected: penColor == Color(0xff4E22B2),
                            ),
                            CustomColorButton(
                              color: Color(0xff5E30EB),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff5E30EB)),
                              isSelected: penColor == Color(0xff5E30EB),
                            ),
                            CustomColorButton(
                              color: Color(0xff864EFC),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff864EFC)),
                              isSelected: penColor == Color(0xff864EFC),
                            ),
                            CustomColorButton(
                              color: Color(0xffAF8DFE),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffAF8DFE)),
                              isSelected: penColor == Color(0xffAF8DFE),
                            ),
                            CustomColorButton(
                              color: Color(0xffDAC9FF),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffDAC9FF)),
                              isSelected: penColor == Color(0xffDAC9FF),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            CustomColorButton(
                              color: Color(0xffC3C4C2),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffC3C4C2)),
                              isSelected: penColor == Color(0xffC3C4C2),
                            ),
                            CustomColorButton(
                              color: Color(0xff2E053D),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff2E053D)),
                              isSelected: penColor == Color(0xff2E053D),
                            ),
                            CustomColorButton(
                              color: Color(0xff460B5B),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff460B5B)),
                              isSelected: penColor == Color(0xff460B5B),
                            ),
                            CustomColorButton(
                              color: Color(0xff61177E),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff61177E)),
                              isSelected: penColor == Color(0xff61177E),
                            ),
                            CustomColorButton(
                              color: Color(0xff7C1FA0),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff7C1FA0)),
                              isSelected: penColor == Color(0xff7C1FA0),
                            ),
                            CustomColorButton(
                              color: Color(0xff932BB9),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff932BB9)),
                              isSelected: penColor == Color(0xff932BB9),
                            ),
                            CustomColorButton(
                              color: Color(0xffBD35F2),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffBD35F2)),
                              isSelected: penColor == Color(0xffBD35F2),
                            ),
                            CustomColorButton(
                              color: Color(0xffD456FF),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffD456FF)),
                              isSelected: penColor == Color(0xffD456FF),
                            ),
                            CustomColorButton(
                              color: Color(0xffE391FE),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffE391FE)),
                              isSelected: penColor == Color(0xffE391FE),
                            ),
                            CustomColorButton(
                              color: Color(0xffECCCFD),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffECCCFD)),
                              isSelected: penColor == Color(0xffECCCFD),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            CustomColorButton(
                              color: Color(0xffA9AEAD),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffA9AEAD)),
                              isSelected: penColor == Color(0xffA9AEAD),
                            ),
                            CustomColorButton(
                              color: Color(0xff3D061B),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff3D061B)),
                              isSelected: penColor == Color(0xff3D061B),
                            ),
                            CustomColorButton(
                              color: Color(0xff551029),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff551029)),
                              isSelected: penColor == Color(0xff551029),
                            ),
                            CustomColorButton(
                              color: Color(0xff7A1A3D),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff7A1A3D)),
                              isSelected: penColor == Color(0xff7A1A3D),
                            ),
                            CustomColorButton(
                              color: Color(0xff992451),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff992451)),
                              isSelected: penColor == Color(0xff992451),
                            ),
                            CustomColorButton(
                              color: Color(0xffB62D5B),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffB62D5B)),
                              isSelected: penColor == Color(0xffB62D5B),
                            ),
                            CustomColorButton(
                              color: Color(0xffE73B75),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffE73B75)),
                              isSelected: penColor == Color(0xffE73B75),
                            ),
                            CustomColorButton(
                              color: Color(0xffF0719E),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffF0719E)),
                              isSelected: penColor == Color(0xffF0719E),
                            ),
                            CustomColorButton(
                              color: Color(0xffF4A3C1),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffF4A3C1)),
                              isSelected: penColor == Color(0xffF4A3C1),
                            ),
                            CustomColorButton(
                              color: Color(0xffFAD4E0),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffFAD4E0)),
                              isSelected: penColor == Color(0xffFAD4E0),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            CustomColorButton(
                              color: Color(0xff999999),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff999999)),
                              isSelected: penColor == Color(0xff999999),
                            ),
                            CustomColorButton(
                              color: Color(0xff5D0700),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff5D0700)),
                              isSelected: penColor == Color(0xff5D0700),
                            ),
                            CustomColorButton(
                              color: Color(0xff811301),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff811301)),
                              isSelected: penColor == Color(0xff811301),
                            ),
                            CustomColorButton(
                              color: Color(0xffB61904),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffB61904)),
                              isSelected: penColor == Color(0xffB61904),
                            ),
                            CustomColorButton(
                              color: Color(0xffE32400),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffE32400)),
                              isSelected: penColor == Color(0xffE32400),
                            ),
                            CustomColorButton(
                              color: Color(0xffFE4017),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffFE4017)),
                              isSelected: penColor == Color(0xffFE4017),
                            ),
                            CustomColorButton(
                              color: Color(0xffFE6350),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffFE6350)),
                              isSelected: penColor == Color(0xffFE6350),
                            ),
                            CustomColorButton(
                              color: Color(0xffFF8B83),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffFF8B83)),
                              isSelected: penColor == Color(0xffFF8B83),
                            ),
                            CustomColorButton(
                              color: Color(0xffFEB5B0),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffFEB5B0)),
                              isSelected: penColor == Color(0xffFEB5B0),
                            ),
                            CustomColorButton(
                              color: Color(0xffFFDAD8),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffFFDAD8)),
                              isSelected: penColor == Color(0xffFFDAD8),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            CustomColorButton(
                              color: Color(0xff858585),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff858585)),
                              isSelected: penColor == Color(0xff858585),
                            ),
                            CustomColorButton(
                              color: Color(0xff581C02),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff581C02)),
                              isSelected: penColor == Color(0xff581C02),
                            ),
                            CustomColorButton(
                              color: Color(0xff7A2902),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff7A2902)),
                              isSelected: penColor == Color(0xff7A2902),
                            ),
                            CustomColorButton(
                              color: Color(0xffAE3D01),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffAE3D01)),
                              isSelected: penColor == Color(0xffAE3D01),
                            ),
                            CustomColorButton(
                              color: Color(0xffD95102),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffD95102)),
                              isSelected: penColor == Color(0xffD95102),
                            ),
                            CustomColorButton(
                              color: Color(0xffFF6C02),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffFF6C02)),
                              isSelected: penColor == Color(0xffFF6C02),
                            ),
                            CustomColorButton(
                              color: Color(0xffFF8749),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffFF8749)),
                              isSelected: penColor == Color(0xffFF8749),
                            ),
                            CustomColorButton(
                              color: Color(0xffFFA579),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffFFA579)),
                              isSelected: penColor == Color(0xffFFA579),
                            ),
                            CustomColorButton(
                              color: Color(0xffFEC4A9),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffFEC4A9)),
                              isSelected: penColor == Color(0xffFEC4A9),
                            ),
                            CustomColorButton(
                              color: Color(0xffFDE1D8),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffFDE1D8)),
                              isSelected: penColor == Color(0xffFDE1D8),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            CustomColorButton(
                              color: Color(0xff717172),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff717172)),
                              isSelected: penColor == Color(0xff717172),
                            ),
                            CustomColorButton(
                              color: Color(0xff5B3200),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff5B3200)),
                              isSelected: penColor == Color(0xff5B3200),
                            ),
                            CustomColorButton(
                              color: Color(0xff794A00),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff794A00)),
                              isSelected: penColor == Color(0xff794A00),
                            ),
                            CustomColorButton(
                              color: Color(0xffA96803),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffA96803)),
                              isSelected: penColor == Color(0xffA96803),
                            ),
                            CustomColorButton(
                              color: Color(0xffD28303),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffD28303)),
                              isSelected: penColor == Color(0xffD28303),
                            ),
                            CustomColorButton(
                              color: Color(0xffFDAB06),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffFDAB06)),
                              isSelected: penColor == Color(0xffFDAB06),
                            ),
                            CustomColorButton(
                              color: Color(0xffFDB43C),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffFDB43C)),
                              isSelected: penColor == Color(0xffFDB43C),
                            ),
                            CustomColorButton(
                              color: Color(0xffFCC876),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffFCC876)),
                              isSelected: penColor == Color(0xffFCC876),
                            ),
                            CustomColorButton(
                              color: Color(0xffFDD9A9),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffFDD9A9)),
                              isSelected: penColor == Color(0xffFDD9A9),
                            ),
                            CustomColorButton(
                              color: Color(0xffFDECD3),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffFDECD3)),
                              isSelected: penColor == Color(0xffFDECD3),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            CustomColorButton(
                              color: Color(0xff5C5C5D),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff5C5C5D)),
                              isSelected: penColor == Color(0xff5C5C5D),
                            ),
                            CustomColorButton(
                              color: Color(0xff563E02),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff563E02)),
                              isSelected: penColor == Color(0xff563E02),
                            ),
                            CustomColorButton(
                              color: Color(0xff795802),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff795802)),
                              isSelected: penColor == Color(0xff795802),
                            ),
                            CustomColorButton(
                              color: Color(0xffA67903),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffA67903)),
                              isSelected: penColor == Color(0xffA67903),
                            ),
                            CustomColorButton(
                              color: Color(0xffD49D05),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffD49D05)),
                              isSelected: penColor == Color(0xffD49D05),
                            ),
                            CustomColorButton(
                              color: Color(0xffFCC700),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffFCC700)),
                              isSelected: penColor == Color(0xffFCC700),
                            ),
                            CustomColorButton(
                              color: Color(0xffFFCA3D),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffFFCA3D)),
                              isSelected: penColor == Color(0xffFFCA3D),
                            ),
                            CustomColorButton(
                              color: Color(0xffFFD977),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffFFD977)),
                              isSelected: penColor == Color(0xffFFD977),
                            ),
                            CustomColorButton(
                              color: Color(0xffFDE4A8),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffFDE4A8)),
                              isSelected: penColor == Color(0xffFDE4A8),
                            ),
                            CustomColorButton(
                              color: Color(0xffFEF2D6),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffFEF2D6)),
                              isSelected: penColor == Color(0xffFEF2D6),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            CustomColorButton(
                              color: Color(0xff474748),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff474748)),
                              isSelected: penColor == Color(0xff474748),
                            ),
                            CustomColorButton(
                              color: Color(0xff656002),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff656002)),
                              isSelected: penColor == Color(0xff656002),
                            ),
                            CustomColorButton(
                              color: Color(0xff8D8601),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff8D8601)),
                              isSelected: penColor == Color(0xff8D8601),
                            ),
                            CustomColorButton(
                              color: Color(0xffC2BC04),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffC2BC04)),
                              isSelected: penColor == Color(0xffC2BC04),
                            ),
                            CustomColorButton(
                              color: Color(0xffF8ED04),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffF8ED04)),
                              isSelected: penColor == Color(0xffF8ED04),
                            ),
                            CustomColorButton(
                              color: Color(0xffFEFA3E),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffFEFA3E)),
                              isSelected: penColor == Color(0xffFEFA3E),
                            ),
                            CustomColorButton(
                              color: Color(0xffFEF769),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffFEF769)),
                              isSelected: penColor == Color(0xffFEF769),
                            ),
                            CustomColorButton(
                              color: Color(0xffFFF994),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffFFF994)),
                              isSelected: penColor == Color(0xffFFF994),
                            ),
                            CustomColorButton(
                              color: Color(0xffFEFCB9),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffFEFCB9)),
                              isSelected: penColor == Color(0xffFEFCB9),
                            ),
                            CustomColorButton(
                              color: Color(0xffFEFADB),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffFEFADB)),
                              isSelected: penColor == Color(0xffFEFADB),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            CustomColorButton(
                              color: Color(0xff333334),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff333334)),
                              isSelected: penColor == Color(0xff333334),
                            ),
                            CustomColorButton(
                              color: Color(0xff505508),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff505508)),
                              isSelected: penColor == Color(0xff505508),
                            ),
                            CustomColorButton(
                              color: Color(0xff6E750B),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff6E750B)),
                              isSelected: penColor == Color(0xff6E750B),
                            ),
                            CustomColorButton(
                              color: Color(0xff9CA509),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff9CA509)),
                              isSelected: penColor == Color(0xff9CA509),
                            ),
                            CustomColorButton(
                              color: Color(0xffC2D11A),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffC2D11A)),
                              isSelected: penColor == Color(0xffC2D11A),
                            ),
                            CustomColorButton(
                              color: Color(0xffD9ED38),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffD9ED38)),
                              isSelected: penColor == Color(0xffD9ED38),
                            ),
                            CustomColorButton(
                              color: Color(0xffE3EF66),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffE3EF66)),
                              isSelected: penColor == Color(0xffE3EF66),
                            ),
                            CustomColorButton(
                              color: Color(0xffECF08F),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffECF08F)),
                              isSelected: penColor == Color(0xffECF08F),
                            ),
                            CustomColorButton(
                              color: Color(0xffF1F7B5),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffF1F7B5)),
                              isSelected: penColor == Color(0xffF1F7B5),
                            ),
                            CustomColorButton(
                              color: Color(0xffF5F9D8),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffF5F9D8)),
                              isSelected: penColor == Color(0xffF5F9D8),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            CustomColorButton(
                              color: Color(0xff000000),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff000000)),
                              isSelected: penColor == Color(0xff000000),
                            ),
                            CustomColorButton(
                              color: Color(0xff273D10),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff273D10)),
                              isSelected: penColor == Color(0xff273D10),
                            ),
                            CustomColorButton(
                              color: Color(0xff38571D),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff38571D)),
                              isSelected: penColor == Color(0xff38571D),
                            ),
                            CustomColorButton(
                              color: Color(0xff507A27),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff507A27)),
                              isSelected: penColor == Color(0xff507A27),
                            ),
                            CustomColorButton(
                              color: Color(0xff679D35),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff679D35)),
                              isSelected: penColor == Color(0xff679D35),
                            ),
                            CustomColorButton(
                              color: Color(0xff72B83E),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff72B83E)),
                              isSelected: penColor == Color(0xff72B83E),
                            ),
                            CustomColorButton(
                              color: Color(0xff96D25C),
                              onTap: () =>
                                  setState(() => penColor = Color(0xff96D25C)),
                              isSelected: penColor == Color(0xff96D25C),
                            ),
                            CustomColorButton(
                              color: Color(0xffB0DA86),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffB0DA86)),
                              isSelected: penColor == Color(0xffB0DA86),
                            ),
                            CustomColorButton(
                              color: Color(0xffCEE8B3),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffCEE8B3)),
                              isSelected: penColor == Color(0xffCEE8B3),
                            ),
                            CustomColorButton(
                              color: Color(0xffDEECD4),
                              onTap: () =>
                                  setState(() => penColor = Color(0xffDEECD4)),
                              isSelected: penColor == Color(0xffDEECD4),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Theme(
                      data: ThemeData(
                        sliderTheme: SliderThemeData(trackHeight: penWidth),
                      ),
                      child: Slider(
                        value: penWidth,
                        activeColor: penColor,
                        onChanged: (value) => setState(() => penWidth = value),
                        max: 20,
                        min: 0.5,
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () => setState(() => penCap = StrokeCap.butt),
                          child: Container(
                            width: 75,
                            height: 35,
                            color: penCap == StrokeCap.butt
                                ? Colors.grey
                                : Colors.white,
                            alignment: Alignment.center,
                            child: Text('butt'),
                          ),
                        ),
                        GestureDetector(
                          onTap: () =>
                              setState(() => penCap = StrokeCap.square),
                          child: Container(
                            width: 75,
                            height: 35,
                            color: penCap == StrokeCap.square
                                ? Colors.grey
                                : Colors.white,
                            alignment: Alignment.center,
                            child: Text('square'),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => setState(() => penCap = StrokeCap.round),
                          child: Container(
                            width: 75,
                            height: 35,
                            color: penCap == StrokeCap.round
                                ? Colors.grey
                                : Colors.white,
                            alignment: Alignment.center,
                            child: Text('round'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
            visible: isShowMenu,
            child: GestureDetector(
              onTap: () => saveToImage(),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black),
                ),
                alignment: Alignment.center,
                child: Icon(Icons.save, color: Colors.black),
              ),
            ),
          ),
          SizedBox(height: 15),
          Visibility(
            visible: isShowMenu,
            child: GestureDetector(
              onTap: () => setState(() => points.clear()),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.red),
                ),
                alignment: Alignment.center,
                child: Icon(Icons.cleaning_services_rounded, color: Colors.red),
              ),
            ),
          ),
          SizedBox(height: 15),
          Visibility(
            visible: isShowMenu,
            child: GestureDetector(
              onTap: () => setState(() => isPenMode = !isPenMode),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: !isPenMode ? Colors.blue : Colors.grey,
                  ),
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.pan_tool,
                  color: !isPenMode ? Colors.blue : Colors.grey,
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Visibility(
            visible: isShowMenu,
            child: GestureDetector(
              onTap: () => setState(() => penColor = Colors.white),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.red),
                ),
                alignment: Alignment.center,
                child: Icon(Icons.phonelink_erase, color: Colors.red),
              ),
            ),
          ),
          SizedBox(height: 15),
          Visibility(
            visible: isShowMenu,
            child: GestureDetector(
              onTap: () => setState(() => isShowPalette = !isShowPalette),
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
          SizedBox(height: 15),
          AnimatedRotation(
            duration: Duration(milliseconds: 100),
            turns: isShowMenu ? -1.25 : -1,
            child: FloatingActionButton(
              onPressed: () => setState(() => isShowMenu = !isShowMenu),
              shape: CircleBorder(),
              backgroundColor: Colors.white,
              child: Icon(Icons.palette, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
