import 'package:evently/home/tabs/FavouriteTap/widget/costum_form_feild.dart';
import 'package:evently/home/tabs/homeTap/widget/event_item.dart';
import 'package:evently/home/tabs/homeTap/widget/event_tap_item.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';

class FavouriteTap extends StatelessWidget {
  FavouriteTap({super.key});

  TextEditingController searchController = TextEditingController();

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    List<String> activities = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.workshop,
      AppLocalizations.of(context)!.bookClub,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating,
    ];
    // TODO: implement build
    return Directionality(
      textDirection: TextDirection.ltr,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              CostumeFormField(
                controller: searchController,
                borderSideColor: AppColors.blueColor,
                hintText: AppLocalizations.of(context)!.search_event,
                hintTextStyle: AppStyles.bold14blue,
                prefixIcon: Icon(Icons.search, color: AppColors.blueColor),
              ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Container();
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: height * 0.02);
                  },
                  itemCount: 20,
                ),
              ),
              // DefaultTabController
            ],
          ),
        ),
      ),
    );
  }
}
