import 'package:agritool/firebase/firebase_options.dart';
import 'package:agritool/language/lang.dart';
import 'package:agritool/authentication/pages/welcome_page.dart';
import 'package:agritool/language/langprovider.dart';
import 'package:agritool/provider/auth_provider.dart';
import 'package:agritool/provider/internet_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'shop/model/cart_model.dart';
import 'theme/colors/theme_data.dart';
import 'theme/provider/darktheme_provider.dart';
import 'package:flutter/services.dart';

Future main() async {
  // Intializing the app Orientation
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();
  LanguageProvider languageChangeProvider = LanguageProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePreferences.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CartModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => themeChangeProvider,
        ),
        ChangeNotifierProvider(
          create: (_) => languageChangeProvider,
        ),
        ChangeNotifierProvider(
          create: ((context) => InternetProvider()),
        ),
        ChangeNotifierProvider(
          create: ((context) => AuthProvider()),
        ),
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, themeProvider, child) {
          return GetMaterialApp(
            translations: LocalString(),
            locale: const Locale(
              'en',
            ),
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(
              themeProvider.getDarkTheme,
              context,
            ),
            home: const WelcomeScreen(),
          );
        },
      ),
    );
  }
}
