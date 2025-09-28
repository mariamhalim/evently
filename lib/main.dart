import 'package:evently/on_boarding_screen/intro_page.dart';
import 'package:evently/providers/app_language_provider.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/register/register_screen.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home/home_screen.dart';
import 'login/login_screen.dart';
import 'on_boarding_screen/intro_screen.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppLanguageProvider()),
        ChangeNotifierProvider(create: (_) => AppThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppLanguageProvider, AppThemeProvider>(
      builder: (context, languageProvider, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.IntroPage,
          routes: {
            AppRoutes.IntroPage: (context) => IntroPage(),
            AppRoutes.OnBoardingPage: (context) => OnBoardingScreen(),
            AppRoutes.RouteHomeScreen: (context) => HomeScreen(),
            AppRoutes.LoginRouteScreen: (context) => LoginScreen(),
            AppRoutes.RegisterRouteScreen: (context) => RegisterScreen(),
          },
          locale: Locale(languageProvider.appLanguage ?? 'en'),
          // fallback
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.DarkTheme,
          themeMode: themeProvider.appTheme ?? ThemeMode.light, // fallback
        );
      },
    );
  }
}
