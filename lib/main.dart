import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa/helper/log_printer.dart';
import 'app/routes/app_pages.dart';
import 'app/services/local_store_config.dart';
import 'app/services/notification_manager.dart';
import 'appConfig.dart';
import 'firebase_options.dart';
import 'helper/helper_utils.dart';
import 'helper/language.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///    Initialize Firebase
  await Firebase.initializeApp(
    name: AppConfig.appName,
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await _setupApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_, child) => GetMaterialApp(
        textDirection: TextDirection.ltr,
        theme: ThemeData(
          ///  Set your desired App primary color
          primaryColor: Colors.green,
          primarySwatch: Colors.green,
        ),
        title: AppConfig.appName,
        debugShowCheckedModeBanner: false,

        ///  Routing Initialization
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,

        ///  Language Initialization
        translations: Languages(),
        locale: HelperUtils.locateLanguage(),
        fallbackLocale: HelperUtils.locateLanguage(),
      ),
      designSize: const Size(360, 800),
    );
  }
}

///  Initialization  Local Storage Hive, Firebase Notification
Future<void> _setupApp() async {
  // DependencyInjection.init();
  await HiveService.initHive();
  await HiveService.checkLoginStatus();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await NotificationManager().initialize();
  String? firebaseToken = "";


  if (Platform.isIOS) {
    // await FirebaseMessaging.instance.getAPNSToken();
    // firebaseToken = await FirebaseMessaging.instance.getToken();
  } else {
    firebaseToken = await FirebaseMessaging.instance.getToken();
  }

  if (firebaseToken != "" && firebaseToken!.isNotEmpty) {
    HiveService.deleteFirebaseToken();
    HiveService.setFirebaseToken(firebaseToken);
    HelperUtils.firebaseToken = (await HiveService.getFirebaseToken())!;
    Log.w(HelperUtils.firebaseToken);
  }
}
