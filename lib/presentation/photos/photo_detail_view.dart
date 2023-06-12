import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:earnipay_task/app/theme/app_color.dart';
import 'package:earnipay_task/app/utils/extension/string_methods.dart';
import 'package:earnipay_task/app/utils/size_config.dart';
import 'package:earnipay_task/app/widgets/app_bar.dart';
import 'package:earnipay_task/data/model/remote/PhotoApiResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/utils/assets_manager.dart';
import '../../app/utils/date_grouping.dart';
class PhotoDetailView extends StatelessWidget {
  final PhotoApiResponse photoDetails;
  const PhotoDetailView({Key? key, required this.photoDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.initializeSize(context);
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: ListView(
          children: [
            Center(
              child: CachedNetworkImage(
                imageUrl: photoDetails.urls?.smallS3 ?? "",
                imageBuilder: (context, imageProvider) => Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover))),
                placeholder: (context, url) => const SizedBox(
                    height: 50,
                    width: 50,
                    child: CupertinoActivityIndicator()),
                errorWidget: (context, url, error) => Image.asset(
                  ImageAssets.photoErrorImage,
                ),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(30)),
            Card(
              shape: const RoundedRectangleBorder(),
              elevation: 0,
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Description",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            (photoDetails.description ?? photoDetails.altDescription ?? "A random photo"),
                            textAlign: TextAlign.justify,
                            maxLines: 10,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(30)),
            const Text("Additional information"),
            SizedBox(height: getProportionateScreenHeight(20)),
            Card(
              shape: const RoundedRectangleBorder(),
              elevation: 0,
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Row(
                                children: [
                                  Text(
                                    "Author",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 4,),
                                  Icon(Icons.person_pin,size: 16,)
                                ],
                              ),
                              Text(
                                (photoDetails.user?.name ?? photoDetails.user?.username ?? "").addOverFlow,
                                textAlign: TextAlign.justify,
                                style: const TextStyle(fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          const SizedBox(height: 8,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "Likes",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(width: 4,),
                                  Icon(Icons.favorite,color: AppColor.Red,size: 16,)
                                ],
                              ),
                              Text(
                                ("${photoDetails.likes ?? 0}").addOverFlow,
                                textAlign: TextAlign.justify,
                                style: const TextStyle(fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          const SizedBox(height: 8,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Row(
                                children: [
                                  Text(
                                    "Uploaded on",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 4,),
                                  Icon(Icons.calendar_month_outlined,size: 16,)
                                ],
                              ),
                              Text(
                                specialDateTimeFormat(photoDetails.createdAt ?? DateTime.now().toIso8601String()),
                                textAlign: TextAlign.justify,
                                style: const TextStyle(fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          const SizedBox(height: 8,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Row(
                                children: [
                                  Text(
                                    "Author location",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 4,),
                                  Icon(Icons.location_on_outlined,size: 16,)
                                ],
                              ),
                              Text(
                                (photoDetails.user?.location ??  "Nil").addOverFlow,
                                textAlign: TextAlign.justify,
                                style: const TextStyle(fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(30)),
            const Text("Useful links"),
            SizedBox(height: getProportionateScreenHeight(20)),
            Card(
              shape: const RoundedRectangleBorder(),
              elevation: 0,
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Row(
                                children: [
                                  Text(
                                    "Download link",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 4,),
                                  Icon(Icons.cloud_download_outlined,size: 16,)
                                ],
                              ),
                              const SizedBox(width: 10,),
                              Flexible(
                                child: InkWell(
                                    onTap: (){
                                      _launchUrl(Uri.parse(photoDetails.links?.downloadLocation ?? "www.google.com"));
                                    },
                                    child: Text((photoDetails.links?.downloadLocation ?? "").addOverFlow,
                                        style: TextStyle(
                                            color: AppColor.GreenCircle,
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w500,
                                            decoration: TextDecoration.underline
                                        ))),
                              )
                            ],
                          ),
                          const SizedBox(height: 8,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "User portfolio page",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(width: 4,),
                                  Icon(Icons.webhook_outlined,color: AppColor.Red,size: 16,)
                                ],
                              ),
                              const SizedBox(width: 10,),
                              Flexible(
                                child: InkWell(
                                    onTap: (){
                                      _launchUrl(Uri.parse(photoDetails.user?.portfolioUrl ?? "www.google.com"));
                                    },
                                    child: Text((photoDetails.user?.portfolioUrl ?? "").addOverFlow,
                                        style: TextStyle(
                                            color: AppColor.GreenCircle,
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w500,
                                            decoration: TextDecoration.underline
                                        ))),
                              )
                            ],
                          ),
                          const SizedBox(height: 8,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Row(
                                children: [
                                  Text(
                                    "User unsplash page",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 4,),
                                  Icon(Icons.supervised_user_circle_outlined,size: 16,)
                                ],
                              ),
                              Flexible(
                                child: FittedBox(
                                  child: InkWell(
                                    onTap: (){
                                        _launchUrl(Uri.parse(photoDetails.user?.links?.self ?? "www.google.com"));
                                      },
                                    child: Text((photoDetails.user?.links?.self ?? "").addOverFlow,
                                          style: TextStyle(
                                              color: AppColor.GreenCircle,
                                              fontWeight: FontWeight.w500,
                                              overflow: TextOverflow.ellipsis,
                                              decoration: TextDecoration.underline
                                          )),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  CustomAppBarWithBack _buildAppBar() {
    return const CustomAppBarWithBack(title: "Photo detail");
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
