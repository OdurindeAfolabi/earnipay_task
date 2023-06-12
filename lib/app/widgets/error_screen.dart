import 'package:earnipay_task/app/theme/app_color.dart';
import 'package:earnipay_task/app/utils/assets_manager.dart';
import 'package:earnipay_task/app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ErrorScreen extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onPressed;
  const ErrorScreen({Key? key, required this.errorMessage, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              ImageAssets.errorImage,
              width: SizeConfig.screenWidth / 2.5,
              color: AppColor.Red.withOpacity(0.6),
            ),
            const SizedBox(height: 8,),
            Text(errorMessage),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: onPressed,
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(2.0),
                backgroundColor: MaterialStateProperty.all<Color>(
                  AppColor.White,
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(
                      color: AppColor.GreenCircle,
                    ),
                  ),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 10.0,
                ),
                child: Text(
                  "Retry",
                  style: TextStyle(
                    color: AppColor.GreenCircle,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}