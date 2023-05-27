import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant/image_path.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/widget/textfild.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';

import '../models/user_model.dart';

class REsetPasswordScreen extends StatefulWidget {
  const REsetPasswordScreen({super.key});

  @override
  State<REsetPasswordScreen> createState() => _REsetPasswordScreenState();
}

class _REsetPasswordScreenState extends State<REsetPasswordScreen> {
  var nameController = TextEditingController();
  var mailController = TextEditingController();
  var newpasswordController = TextEditingController();
  var newpasswordRepeatController = TextEditingController();

  var boxkisiDB = Hive.box<UserModel>('kisiDB');
  List<UserModel> tumKisiler = [];

  @override
  void initState() {
    super.initState();
    for (var element in boxkisiDB.values) {
      tumKisiler.add(element);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LottieBuilder.asset(ConstantLottie.instance.reset),
              SbtTextfild(
                  controller: nameController, hinttext: 'Kullanıcı adı'),
              SbtTextfild(controller: mailController, hinttext: 'Mailiniz'),
              SbtTextfild(
                  controller: newpasswordController, hinttext: 'Yeni Şifreniz'),
              SbtTextfild(
                  controller: newpasswordRepeatController,
                  hinttext: 'Yeni Şifre Tekrarı'),
              ElevatedButton(
                  onPressed: () {
                    kaydolma();
                  },
                  child: const Text('Şifreyi Yenile'))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> kaydolma() async {
    for (var element in tumKisiler) {
      if (element.userMail == mailController.text.toString()) {
        if (newpasswordController.text.toString() ==
            newpasswordRepeatController.text.toString()) {
          var newUser = UserModel(
              userID: element.userID,
              userName: element.userName,
              userMail: element.userMail,
              userPassword: newpasswordController.text.toString());
          await boxkisiDB.put(element.userID, newUser);
          // ignore: use_build_context_synchronously
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ));
        } else {
          Get.snackbar('Uyarı', 'Şifreleri aynı girdiğine emin ol');
        }
      }
    }
  }
}
