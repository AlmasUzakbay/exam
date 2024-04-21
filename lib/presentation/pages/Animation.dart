import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_education/presentation/ColorConst/ColorConst.dart';

class SportsAnimationPage extends StatefulWidget {
  @override
  _SportsAnimationPageState createState() => _SportsAnimationPageState();
}

class _SportsAnimationPageState extends State<SportsAnimationPage>
    with TickerProviderStateMixin {
  late AnimationController _exerciseController;
  late AnimationController _backgroundColorController;
  late Animation _backgroundColor;

  @override
  void initState() {
    super.initState();

    _exerciseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _backgroundColorController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();

    _backgroundColor =
        ColorTween(begin: ColorConst.aftercolor, end: ColorConst.thirdcolor)
            .animate(_backgroundColorController);
  }

  @override
  void dispose() {
    _exerciseController.dispose();
    _backgroundColorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _backgroundColor,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: _backgroundColor.value,
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      JumpingPerson(animation: _exerciseController),
                      CyclingPerson(animation: _exerciseController),
                      WeightLiftingPerson(animation: _exerciseController),
                    ],
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: ColorConst.aftercolor,
                      backgroundColor: ColorConst.primarycolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      if (_exerciseController.isAnimating) {
                        _exerciseController.stop();
                      } else {
                        _exerciseController.repeat(reverse: true);
                      }
                    },
                    child: Text(_exerciseController.isAnimating
                        ? 'Stop Animation'
                        : 'Start Animation'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class JumpingPerson extends AnimatedWidget {
  JumpingPerson({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return Transform.translate(
      offset: Offset(0, -30 * animation.value),
      child:
          Icon(Icons.directions_run, size: 50, color: ColorConst.primarycolor),
    );
  }
}

class CyclingPerson extends AnimatedWidget {
  CyclingPerson({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return Transform.rotate(
      angle: animation.value * 2 * math.pi,
      child:
          Icon(Icons.directions_bike, size: 50, color: ColorConst.primarycolor),
    );
  }
}

class WeightLiftingPerson extends AnimatedWidget {
  WeightLiftingPerson({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return Transform.scale(
      scale: 1 + animation.value,
      child:
          Icon(Icons.fitness_center, size: 50, color: ColorConst.primarycolor),
    );
  }
}
