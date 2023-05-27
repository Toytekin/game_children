import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/sayi_model.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../constant/image_path.dart';

class GameHomeScreen extends StatefulWidget {
  UserModel userModel;
  int sayi;
  GameHomeScreen({
    super.key,
    required this.userModel,
    this.sayi = 0,
  });

  @override
  State<GameHomeScreen> createState() => _GameHomeScreenState();
}

class _GameHomeScreenState extends State<GameHomeScreen> {
  static List<SayiModel> sayilar = [
    SayiModel(sayi: 1, sayiYazi: "Bir"),
    SayiModel(sayi: 2, sayiYazi: "İki"),
    SayiModel(sayi: 3, sayiYazi: "Üç"),
    SayiModel(sayi: 4, sayiYazi: "Dört"),
    SayiModel(sayi: 5, sayiYazi: "Beş"),
    SayiModel(sayi: 6, sayiYazi: "Altı"),
  ];
  var random = Random();

  int can = 3;
  int score = 0;
  int randomSayi = 0;

  @override
  void initState() {
    super.initState();
    randomSayi = random.nextInt(6);
  }

  @override
  Widget build(BuildContext context) {
    var random = Random();
    sayilar.shuffle(random);
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.pinkAccent,
        title: Text(score.toString()),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(child: Text(can.toString())),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  color: Colors.white,
                  child: resimyolla(randomSayi),
                )),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: GridView.builder(
                    itemCount: sayilar.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // Sütun sayısı
                      mainAxisSpacing: 8.0, // Dikey aralık
                      crossAxisSpacing: 8.0, // Yatay aralık
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          if (sayilar[index].sayi.toString() ==
                              (randomSayi + 1).toString()) {
                            debugPrint('Doğru');
                            score = score + 10;
                            alertDiyalog(context);
                            randomSayi = random.nextInt(6);
                            setState(() {});
                          } else {
                            can -= 1;

                            if (can < 0) {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    HomeScreen(userModel: widget.userModel),
                              ));
                            }
                            setState(() {});
                            debugPrint('Yanlış');
                          }
                        },
                        child: Card(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              sayilar[index].sayi.toString(),
                              style: const TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                            Text(sayilar[index].sayiYazi)
                          ],
                        )),
                      );
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }

  sayiYazi(int sayi) {
    switch (sayi) {
      case 0:
        return "Bir";
      case 1:
        return "İki";
      case 2:
        return "Üç";
      case 3:
        return "Dört";
      case 4:
        return "Beş";
      case 5:
        return "Altı";

      default:
        "Bir";
    }
  }

  resimyolla(int sayi) {
    switch (sayi) {
      case 0:
        return LottieBuilder.asset(ConstantLottie.instance.bir);
      case 1:
        return LottieBuilder.asset(ConstantLottie.instance.iki);
      case 2:
        return LottieBuilder.asset(ConstantLottie.instance.uc);
      case 3:
        return LottieBuilder.asset(ConstantLottie.instance.dort);
      case 4:
        return LottieBuilder.asset(ConstantLottie.instance.bes);
      case 5:
        return LottieBuilder.asset(ConstantLottie.instance.alti);

      default:
        LottieBuilder.asset(ConstantLottie.instance.bir);
    }
  }

  void alertDiyalog(BuildContext context) {
    showDialog(
      barrierColor: Colors.tealAccent,
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Vücudumuzdaki hangi organ beynimize benzetilir? ',
                style: TextStyle(fontSize: 25),
              ),
              Padding(
                padding: EdgeInsets.only(top: Get.height / 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            score = score + 10;
                            setState(() {});
                          },
                          child: SizedBox(
                            height: Get.width * 0.2,
                            width: Get.width * 0.2,
                            child: Image.asset(ImageConstants.instance.ceviz),
                          ),
                        ),
                        const Text('CEVİZ')
                      ],
                    )),
                    const Expanded(child: SizedBox(width: 50)),
                    SizedBox(
                        child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            can -= 1;

                            if (can < 0) {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    HomeScreen(userModel: widget.userModel),
                              ));
                            } else {
                              Navigator.of(context).pop();
                            }
                            setState(() {});
                          },
                          child: SizedBox(
                            height: Get.width * 0.2,
                            width: Get.width * 0.2,
                            child: Image.asset(ImageConstants.instance.domat),
                          ),
                        ),
                        const Text('DOMATES')
                      ],
                    ))
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
