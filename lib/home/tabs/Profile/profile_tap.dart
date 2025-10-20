import 'package:evently/home/tabs/Profile/language/language_bottom_sheet.dart';
import 'package:evently/home/tabs/Profile/theme/theme_bottom_sheet.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/login/widgets/costtum_Elevated_button.dart';
import 'package:evently/providers/app_language_provider.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/app_theme_provider.dart';
import '../../../providers/user_provider.dart';

class ProfileTap extends StatefulWidget {
  @override
  State<ProfileTap> createState() => _ProfileTapState();
}

class _ProfileTapState extends State<ProfileTap> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var ThemeProvider = Provider.of<AppThemeProvider>(context);
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    // TODO: implement build
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.blueColor,
          toolbarHeight: height * 0.18,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Image(
                image: AssetImage(AppAssets.route),
                height: 124,
                width: 124,
              ),
              SizedBox(width: width * 0.03),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userProvider.currentUser!.name,
                    style: AppStyles.bold24Wight,
                  ), Text(
                    userProvider.currentUser!.email,
                    style: AppStyles.MidWhite20,
                  ),
                ],
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            vertical: height * 0.02,
            horizontal: width * 0.04,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppLocalizations.of(context)!.language,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              InkWell(
                onTap: () {
                  showLanguageBottomSheet();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: height * 0.02),
                  padding: EdgeInsets.symmetric(
                    vertical: height * 0.01,
                    horizontal: width * 0.04,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.blueColor, width: 2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        languageProvider.appLanguage == 'en'
                            ? AppLocalizations.of(context)!.english
                            : AppLocalizations.of(context)!.arabic,
                        style: AppStyles.bold20Blue,
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: AppColors.blueColor,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                AppLocalizations.of(context)!.theme,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              InkWell(
                onTap: () {
                  showThemeBottomSheet();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: height * 0.02),
                  padding: EdgeInsets.symmetric(
                    vertical: height * 0.01,
                    horizontal: width * 0.04,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.blueColor, width: 2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ThemeProvider.appTheme == ThemeMode.dark
                            ? AppLocalizations.of(context)!.dark
                            : AppLocalizations.of(context)!.light,
                        style: AppStyles.bold20Blue,
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: AppColors.blueColor,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: height * 0.01),
                child: CostumeElevatedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutes.LoginRouteScreen,
                          (route) => false,);
                  },
                  childIconWidget: Row(
                    children: [
                      SizedBox(
                        width: width * 0.03,
                      ),
                      Icon(Icons.logout, color: AppColors.whiteColor, size: 30)
                      , SizedBox(
                        width: width * 0.02,
                      ),
                      Text(AppLocalizations.of(context)!.logOut,
                          style: AppStyles.MidWhite20),
                    ],
                  ),
                  text: AppLocalizations.of(context)!.logOut,
                  hasIcon: true,
                  backgroundColor: AppColors.redColor,
                  textStyle: AppStyles.bold20Wight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => LanguageBottomSheet(),
    );
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ThemeBottomSheet(),
    );
  }
}
