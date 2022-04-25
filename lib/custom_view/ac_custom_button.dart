import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'knob/knob.dart';

class ArcWidget extends StatefulWidget {
  const ArcWidget({Key? key}) : super(key: key);

  @override
  _ArcWidgetState createState() => _ArcWidgetState();
}

class _ArcWidgetState extends State<ArcWidget> {
  final double width = 200;
  final double height = 200;
  double baseAngle = 0;
  Offset? lastPosition;
  double lastBaseAngle = 0;
  double angle = -2;


  double _value = 16.0;
  void _setValue(double value) => setState(() => _value = value);
  static const double minValue = 16.0;
  static const double maxValue = 32.0;

  @override
  Widget build(BuildContext context) {
    print("angle = $angle");
    return Scaffold(
      appBar: AppBar(title: const Text('Rotating arcs')),
      body: Center(
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Knob(
                value: _value,
                color: Colors.blue,
                onChanged: _setValue,
                min: minValue,
                max: maxValue,
                size: 50
            ),
            Slider(
                value: _value,
                onChanged: _setValue,
                min: minValue,
                max: maxValue),
            Text(
              'Value: ${_value.toStringAsFixed(1)}',
            ),
          ],
        ),
        // child: Transform.rotate(
        //   angle: angle,
        //   child: CustomPaint(
        //     painter: LinePainter(),
        //     child: GestureDetector(
        //       onPanUpdate: (details) => {
        //         if (details.localPosition.direction > -2 && details.localPosition.direction < 2)
        //           {
        //             setState(() {
        //               angle = details.localPosition.direction;
        //             })
        //           }
        //       },
        //     ),
        //   ),
        // ),
        // child: Stack(
        //   alignment: Alignment.center,
        //   children: [
        //     Transform.rotate(
        //       angle: angle,
        //       alignment: Alignment.center,
        //       child: GestureDetector(
        //         // onPanUpdate: (details) => {
        //         //   if (details.delta.dx > 0) {print("Dragging in +X direction")} else {print("Dragging in -X direction")},
        //         //   if (details.delta.dy > 0) {print("Dragging in +Y direction")} else {print("Dragging in -Y direction")},
        //         //   if (details.localPosition.direction > -2 && details.localPosition.direction < 2)
        //         //     {
        //         //       setState(() {
        //         //         angle = details.localPosition.direction;
        //         //       })
        //         //     }
        //         // },
        //         onVerticalDragStart: (value) {
        //           print("onVerticalDragStart = ${value.localPosition.direction}");
        //           // setInitialState(value);
        //         },
        //         onHorizontalDragUpdate: (value) {
        //           print("onHorizontalDragUpdate = ${value.localPosition.direction}");
        //           if (value.localPosition.direction > -2 && value.localPosition.direction < 2) {
        //             setState(() {
        //               angle = value.localPosition.direction;
        //             });
        //           }
        //           // updateAngle(value);
        //         },
        //         onVerticalDragUpdate: (value) {
        //           print("onVerticalDragUpdate = ${value.localPosition.direction}");
        //           if (value.localPosition.direction > -2 && value.localPosition.direction < 2) {
        //             setState(() {
        //               angle = value.localPosition.direction;
        //             });
        //           }
        //           // updateAngle(value);
        //         },
        //         onHorizontalDragStart: (value) {
        //           print("onHorizontalDragStart = ${value.localPosition.direction}");
        //           // setInitialState(value);
        //         },
        //         child: Container(
        //           width: 200,
        //           height: 200,
        //           padding: const EdgeInsets.only(top: 5),
        //           decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
        //           alignment: Alignment.topCenter,
        //           child: Container(
        //             width: 20,
        //             height: 20,
        //             decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        // Stack(
        //   children: [
        //     SizedBox(
        //       width: width,
        //       height: height,
        //       child: CustomPaint(
        //         painter: ArcPainter(100, baseAngle),
        //         child: GestureDetector(
        //           onVerticalDragStart: (value) {
        //             setInitialState(value);
        //           },
        //           onHorizontalDragUpdate: (value) {
        //             updateAngle(value);
        //           },
        //           onVerticalDragUpdate: (value) {
        //             updateAngle(value);
        //           },
        //           onHorizontalDragStart: (value) {
        //             setInitialState(value);
        //           },
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }

  void updateAngle(DragUpdateDetails value) {
    double result = math.atan2(value.localPosition.dy - height / 2, value.localPosition.dx - width / 2) -
        math.atan2(lastPosition!.dy - height / 2, lastPosition!.dx - width / 2);
    setState(() {
      // print("lastBaseAngle = $lastBaseAngle");
      // print("result = $result");
      print("baseAngle = $baseAngle");
      baseAngle = lastBaseAngle + result;
    });
  }

  void setInitialState(DragStartDetails value) {
    lastPosition = value.localPosition;
    lastBaseAngle = baseAngle;
  }
}

class ArcPainter extends CustomPainter {
  final double radius;
  double baseAngle;
  final Paint red = createPaintForColor(Colors.red);
  final Paint blue = createPaintForColor(Colors.blue);
  final Paint green = createPaintForColor(Colors.green);
  final Paint yellow = createPaintForColor(Colors.yellow);

  ArcPainter(this.radius, this.baseAngle);

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: radius);
    canvas.drawArc(rect, baseAngle, sweepAngle(), false, blue);
    canvas.drawArc(rect, baseAngle + 2 / 3 * math.pi, sweepAngle(), false, red);
    canvas.drawArc(rect, baseAngle + 4 / 3 * math.pi, sweepAngle(), false, green);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  double sweepAngle() => 0.8 * 2 / 3 * math.pi;
}

class LinePainter extends CustomPainter {
  final Paint yellow = createPaintForColor(Colors.yellow);

  @override
  void paint(Canvas canvas, Size size) {
    var radius = 100.0;
    // List<double> arr = [0.2, 0.3, 0.5];
    // arr.forEach((element) {
    //   var x = radius * math.sin(math.pi * 2 * element / 360);
    //   var y = radius * math.cos(math.pi * 2 * element / 360);
    //
    //   canvas.drawLine(const Offset(0.0, 0.0), Offset(10.0, 10.0), yellow);
    // });
    canvas.drawLine(const Offset(100.0, 100.0), Offset(100.0, 100.0), yellow);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

Paint createPaintForColor(Color color) {
  return Paint()
    ..color = color
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.stroke
    ..strokeWidth = 15;
}
