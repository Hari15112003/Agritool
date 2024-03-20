import 'package:agritool/firebase_options.dart';
import 'package:agritool/language/lang.dart';
import 'package:agritool/authentication/pages/welcome_page.dart';
import 'package:agritool/language/langprovider.dart';
import 'package:agritool/provider/auth_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'shop/model/cart_model.dart';
import 'theme/colors/theme_data.dart';
import 'theme/provider/darktheme_provider.dart';
import 'package:flutter/services.dart';

Future main() async {
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
          create: (_) => AuthProvider(), // Return an instance of AuthProvider
        ),
        ChangeNotifierProvider(
          create: (_) => CartModel(), // Return an instance of AuthProvider
        ),
        ChangeNotifierProvider(create: (_) => themeChangeProvider),
        ChangeNotifierProvider(create: (_) => languageChangeProvider)
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, themeProvider, child) {
          return GetMaterialApp(
            translations: LocalString(),
            locale: const Locale(
              'en',
            ),
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(themeProvider.getDarkTheme, context),
            home: const WelcomeScreen(),
          );
        },
      ),
    );
  }
}

// TODO: jkedn
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: Payment());
//   }
// }

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // for initializing local storage
//   final appStorage = AppStorage();
//   await appStorage.initAppStorage();

//   runApp(
//     ProviderScope(
//       overrides: [
//         appStorageProvider.overrideWithValue(appStorage),
//       ],
//       child: const App(),
//     ),
//   );
// }
