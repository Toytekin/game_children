import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/pages/game_home.dart';
import 'package:flutter_application_1/pages/score.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../constant/image_path.dart';

class HomeScreen extends StatefulWidget {
  UserModel userModel;
  HomeScreen({
    super.key,
    required this.userModel,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var random = Random();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        actions: [
          InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ScoreScreen(userModel: widget.userModel),
                ));
              },
              child: LottieBuilder.asset(ConstantLottie.instance.score))
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                  (route) => false);
            },
            icon: const Icon(Icons.exit_to_app)),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(widget.userModel.userMail),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset(
            ConstantLottie.instance.aslan,
            width: Get.width / 1.2,
            height: Get.width / 1.2,
          ),
          InkWell(
              onTap: () {
                var sayi = random.nextInt(6);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => GameHomeScreen(
                    userModel: widget.userModel,
                    sayi: sayi,
                  ),
                ));
              },
              child: LottieBuilder.asset(ConstantLottie.instance.buton))
        ],
      )),
    );
  }
}
