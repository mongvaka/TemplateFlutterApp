import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ice_fac_mobile/Shared/LocalStorage/local_storage.dart';
import 'package:ice_fac_mobile/Utils/app_setting.dart';
import 'package:ice_fac_mobile/home_page.dart';
import 'package:provider/provider.dart';
import 'Page/Login/login_page.dart';
import 'package:ice_fac_mobile/Page/Login/login_page.dart';

import 'Shared/Navigator/navigator.dart';

void main(List<String> arguments) async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: [Locale('en'), Locale('th')],
      path: 'assets/lang',
      fallbackLocale: Locale('en'),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  LocalStorageCustom localStorageCustom = new LocalStorageCustom();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => Appsetting())],
      child: MaterialApp(
        navigatorKey: NavigationService.navigatorKey,
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SafeArea(
          child: localStorageCustom.isLoggedIn() ? HomePage() : LoginPage(),
        ),
      ),
    );
  }
}
