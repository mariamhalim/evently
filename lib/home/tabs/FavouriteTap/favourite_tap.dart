import 'package:evently/home/tabs/FavouriteTap/widget/costum_form_feild.dart';
import 'package:evently/home/tabs/homeTap/widget/event_item.dart';
import 'package:evently/home/tabs/homeTap/widget/event_tap_item.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/event_provider.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';

class FavouriteTap extends StatefulWidget {
  FavouriteTap({super.key});

  @override
  State<FavouriteTap> createState() => _FavouriteTapState();
}

class _FavouriteTapState extends State<FavouriteTap> {
  TextEditingController searchController = TextEditingController();
  late EventListProvider eventListProvider;
  late UserProvider userProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      eventListProvider.getAllFavoriteEvents(userProvider.currentUser!.id);
    },);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    eventListProvider = Provider.of<EventListProvider>(context);
    userProvider = Provider.of<UserProvider>(context);

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
                child: Center(
                  child: eventListProvider.favoriteList.isEmpty ?
                  Text(AppLocalizations.of(context)!.no_events,
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineLarge,)
                      : ListView.separated(
                  itemBuilder: (context, index) {
                    return EventItem(
                        event: eventListProvider.favoriteList[index]);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: height * 0.02);
                  },
                    itemCount: eventListProvider.favoriteList.length,
                ),
              ),
              )
              // DefaultTabController
            ],

          ),
        ),
      ),
    );
  }
}
