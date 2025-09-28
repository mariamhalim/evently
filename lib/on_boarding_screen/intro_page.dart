import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../login/widgets/costtum_e=button.dart';
import '../providers/app_language_provider.dart';
import '../providers/app_theme_provider.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Theme.of(
          context,
        ).scaffoldBackgroundColor, // يتغير حسب الثيم
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
                        Row(
                          children: [
                            IconButton(
                              icon: const Text(
                                "🇺🇸",
                                style: TextStyle(fontSize: 24),
                              ),
                              onPressed: () =>
                                  languageProvider.changeLanguage('en'),
                            ),
                            IconButton(
                              icon: const Text(
                                "🇪🇬",
                                style: TextStyle(fontSize: 24),
                              ),
                              onPressed: () =>
                                  languageProvider.changeLanguage('ar'),
                            ),
                          ],
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
                        Switch(
                          value: themeProvider.isDark,
                          activeColor: AppColors.blueColor, // اللون لما يكون ON
                          onChanged: (isDark) {
                            themeProvider.toggleTheme();
                          },
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
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.OnBoardingPage);
                    },
                    text: AppLocalizations.of(context)!.letsStart,
                    iconName: const SizedBox(),
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
