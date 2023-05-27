import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../constant/image_path.dart';

class LoginLotti extends StatelessWidget {
  const LoginLotti({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LottieBuilder.asset(
      ConstantLottie.instance.log2,
      width: Get.width / 1.2,
      height: Get.width / 1.2,
    );
  }
}
