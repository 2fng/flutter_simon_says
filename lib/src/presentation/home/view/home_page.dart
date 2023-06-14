import 'package:flutter/material.dart';

import '../../../core/utils/constants.dart';
import '../../../domain/entities/colored_button.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final greenButton = ColoredButton(color: ButtonColor.green, willBlink: false);

  final yellowButton =
      ColoredButton(color: ButtonColor.yellow, willBlink: false);

  final redButton = ColoredButton(color: ButtonColor.red, willBlink: false);

  final blueButton = ColoredButton(color: ButtonColor.blue, willBlink: false);

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
    final buttons = [
      greenButton,
      redButton,
      yellowButton,
      blueButton,
      redButton
    ];
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 80),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildColoredButton(redButton),
              const SizedBox(width: 10),
              _buildColoredButton(blueButton),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildColoredButton(yellowButton),
              const SizedBox(width: 10),
              _buildColoredButton(greenButton),
            ],
          ),
          const SizedBox(height: 32),
          ElevatedButton(
              onPressed: currentIndex != 0
                  ? null
                  : () => _mapThroughButtonList(buttons),
              style: ElevatedButton.styleFrom(
                  backgroundColor:
                      currentIndex != 0 ? Colors.black : Colors.white),
              child: const Text(
                'PLAY',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ))
        ],
      ),
    );
  }

  ElevatedButton _buildColoredButton(ColoredButton button) {
    final color = button.color.color;
    final fadedColor = button.color.color.withAlpha(150);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: button.willBlink ? color : fadedColor,
          fixedSize: const Size(buttonWidth, buttonHeight)),
      onPressed: () {},
      child: null,
    );
  }

  void _mapThroughButtonList(List<ColoredButton> buttons) {
    // If currentIndex >= 1, turn off previous button
    if (currentIndex >= 1) {
      buttons[currentIndex - 1].willBlink = false;
    }
    // Turn on current button
    buttons[currentIndex].willBlink = true;
    setState(() {
      // After 1 second turn off
      _updateColoredButtonState(buttons[currentIndex]);
    });

    // Turn on next button, if end of list terminate
    Future.delayed(Duration(milliseconds: currentIndex == 0 ? 500 : 1000), () {
      if (currentIndex < buttons.length) {
        _mapThroughButtonList(buttons);
        currentIndex++;
      } else if (currentIndex >= buttons.length) {
        currentIndex = 0;
      }
    });
  }

  Future<void> _updateColoredButtonState(ColoredButton button) {
    return Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        button.willBlink = false;
      });
    });
  }
}
