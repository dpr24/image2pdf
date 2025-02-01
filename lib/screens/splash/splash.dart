import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image2pdf/data/constants/app_colors.dart';
import 'package:image2pdf/data/constants/app_images.dart';
import 'package:image2pdf/screens/home/home_screen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Get.offAll(HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.appDarkColor,
      body: Center(
        child: Image.asset(AppImages.appLogoPng),
      ),
    );
  }
}
