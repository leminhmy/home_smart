import 'package:flutter/material.dart';
import 'package:youtobe_demo/screen/widget/big_text.dart';
import 'package:youtobe_demo/screen/widget/custom_swich.dart';

class SwichAndText extends StatefulWidget {
  const SwichAndText({Key? key, this.isCheck = false}) : super(key: key);

  final bool isCheck;


  @override
  State<SwichAndText> createState() => _SwichAndTextState();
}

class _SwichAndTextState extends State<SwichAndText> {
  late bool value;

  @override
  void initState(){
    super.initState();
    value = widget.isCheck;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BigText(text: value?"ON":"OFF",textColor: value?Colors.black:Colors.grey),
        CustomSwitch(
          colorButton: value?[Colors.purple, Colors.pink]:[Colors.grey,Colors.black],
          activeColor: Colors.grey,
          value: value,
          onChanged: (value) {
            setState(() {
              this.value = value;
            });
          },
        ),
        /*Switch(
            activeColor: Colors.red,
            activeTrackColor: Colors.grey,
            value: value, onChanged: (value){
          setState((){
            this.value = value;
          });
        }),*/
      ],
    );
  }
}
