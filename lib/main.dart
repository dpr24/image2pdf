import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:image2pdf/bloc_provider.dart';
import 'package:image2pdf/data/constants/app_colors.dart';
import 'package:image2pdf/data/constants/app_strings.dart';
import 'package:image2pdf/screens/splash/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppBlocProvider.getAppBlocProviders(),
      child: GetMaterialApp(
        title: AppStrings.appname,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: appColors.appDarkColor),
            useMaterial3: true,
            scaffoldBackgroundColor: appColors.appDarkColor),
        home: const Splash(),
      ),
    );
  }
}
