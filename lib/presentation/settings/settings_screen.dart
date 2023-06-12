import 'package:earnipay_task/app/widgets/app_bar.dart';
import 'package:earnipay_task/presentation/settings/about/about_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/theme/app_theme_provider.dart';
import '../../app/widgets/line_view.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeProvider>(
        builder: (context, AppThemeProvider themeNotifier, child) {
      return Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(context, themeNotifier),
      );
    });
  }

  CustomAppBar _buildAppBar() {
    return const CustomAppBar(
      title: "Settings",
    );
  }

  Widget _buildBody(BuildContext context, AppThemeProvider appThemeProvider) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildThemeView("Theme mode", appThemeProvider, context),
                // GestureDetector(
                //     behavior: HitTestBehavior.opaque,
                //     onTap: () => _navigateLanguage(context),
                //     child: _buildRowView(tr("app_language"), "", true, true)),
                GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _navigateAbout(context),
                    child: _buildRowView("About", "", true, true)),
                _buildRowView("App version", "1.0.0", false, false),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThemeView(
      String key, AppThemeProvider appThemeProvider, BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(),
      elevation: 0,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      key,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  CupertinoSwitch(
                      value: appThemeProvider.isDark,
                      onChanged: (value) {
                        appThemeProvider.isDark = value;
                      })
                ],
              ),
            ),
            const LineView()
          ],
        ),
      ),
    );
  }

  Widget _buildRowView(
      String key, String value, bool showDivider, bool showArrow) {
    return Card(
      shape: const RoundedRectangleBorder(),
      elevation: 0,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      key,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        value,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                        softWrap: false,
                        overflow: TextOverflow.clip,
                        maxLines: 2,
                      ),
                      if (showArrow)
                        IconButton(
                          iconSize: 18,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                          ),
                          onPressed: () {
                          },
                        ),
                    ],
                  )
                ],
              ),
            ),
            if (showDivider) const LineView()
          ],
        ),
      ),
    );
  }

  _navigateAbout(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) {
          return const AboutScreen();
        }));
  }
}
