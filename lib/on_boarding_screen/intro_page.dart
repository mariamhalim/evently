import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../login/widgets/costtum_Elevated_button.dart';
import '../providers/app_language_provider.dart';
import '../providers/app_theme_provider.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  // Controllers for switches
  final _themeController = ValueNotifier<bool>(false);
  final _languageController = ValueNotifier<bool>(
      false); // false = English, true = Arabic

  @override
  void initState() {
    super.initState();
    final themeProvider = context.read<AppThemeProvider>();
    final languageProvider = context.read<AppLanguageProvider>();

    // sync with providers
    _themeController.value = themeProvider.isDark;
    _languageController.value = languageProvider.appLanguage == 'ar';

    // listen to theme changes
    _themeController.addListener(() {
      themeProvider.toggleTheme();
    });

    // listen to language changes
    _languageController.addListener(() {
      if (_languageController.value) {
        languageProvider.changeLanguage('ar');
      } else {
        languageProvider.changeLanguage('en');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Theme
            .of(context)
            .scaffoldBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),

                Image.asset(
                  AppAssets.OB4,
                  width: width * 0.7,
                  height: height * 0.35,
                ),

                const SizedBox(height: 20),

                /// اللوجو
                Image.asset(AppAssets.logoOB, width: 140, height: 50),

                const SizedBox(height: 20),

                /// Title
                Text(
                  AppLocalizations.of(context)!.personalizeTitle,
                  style: AppStyles.bold20Blue,
                ),
                const SizedBox(height: 10),

                /// Subtitle
                Text(
                  AppLocalizations.of(context)!.personalizeSubtitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: height * 0.04),

                /// Language & Theme Options
                Column(
                  children: [
                    // Language Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.language,
                          style: AppStyles.bold16Blue,
                        ),
                        AdvancedSwitch(
                          controller: _languageController,
                          activeChild: const Text("🇪🇬", style: TextStyle(
                              fontSize: 22)),
                          inactiveChild: const Text("🇺🇸", style: TextStyle(
                              fontSize: 22)),
                          borderRadius: BorderRadius.circular(30),
                          width: 70,
                          height: 35,
                          activeColor: AppColors.blueColor,
                          inactiveColor: Colors.grey.shade400,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Theme Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.theme,
                          style: AppStyles.bold16Blue,
                        ),
                        AdvancedSwitch(
                          controller: _themeController,
                          activeChild: const Icon(Icons.dark_mode, color: Colors
                              .white),
                          inactiveChild: const Icon(
                              Icons.light_mode, color: Colors.white),
                          borderRadius: BorderRadius.circular(30),
                          width: 70,
                          height: 35,
                          activeColor: AppColors.blueColor,
                          inactiveColor: Colors.grey.shade400,
                        ),
                      ],
                    ),
                  ],
                ),

                const Spacer(),

                /// زرار Let’s Start
                SizedBox(
                  width: double.infinity,
                  child: CostumeElevatedButton(
                    hasIcon: true,
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.OnBoardingPage);
                    },
                    childIconWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: width * 0.02),
                        Text(AppLocalizations.of(context)!.letsStart,
                            style: AppStyles.MidWhite20),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
