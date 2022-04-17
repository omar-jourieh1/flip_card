import 'package:flip_card/ui/widget/flip_card_widget.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isVertical = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: FlipCardWidget(
              front: Image.asset('assets/images/face.png',
                  width: 270, height: 270),
              back: Image.asset('assets/images/back.png',
                  width: 270, height: 270),
              isVertical: isVertical,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                color: Colors.amber,
                onPressed: () {
                  setState(() {
                    isVertical = true;
                  });
                },
                child: const Text('Vertical'),
              ),
              MaterialButton(
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    isVertical = false;
                  });
                },
                child: const Text('Horizontal'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
