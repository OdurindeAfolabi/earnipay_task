import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_view_model.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            body: viewModel.getPages(),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.photo), label: "Photos"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: "settings"),
              ],
              onTap: viewModel.onItemTapped,
              currentIndex: viewModel.selectedIndex,
            ),
          );
        });
  }
}
