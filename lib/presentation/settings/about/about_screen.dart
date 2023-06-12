import 'dart:developer';

import 'package:earnipay_task/app/utils/assets_manager.dart';
import 'package:earnipay_task/app/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/theme/app_color.dart';

class AboutScreen extends StatelessWidget {
  static const route = '/about';

  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  CustomAppBarWithBack _buildAppBar() {
    return const CustomAppBarWithBack(title: "About");
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          elevation: 8,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(ImageAssets.afolabiImage),
                  const SizedBox(height: 8),
                  const Text("Mr.Odurinde Afolabi",
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                  const SizedBox(height: 8),
                  const Text("Mobile Developer"),
                  const SizedBox(height: 8),
                  const Text(
                    "Developed By @odurinde afolabi",
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                      onTap: (){
                        _launchUrl(Uri.parse("https://github.com/OdurindeAfolabi"));
                      },
                      child: Text(("https://github.com/OdurindeAfolabi"),
                          style: TextStyle(
                              color: AppColor.GreenCircle,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline
                          ))),
                  const SizedBox(height: 8),
                  InkWell(
                      onTap: (){
                        _launchUrl(Uri.parse("https://www.linkedin.com/in/odurindeafolabi/"));
                      },
                      child: Text(("https://www.linkedin.com/in/odurindeafolabi/"),
                          style: TextStyle(
                              color: AppColor.GreenCircle,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline
                          ))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(url) async {
    if (await canLaunchUrl(url)){
      await launchUrl(url,mode: LaunchMode.inAppWebView);
    }
    else {
      log("Can't launch url");
    }
  }
}
