import 'package:flutter/material.dart';
import 'package:youtobe_demo/screen/widget/big_text.dart';
import 'package:youtobe_demo/screen/widget/small_text.dart';
import 'package:youtobe_demo/utils/math.dart';

import '../../../utils/colors_theme.dart';
import 'dart:math' as math;



class CircularSlider extends StatefulWidget {
  final ValueChanged<double> onAngleChanged;
  final double valueRadius;
  final double valueAngleDefault;

  CircularSlider({Key? key, required this.onAngleChanged, this.valueRadius = 41, this.valueAngleDefault = 0}) : super(key: key);

  @override
  State<CircularSlider> createState() => _CircularSliderState();
}

class _CircularSliderState extends State<CircularSlider> {
  Offset _currentDragOffset = Offset.zero;

  double currenAngle = 0;
  int valueAngle = 0;

  double startAngle = toRadian(90);

  double totalAngle = toRadian(360);

  List<String> listTemp = [
    "10",
    "20",
    "30",
  ];


  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    Size canvasSize = Size(screenSize.width, screenSize.width - 35);
    Offset center = canvasSize.center(Offset.zero);
    /*Offset knobPos = toPolar(center - Offset(strokeWitdh, strokeWitdh),
        (currenAngle) + startAngle, radius / 2);*/
    return TweenAnimationBuilder(
      duration: Duration(seconds: 1),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context,double value, child) {
        currenAngle = ((widget.valueAngleDefault/widget.valueRadius)*(math.pi * 2) * value);
        valueAngle = ((currenAngle / (math.pi * 2)) * widget.valueRadius).toInt();

        return StatefulBuilder(
          builder: (context, setState2) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: screenSize.width / 1.59,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        blurStyle: BlurStyle.outer,
                        color: Colors.grey,
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      )
                    ],
                  ),
                ),
                Container(
                  width: screenSize.width / 1.6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        blurStyle: BlurStyle.inner,
                        color: Colors.grey.withOpacity(0.5),
                        offset: Offset(0, 0),
                        blurRadius: 10,
                      )
                    ],
                  ),
                ),
                CustomPaint(
                  child: Container(),
                  painter:
                  SliderPaint(startAngle: startAngle, currenAngle: currenAngle),
                ),
                ...List.generate(
                  listTemp.length,
                      (index) => Align(
                      alignment: index == 0
                          ? Alignment.centerLeft
                          : index == 1
                          ? Alignment.topCenter
                          : Alignment.centerRight,
                      child: SmallText(
                        text: "${listTemp[index]}°",
                        fontSize: 16,
                      )),
                ),
                Container(
                  height: screenSize.height / 2.1,
                  width: screenSize.width / 2.1,
                  decoration: BoxDecoration(

                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 8),
                          spreadRadius: 3,
                          color: Colors.grey,
                          blurRadius: 18)
                    ],
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white,
                          Colors.white,
                          Colors.grey.shade50,
                          Colors.grey.shade200,

                        ]),
                  ),



                ),
                GestureDetector(
                  onPanStart: (details) {
                    RenderBox getBox = context.findRenderObject() as RenderBox;
                    _currentDragOffset =
                        getBox.globalToLocal(details.globalPosition);
                  },
                  onPanUpdate: (details) {
                    var previousOffset = _currentDragOffset;
                    _currentDragOffset += details.delta;
                    var angle = currenAngle +
                        toAngle(_currentDragOffset, center) -
                        toAngle(previousOffset, center);
                    currenAngle = nornalizeAngle(angle);
                    print(angle);
                    valueAngle = ((currenAngle / (math.pi * 2)) * widget.valueRadius).toInt();
                    widget.onAngleChanged(currenAngle);
                    setState2(() {});
                  },

                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Transform.rotate(
                        angle: currenAngle,
                        child: Container(
                          height: screenSize.height / 4.4,
                          width: screenSize.width / 2.5,
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,

                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.grey.shade400,
                                    Colors.grey.shade300,
                                    Colors.white,
                                  ])),
                          child: Container(
                            width: 15,
                            height: 15,
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.grey.shade200,
                                      Colors.grey,
                                    ]
                                )
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height/5.3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            BigText(
                              text: "HEATING",
                              fontSize: 20,
                              textColor: Colors.grey.shade700,
                            ),
                            BigText(
                              text: valueAngle.toString(),
                              fontSize: 50,
                              textColor: Colors.grey.shade700,
                            ),
                            Icon(Icons.energy_savings_leaf_outlined,color: Colors.green,size: 30,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),


              ],
            );
          }
        );
      }
    );
  }
}

class SliderPaint extends CustomPainter {
  final double startAngle;
  final double currenAngle;

  SliderPaint({required this.startAngle, required this.currenAngle});

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = size.center(Offset.zero);


    //rotate clock
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    //radius setting paint
    double radius = size.width * 0.32;
    double strokeWitdh = size.width * 0.089;
    var radius0 = math.min(centerX, centerY) * 0.85;

    int valueTest = ((currenAngle / (math.pi * 2)) * 360).toInt();

    dashBrushFn({Color? colors}) => Paint()
      ..color = colors ?? Color(0xfffd007f)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;

    //
    Rect rect = Rect.fromCircle(center: center, radius: radius);
    var rainbowPaint = Paint()
      ..shader = SweepGradient(colors: colors).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWitdh
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      rect,
      0,
      math.pi * 2,
      false,
      Paint()
        ..color = Colors.grey.shade300
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWitdh,
    );

    canvas.drawArc(rect, startAngle, currenAngle, false, rainbowPaint);

    var outerCircleRadius = radius0;
    var innerCircleRadius = radius0 - 12;
    Color colorCheck = Colors.grey;

    for (double i = 180; i < 361; i += 9) {
      var x1 = centerX + outerCircleRadius * math.cos((i * math.pi) / 180);
      var y1 = centerY + outerCircleRadius * math.sin((i * math.pi) / 180);

      var x2 = centerX + innerCircleRadius * math.cos((i * math.pi) / 180);
      var y2 = centerY + innerCircleRadius * math.sin((i * math.pi) / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2),
          i < valueTest + 90 ? dashBrushFn() : dashBrushFn(colors: colorCheck));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}

