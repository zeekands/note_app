import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:localstorage/localstorage.dart';
import 'package:note_app/app/const/colors.dart';

import 'app/data/admin_model.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/notification_api.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('id_ID', null);
  NotifictionApi.init();
  tz.initializeTimeZones();
  final LocalStorage storage = LocalStorage('admin.json');
  var isLogin = false;
  await storage.ready.then((value) {
    if (storage.getItem('admin') == null) {
      isLogin = false;
    } else {
      final admin = AdminModel.fromJson(storage.getItem('admin'));
      if (admin.isLogin ?? false) {
        isLogin = true;
      }
    }
  });

  runApp(
    GetMaterialApp(
      title: "Notes App by Zeekands",
      initialRoute: isLogin ? Routes.HOME : AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Poppins",
        backgroundColor: mainBlack,
        appBarTheme: const AppBarTheme(
          backgroundColor: mainBlack,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        scaffoldBackgroundColor: mainBlack,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.blueGrey,
            shape: const StadiumBorder(),
            maximumSize: const Size(double.infinity, 48),
            minimumSize: const Size(double.infinity, 48),
          ),
        ),
      ),
      themeMode: ThemeMode.dark,
    ),
  );
}
