import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shortnews/DefaultFirebaseOptions.dart';
import 'package:shortnews/localization/locale_constants.dart';
import 'package:shortnews/localization/localizations_delegate.dart';
import 'package:shortnews/view/page_routes/route_generate.dart';
import 'package:shortnews/view/page_routes/routes.dart';
import 'package:shortnews/view/uitl/app_string.dart';
import 'package:shortnews/view/uitl/apphelper.dart';

import 'package:shortnews/view/uitl/theme/dark_theme.dart';
import 'package:shortnews/view/uitl/theme/light_theme.dart';
import 'package:shortnews/view_model/provider/ThemeProvider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:translator/translator.dart';

late SharedPreferences sharedPref;
main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  
     
  
//  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  sharedPref = await SharedPreferences.getInstance();
  sharedPref.setString(AppStringFile.fromLanguageCode, 'en');
  sharedPref.setString(AppStringFile.toLanguageCode, 'en');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  
   static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(newLocale);
  }


  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _bundleId = 'Loading...';
   Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
    _getPackageInfo();
  }
   @override
  void didChangeDependencies() async {
    getLocale().then((locale) {
      _locale = locale;
    });
    super.didChangeDependencies();
  }

  Future<void> _getPackageInfo() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      setState(() 
      {
        _bundleId = packageInfo.packageName;
        print("kfghkljfgh  ${_bundleId}");
      });
    } catch (e) {
      print('Error getting package info: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType)
     {
      return StreamProvider<InternetConnectionStatus>(
        initialData: InternetConnectionStatus.connected,
        create: (_) {
          return InternetConnectionChecker().onStatusChange;
        },
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<DarkThemeProvider>(
                create: (_) => DarkThemeProvider()),
          ],
          child: Consumer<DarkThemeProvider>(builder: (context, value, child) {
            return GetMaterialApp(
              builder: (context, child) {
                AppHelper.themelight = !value.darkTheme;

                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: child!,
                );
              },
              title: 'Coach By App',
              debugShowCheckedModeBanner: false,
              initialRoute: Routes.splashScreen,
              onGenerateRoute: RouteGenerator.generateRoute,
              theme: value.darkTheme ? lighttheme : darktheme,
                supportedLocales: [
                  Locale('en', ''), // english
                  Locale('hi', ''), // swedish
                ],
                localizationsDelegates: [
                  AppLocalizationsDelegate(),
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                localeResolutionCallback: (locale, supportedLocales) {
                  for (var supportedLocale in supportedLocales) {
                    if (supportedLocale.languageCode == locale?.languageCode &&
                        supportedLocale.countryCode == locale?.countryCode) 
                        {
                           return supportedLocale;
                         }
                  }
                  return supportedLocales.first;
                });
            
          }),
        ),
      );
    });
  }
}

const defaultInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(16)),
  borderSide: BorderSide(
    color: Color(0xFFDEE3F2),
    width: 1,
  ),
);
