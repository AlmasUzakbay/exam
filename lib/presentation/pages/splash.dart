import 'package:flutter/material.dart';
import 'package:flutter_education/presentation/ColorConst/ColorConst.dart';
import 'package:flutter_education/presentation/pages/LogIn.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(milliseconds: 5000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [ColorConst.primarycolor, ColorConst.endcolor],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/json/basketball.json'),
                SizedBox(height: 20),
                Text(
                  'Education',
                  style: TextStyle(
                    color: ColorConst.aftercolor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                CircularProgressIndicator(color: ColorConst.aftercolor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
