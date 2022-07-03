import 'package:flutter/material.dart';
import 'package:youtobe_demo/screen/details/components/circular_slider.dart';
import 'dart:math' as math;

import 'package:youtobe_demo/screen/widget/big_text.dart';

import '../widget/small_text.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int valueAngle = 0;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: buildAppbar(size),
      body: Stack(
        children: [
          buildBody(size),
          buildBottom(size)
        ],
      ),
    );
  }

   buildBody(Size size) {
    return Column(
          children: [
            SizedBox(
              height: size.height / 2.5,
              width: size.width * 0.85,
              child: CircularSlider(
                valueAngleDefault: 20,
                onAngleChanged: (angle) {
                  /*   valueAngle = ((angle / (math.pi * 2)) * 41).toInt();
                   setState((){

                   });*/
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: size.height * 0.07,
              width: size.width * 0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey.shade300,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmallText(
                      text: "Device 1",
                      textColor: Colors.grey.shade700,
                      fontSize: 19,
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_outlined,
                      size: 40,
                      color: Colors.grey.shade700,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                      height: size.height * 0.23,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: size.height * 0.07,
                            width: size.height * 0.07,
                            decoration: BoxDecoration(
                                color: Color(0xfffecdcd),
                                shape: BoxShape.circle),
                            child: ShaderMask(
                                shaderCallback: (Rect bounds) {
                                  return LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomRight,
                                    colors: <Color>[
                                      Colors.purple.shade200,
                                      Colors.redAccent.shade400,
                                    ],
                                    tileMode: TileMode.mirror,
                                  ).createShader(bounds);
                                },
                                child: Icon(
                                  Icons.water_drop_outlined,
                                  color: Colors.white,
                                )),
                          ),
                          BigText(
                            text: "Inside humidity",
                            textColor: Colors.grey.shade700,
                          ),
                          BigText(
                              text: "49%", textColor: Colors.grey.shade700),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                      height: size.height * 0.23,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: size.height * 0.07,
                            width: size.height * 0.07,
                            decoration: BoxDecoration(
                                color: Color(0xfffecdcd),
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.deepPurple.withOpacity(0.6),
                                      Colors.redAccent.withOpacity(0.5),
                                    ])),
                            child: ShaderMask(
                                shaderCallback: (Rect bounds) {
                                  return LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomRight,
                                    colors: <Color>[
                                      Colors.deepPurple,
                                      Colors.pink,
                                    ],
                                    tileMode: TileMode.mirror,
                                  ).createShader(bounds);
                                },
                                child: Icon(
                                  Icons.ac_unit,
                                  color: Colors.white,
                                )),
                          ),
                          BigText(
                            text: "Outside Temps.",
                            textColor: Colors.grey.shade700,
                          ),
                          BigText(
                              text: "10°", textColor: Colors.grey.shade700),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
  }

  AppBar buildAppbar(Size size) {
    return AppBar(
      toolbarHeight: size.height * 0.07,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
      elevation: 0,
      title: BigText(
        text: "Thermostat",
        textColor: Colors.black,
      ),
      actions: [
        Container(
          width: 50,
          margin: EdgeInsets.only(right: 20, bottom: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.grey.shade200,
                  Colors.grey.shade100,
                  Colors.white,
                ],
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade300,
                    offset: Offset(5, 3),
                    blurRadius: 9,
                    spreadRadius: 1)
              ]),
          child: Icon(
            Icons.settings,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Padding buildBottom(Size size) {
    return Padding(
          padding: const EdgeInsets.only( right: 20, left: 20),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: size.height * 0.12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Container(
                        height: size.height * 0.06,
                        width: size.height * 0.06,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomRight,
                              colors: <Color>[
                                Colors.purple,
                                Colors.redAccent,
                              ],
                              tileMode: TileMode.mirror,
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400,
                                blurRadius: 1,
                                spreadRadius: 5,
                                offset: Offset(0, -1),
                              ),
                              BoxShadow(
                                  color: Colors.pink,
                                  spreadRadius: 4,
                                  blurRadius: 30,
                                  offset: Offset(0, 0),
                                  blurStyle: BlurStyle.inner),
                            ]),
                        child: Icon(
                          Icons.local_fire_department_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SmallText(
                        text: "MODE",
                        textColor: Colors.grey.shade600,
                      ),
                    ],
                  ),

                  Column(
                    children: [
                      Container(
                        height: size.height * 0.06,
                        width: size.height * 0.06,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomRight,
                              colors: <Color>[
                                Colors.grey.shade100,
                                Colors.grey.shade200,
                                Colors.grey.shade400,
                              ],
                              tileMode: TileMode.mirror,
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: 2,
                                  blurRadius: 1,
                                  offset: Offset(0, 1),
                                  blurStyle: BlurStyle.solid),
                              BoxShadow(
                                color: Colors.grey,
                                blurStyle: BlurStyle.inner,
                                spreadRadius: 3,
                                blurRadius: 55,
                                offset: Offset(0, 0),
                              ),
                            ]),
                        child: Icon(
                          Icons.energy_savings_leaf_outlined,
                          color: Colors.grey,
                          size: 30,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SmallText(
                        text: "ECO",
                        textColor: Colors.grey.shade600,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: size.height * 0.06,
                        width: size.height * 0.06,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomRight,
                              colors: <Color>[
                                Colors.grey.shade100,
                                Colors.grey.shade200,
                                Colors.grey.shade400,
                              ],
                              tileMode: TileMode.mirror,
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: 2,
                                  blurRadius: 1,
                                  offset: Offset(0, 1),
                                  blurStyle: BlurStyle.solid),
                              BoxShadow(
                                color: Colors.grey,
                                blurStyle: BlurStyle.inner,
                                spreadRadius: 3,
                                blurRadius: 55,
                                offset: Offset(0, 0),
                              ),
                            ]),
                        child: Icon(
                          Icons.schedule_outlined,
                          color: Colors.grey,
                          size: 30,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SmallText(
                        text: "SCHEDULE",
                        textColor: Colors.grey.shade600,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: size.height * 0.06,
                        width: size.height * 0.06,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomRight,
                              colors: <Color>[
                                Colors.grey.shade100,
                                Colors.grey.shade200,
                                Colors.grey.shade400,
                              ],
                              tileMode: TileMode.mirror,
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: 2,
                                  blurRadius: 1,
                                  offset: Offset(0, 1),
                                  blurStyle: BlurStyle.solid),
                              BoxShadow(
                                color: Colors.grey,
                                blurStyle: BlurStyle.inner,
                                spreadRadius: 3,
                                blurRadius: 55,
                                offset: Offset(0, 0),
                              ),
                            ]),
                        child: Icon(
                          Icons.history_sharp,
                          color: Colors.grey,
                          size: 30,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SmallText(
                        text: "ECO",
                        textColor: Colors.grey.shade600,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
  }
}
