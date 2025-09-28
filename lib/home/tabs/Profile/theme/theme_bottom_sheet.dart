import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/app_language_provider.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: height * 0.02,
          horizontal: width * 0.04,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: () => themeProvider.changeTheme(ThemeMode.light),
              child: themeProvider.appTheme == ThemeMode.light
                  ? getSelectedItemWidget(
                      language: AppLocalizations.of(context)!.light,
                    )
                  : getUnselectedItemWidget(
                      language: AppLocalizations.of(context)!.light,
                    ),
            ),
            SizedBox(height: height * 0.02),
            InkWell(
              onTap: () => themeProvider.changeTheme(ThemeMode.dark),
              child: themeProvider.appTheme == ThemeMode.dark
                  ? getSelectedItemWidget(
                      language: AppLocalizations.of(context)!.dark,
                    )
                  : getUnselectedItemWidget(
                      language: AppLocalizations.of(context)!.dark,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getSelectedItemWidget({required String language}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(language, style: AppStyles.bold16Blue),
        Icon(Icons.check, color: AppColors.blueColor),
      ],
    );
  }

  Widget getUnselectedItemWidget({required String language}) {
    return Text(language, style: AppStyles.bold16Black);
  }
}
