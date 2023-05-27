import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant/image_path.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/pages/register.dart';
import 'package:flutter_application_1/pages/reset_password.dart';
import 'package:flutter_application_1/widget/login_lotti.dart';
import 'package:flutter_application_1/widget/textfild.dart';
import 'package:get/route_manager.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';

import 'models/user_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var mailController = TextEditingController();
  var passwordController = TextEditingController();

  var boxkisiDB = Hive.box<UserModel>('kisiDB');
  List<UserModel> tumKisiler = [];

  @override
  void initState() {
    super.initState();
    for (var element in boxkisiDB.values) {
      tumKisiler.add(element);
    }
    for (var element in tumKisiler) {
      debugPrint(element.userMail);
      debugPrint(element.userPassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const LoginLotti(),
              SizedBox(height: Get.height * 0.05),
              SbtTextfild(controller: mailController, hinttext: 'Mail'),
              SbtTextfild(controller: passwordController, hinttext: 'Şifre'),
              sifremiunuttum(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(width: Get.height * 0.05),
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        onPressed: () {
                          girisYapma();
                        },
                        child: const Text('Giriş')),
                  ),
                  SizedBox(width: Get.height * 0.05),
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            kaydolma();
                          },
                          child: const Text('Kaydol'))),
                  SizedBox(width: Get.height * 0.05),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Row sifremiunuttum() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const REsetPasswordScreen(),
              ));
            },
            child: const Text('Şifremi Unuttum'))
      ],
    );
  }

  void girisYapma() {
    if (mailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      for (var element in tumKisiler) {
        if (element.userMail == mailController.text.toString() &&
            element.userPassword == passwordController.text.toString()) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HomeScreen(userModel: element),
          ));
        }
      }
    } else {
      Get.snackbar('Uyarı', 'Lütfen Tüm Alanların Dolu Olduğuna Emin Olun',
          backgroundColor: Colors.redAccent,
          icon: LottieBuilder.asset(
            ConstantLottie.instance.aslan,
            height: 80,
            width: 80,
          ));
    }
  }

  void kaydolma() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const RegisterScreen(),
    ));
  }
}
