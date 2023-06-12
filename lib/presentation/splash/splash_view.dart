import 'dart:async';

import 'package:earnipay_task/app/theme/app_color.dart';
import 'package:earnipay_task/app/utils/size_config.dart';
import 'package:flutter/material.dart';

import '../../app/utils/assets_manager.dart';
import '../../app/utils/route_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: 3), _goNext);
  }

  _goNext() {
    Navigator.pushReplacementNamed(
        context, Routes.homeRoute);
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.initializeSize(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColor.White,
        body: Center(
          child: Image(
            height: getProportionateScreenHeight(100),
            width: getProportionateScreenWidth(100),
            image: const AssetImage(ImageAssets.earniPayLogo),
          ),
        ),
      ),
    );
  }
}
