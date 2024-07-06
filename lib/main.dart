// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:upgrader/upgrader.dart';

import 'Config/my_upgrader.dart';
import 'Controller/ScreenController/app_controller.dart';
import 'Locale/language_cubit.dart';
import 'Locale/translation.dart';
import 'Theme/theme.dart';
import 'Utils/utils.dart';
import 'View/Splash/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppController.initializeControllers();
  await Firebase.initializeApp().whenComplete(() {
    logger.i('completed');
  });
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(
    OverlaySupport.global(
      child: UpgradeAlert(
        upgrader: MyUpgrader(),
        child: Phoenix(
          child: MultiBlocProvider(
            providers: [
              BlocProvider<LanguageCubit>(
                create: (context) => LanguageCubit(),
              ),
            ],
            child: const MyApp(),
          ),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //BlocBuilder<LanguageCubit, Locale>(builder: (_, locale)
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, Locale>(builder: (_, locale) {
      return GetMaterialApp(
        translations: Translation(),
        locale: const Locale(
            'en', 'US'), // translations will be displayed in that locale
        fallbackLocale: const Locale('en', 'US'),
        debugShowCheckedModeBanner: false,
        builder: (context, child) => ResponsiveBreakpoints(breakpoints: const [
          Breakpoint(start: 0, end: 480, name: MOBILE),
          Breakpoint(start: 481, end: 1200, name: TABLET),
          Breakpoint(start: 1201, end: double.infinity, name: DESKTOP),
        ], child: child!),
        //     ResponsiveWrapper.builder(
        //   child,
        //   minWidth: 320,
        //   breakpoints: [
        //     const Breakpoint.autoScaleDown(250, name: MOBILE),
        //     const ResponsiveBreakpoint.resize(480, name: 'TABLET_S'),
        //     const ResponsiveBreakpoint.resize(850, name: 'TABLET_L'),
        //     const ResponsiveBreakpoint.resize(1024, name: DESKTOP),
        //   ],
        //   useShortestSide: true,
        // ),
        theme: appTheme,
        home: const SplashScreen(),
      );
    });
  }
}
