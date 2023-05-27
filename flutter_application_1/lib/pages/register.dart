import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant/image_path.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/widget/textfild.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var mailController = TextEditingController();
  var passworController = TextEditingController();
  var passworRepeatController = TextEditingController();

  var adController = TextEditingController();

  //Veri tabanını çağır
  var boxkisiDB = Hive.box<UserModel>('kisiDB');
  List<UserModel> tumKisiler = [];
  bool kisiVerYok = false;

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
      backgroundColor: Colors.cyanAccent,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              LottieBuilder.asset(ConstantLottie.instance.aslan),
              SbtTextfild(controller: adController, hinttext: 'Adınız'),
              SbtTextfild(controller: mailController, hinttext: 'Mailiniz'),
              SbtTextfild(controller: passworController, hinttext: 'Şifre'),
              SbtTextfild(
                  controller: passworRepeatController,
                  hinttext: 'Şifre Tekrarı'),
              ElevatedButton(
                  onPressed: () {
                    for (var element in tumKisiler) {
                      if (mailController.text.toString() == element.userMail) {
                        kisiVerYok = true;
                      }
                    }
                    kisiKaydet();
                  },
                  child: const Text('Kaydet'))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> kisiKaydet() async {
    String userID = const Uuid().v1();
    setState(() {});

    if (kisiVerYok == false) {
      if (mailController.text.isNotEmpty ||
          adController.text.isNotEmpty ||
          passworRepeatController.text.isNotEmpty ||
          passworController.text.isNotEmpty &&
              passworController.text == passworRepeatController.text) {
        var eklenecekUser = UserModel(
          userID: userID,
          userName: adController.text.toString(),
          userMail: mailController.text.toString(),
          userPassword: passworController.text.toString(),
        );

        await boxkisiDB.put(userID, eklenecekUser);
        // ignore: use_build_context_synchronously
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomeScreen(userModel: eklenecekUser),
        ));
      } else {
        Get.snackbar('Uyarı', 'Tüm alanları doldurduktan sonra tekrar dene');
      }
    } else {
      Get.snackbar('Uyarı',
          'Bir Mail ile Kimlik numarası ile sadece bir kere kaydolabilirsiniz.',
          backgroundColor: Colors.orange);
    }
  }
}
