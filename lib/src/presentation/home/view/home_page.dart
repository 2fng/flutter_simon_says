import 'dart:math';

import 'package:flutter/material.dart';

import '../../../core/utils/constants.dart';
import '../../../domain/entities/colored_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  bool isCorrectPlay = true;
  bool isPlaying = false;
  List<ColoredButton> simonsButtons = [];
  var playedButtons = [];
  final greenButton = ColoredButton(color: ButtonColor.green, willBlink: false);

  final yellowButton =
      ColoredButton(color: ButtonColor.yellow, willBlink: false);

  final redButton = ColoredButton(color: ButtonColor.red, willBlink: false);

  final blueButton = ColoredButton(color: ButtonColor.blue, willBlink: false);

  @override
  Widget build(BuildContext context) {
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
            child: Center(
              child: Text(
                '${simonsButtons.length}',
                style: const TextStyle(
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
    var buttons = [greenButton, redButton, yellowButton, blueButton];
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
          _buildPlayButton(buttons)
        ],
      ),
    );
  }

  ElevatedButton _buildPlayButton(List<ColoredButton> buttons) {
    return ElevatedButton(
        onPressed: currentIndex != 0
            ? null
            : () {
                isPlaying = true;
                simonsButtons = [];
                simonsButtons
                    .add(buttons[Random().nextInt(buttons.length - 1)]);
                Future.delayed(const Duration(milliseconds: 250), () {
                  _mapThroughButtonList();
                });
              },
        style: ElevatedButton.styleFrom(
            backgroundColor: isPlaying ? Colors.black : Colors.white),
        child: const Text(
          'PLAY',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ));
  }

  ElevatedButton _buildColoredButton(ColoredButton button) {
    final color = button.color.color;
    final fadedColor = button.color.color.withAlpha(150);
    var buttons = [greenButton, redButton, yellowButton, blueButton];
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: button.willBlink ? color : fadedColor,
          fixedSize: const Size(buttonWidth, buttonHeight)),
      onPressed: () {
        playedButtons.add(button);
        setState(() {
          if (simonsButtons[playedButtons.length - 1] != button) {
            print('Game over');
            isPlaying = false;
            currentIndex = 0;
            playedButtons = [];
          } else if (simonsButtons.length == playedButtons.length) {
            simonsButtons[playedButtons.length - 1].willBlink = false;
            simonsButtons.add(buttons[Random().nextInt(buttons.length - 1)]);
            currentIndex = 0;
            playedButtons = [];
            print('Add new button!');
            Future.delayed(const Duration(milliseconds: 500), () {
              _mapThroughButtonList();
            });
          } else {
            print('Correct!');
          }
        });
      },
      child: null,
    );
  }

  void _mapThroughButtonList() {
    // If currentIndex >= 1, turn off previous button
    if (currentIndex >= 1) {
      simonsButtons[currentIndex - 1].willBlink = false;
    }
    // Turn on current button
    simonsButtons[currentIndex].willBlink = true;
    setState(() {
      // After 1 second turn off
      _updateColoredButtonState(simonsButtons[currentIndex]);
    });

    // Turn on next button, if end of list terminate
    Future.delayed(Duration(milliseconds: currentIndex == 0 ? 500 : 750), () {
      if (currentIndex < simonsButtons.length - 1) {
        currentIndex++;
        _mapThroughButtonList();
      } else if (currentIndex >= simonsButtons.length) {
        currentIndex = 0;
      }
    });
  }

  _updateColoredButtonState(ColoredButton button) {
    return Future.delayed(const Duration(milliseconds: 250), () {
      setState(() {
        button.willBlink = false;
      });
    });
  }
}
