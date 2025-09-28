import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart' show AppColors;
import '../l10n/app_localizations.dart';
import '../utils/app_routes.dart';

class OnBoardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: IntroductionScreen(
        globalBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        pages: [
          /// ------------ Page 1 ------------
          PageViewModel(
            title: "",
            bodyWidget: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(AppAssets.logoOB, width: 159, height: 50),
                  const SizedBox(height: 20),
                  Image.asset(AppAssets.OB1),
                  const SizedBox(height: 20),
                  Text(
                    AppLocalizations.of(context)!.onBoardingTitle1,
                    style: AppStyles.bold20Blue,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    AppLocalizations.of(context)!.onBoardingBody1,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            decoration: PageDecoration(
              bodyTextStyle: Theme.of(context).textTheme.bodyMedium!,
            ),
          ),

          /// ------------ Page 2 ------------
          PageViewModel(
            title: "",
            bodyWidget: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(AppAssets.logoOB, width: 159, height: 50),
                  const SizedBox(height: 20),
                  Image.asset(AppAssets.OB2),
                  const SizedBox(height: 20),
                  Text(
                    AppLocalizations.of(context)!.onBoardingTitle2,
                    style: AppStyles.bold20Blue,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    AppLocalizations.of(context)!.onBoardingBody2,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            decoration: PageDecoration(
              bodyTextStyle: Theme.of(context).textTheme.bodyMedium!,
            ),
          ),

          PageViewModel(
            title: "",
            bodyWidget: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(AppAssets.logoOB, width: 159, height: 50),
                  const SizedBox(height: 20),
                  Image.asset(AppAssets.OB3),
                  const SizedBox(height: 20),
                  Text(
                    AppLocalizations.of(context)!.onBoardingTitle3,
                    style: AppStyles.bold20Blue,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    AppLocalizations.of(context)!.onBoardingBody3,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            decoration: PageDecoration(
              bodyTextStyle: Theme.of(context).textTheme.bodyMedium!,
            ),
          ),
        ],

        /// ------------ Buttons + Dots ------------
        onDone: () {
          Navigator.pushReplacementNamed(context, AppRoutes.LoginRouteScreen);
        },
        showSkipButton: false,
        showBackButton: true,
        back: Image(image: AssetImage(AppAssets.back_arrow)),
        next: Image(image: AssetImage(AppAssets.forward_arrow)),
        done: Image(image: AssetImage(AppAssets.forward_arrow)),

        dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          activeColor: AppColors.blueColor,
          color: AppColors.blackColor,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    );
  }
}
