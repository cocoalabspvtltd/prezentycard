
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:prezentycardmodule/screens/homescreen.dart';
import 'package:prezentycardmodule/screens/mainscreen.dart';
import 'package:prezentycardmodule/screens/splashscreen.dart';
import 'package:prezentycardmodule/util/app_helper.dart';
import 'package:prezentycardmodule/util/notifications.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();





  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {

    runApp(MyApp());
  });
}



class MyApp extends StatelessWidget {

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return
      GetMaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            canvasColor: Color(0xfff2f6fa),
            //fontFamily: "Ubuntu",
            //Colors.white,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            // dividerTheme: DividerThemeData(thickness: 1,),
            appBarTheme: Theme.of(context)
                .appBarTheme
                .copyWith(systemOverlayStyle: SystemUiOverlayStyle.dark), colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo).copyWith(secondary: Colors.yellow)),
        routes: {
          // '/': (BuildContext context) => Test(),
          '/': (BuildContext context) => SplashScreen(),
          //  '/home': (BuildContext context) => HomeScreen(),
          '/home': (BuildContext context) => MainScreen(),
        //  '/notification'  :(BuildContext context) => NotificationScreen(),
          // '/createEventStart': (BuildContext context) => EventWizardMainScreen(),
        },
        initialRoute: '/',
      );
  }
}
