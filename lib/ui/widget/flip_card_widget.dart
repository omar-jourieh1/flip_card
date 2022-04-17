import 'dart:math';

import 'package:flutter/material.dart';

class FlipCardWidget extends StatefulWidget {
  const FlipCardWidget(
      {Key? key,
      required this.isVertical,
      required this.front,
      required this.back})
      : super(key: key);
  final Image front;
  final Image back;
  final bool isVertical;
  @override
  State<FlipCardWidget> createState() => _FlipCardWidgetState();
}

class _FlipCardWidgetState extends State<FlipCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  bool isFront = true;
  bool isFrontStart = true;
  double dragPosition = 0;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    controller.addListener(() {
      setState(() {
        dragPosition = animation.value;
        setImageSide();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var angle = dragPosition / 180 * pi;
    var transform = Matrix4.identity()
      ..setEntry(3, 2, 0.001)
      ..rotateY(angle);
    var transFormHorizontal = Matrix4.identity()
      ..setEntry(3, 2, 0.001)
      ..rotateX(angle);
    return GestureDetector(
        onHorizontalDragStart: (details) {
          controller.stop();
          isFrontStart = isFront;
        },
        onHorizontalDragUpdate: (details) {
          setState(() {
            dragPosition -=
                widget.isVertical ? details.delta.dx : details.delta.dy;
            dragPosition %= 360;
            setImageSide();
          });
        },
        onVerticalDragUpdate: (details) {
          setState(() {
            dragPosition -=
                widget.isVertical ? details.delta.dx : details.delta.dy;
            dragPosition %= 360;
            setImageSide();
          });
        },
        onHorizontalDragEnd: (details) {
          final velcoity = details.velocity.pixelsPerSecond.dx.abs();

          if (velcoity >= 100) isFront = !isFrontStart;
          final double end = isFront ? (dragPosition > 180 ? 360 : 0) : 180;

          animation = Tween<double>(
            begin: dragPosition,
            end: end,
          ).animate(controller);
          controller.forward(from: 0);
        },
        onVerticalDragEnd: (details) {
          final velcoity = details.velocity.pixelsPerSecond.dx.abs();

          if (velcoity >= 100) isFront = !isFrontStart;
          final double end = isFront ? (dragPosition > 180 ? 360 : 0) : 180;

          animation = Tween<double>(
            begin: dragPosition,
            end: end,
          ).animate(controller);
          controller.forward(from: 0);
        },
        child: Transform(
          transform: widget.isVertical ? transform : transFormHorizontal,
          alignment: Alignment.center,
          child: isFront
              ? widget.front
              : Transform(
                  transform: Matrix4.identity()..rotateX(pi),
                  alignment: Alignment.center,
                  child: widget.back),
        ));
  }

  void setImageSide() {
    if (dragPosition <= 90 || dragPosition >= 270) {
      isFront = true;
    } else {
      isFront = false;
    }
  }
}
