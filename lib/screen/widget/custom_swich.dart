import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color inactiveColor;
  final String activeText;
  final String inactiveText;
  final Color activeTextColor;
  final Color inactiveTextColor;
  final List<Color> colorButton;

  const CustomSwitch(
      {Key? key,
        required this.value,
        required this.onChanged,
        required this.activeColor,
        this.inactiveColor = Colors.grey,
        this.activeText = '',
        this.inactiveText = '',
        this.activeTextColor = Colors.white70,
        this.inactiveTextColor = Colors.white70, this.colorButton = const [
        Colors.purple,
        Colors.pink,
      ]})
      : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
 late Animation _circleAnimation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _circleAnimation = AlignmentTween(
        begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
        end: widget.value ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(
        parent: _animationController, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (_animationController.isCompleted) {
              _animationController.reverse();
            } else {
              _animationController.forward();
            }
            widget.value == false
                ? widget.onChanged(true)
                : widget.onChanged(false);
          },
          child: Container(
            width: 70.0,
            height: 35.0,
            alignment: _circleAnimation.value,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              // I commented here.
              // color: _circleAnimation.value == Alignment.centerLeft
              //     ? widget.inactiveColor
              //     : widget.activeColor,

              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                // You can set your own colors in here!
                colors: [
                  Colors.grey.shade400,
                  Colors.grey.shade200,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 4.0, bottom: 4.0, right: 4.0, left: 4.0),
              child: Container(
                width: 25.0,
                height: 25.0,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        // You can set your own colors in here!
                        colors: widget.colorButton
                    ),
                    shape: BoxShape.circle, color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}
