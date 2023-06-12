// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'app/di/injector.dart';
import 'app/theme/app_theme.dart';
import 'app/theme/app_theme_provider.dart';
import 'app/utils/route_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const RootApp());
  });
}


class RootApp extends StatelessWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<AppThemeProvider>(context);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AppThemeProvider()),
        ],
        child: Consumer<AppThemeProvider>(
            builder: (context, AppThemeProvider themeNotifier, child) {
              return MaterialApp(
                title: "EarniPayTask",
                debugShowCheckedModeBanner: false,
                theme: themeNotifier.isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                onGenerateRoute: RouteGenerator.getRoute,
                initialRoute: Routes.splashRoute,
              );
            }));
  }
}
