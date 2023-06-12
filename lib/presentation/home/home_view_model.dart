import 'package:earnipay_task/presentation/photos/photo_list_view.dart';
import 'package:earnipay_task/presentation/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  List<Widget> pages = <Widget>[
    const PhotoListView(),
    const SettingsScreen()
  ];

  int selectedIndex = 0;

  void onItemTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  Widget getPages() => pages.elementAt(selectedIndex);
}
