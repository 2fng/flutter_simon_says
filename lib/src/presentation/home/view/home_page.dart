import 'package:flutter/material.dart';

import '../../../domain/entities/colored_button.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  
  final greenButton = ButtonColor.green.button;
  final yellowButton = ButtonColor.yellow.button;
  final redButton = ButtonColor.red.button;
  final blueButton = ButtonColor.blue.button;

  @override
  Widget build(BuildContext context) {
    double delay = 0.5;
    return ClipRect(
      clipBehavior: Clip.antiAlias,
      child: Stack(children: [
        _buildButtonContainer(),
        Center(
          child: Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(80),
                ),
                color: Colors.black),
            child: const Center(
              child: Text(
                'Simon',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
        )
      ]),
    );
  }

  Container _buildButtonContainer() {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              redButton,
              const SizedBox(width: 10),
              blueButton,
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              yellowButton,
              const SizedBox(width: 10),
              greenButton,
            ],
          ),
        ],
      ),
    );
  }
}
