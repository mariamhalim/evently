import 'package:evently/home/tabs/FavouriteTap/favourite_tap.dart';
import 'package:evently/home/tabs/Profile/profile_tap.dart';
import 'package:evently/home/tabs/homeTap/home_tap.dart';
import 'package:evently/home/tabs/mapTap/map_tap.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> TabsList = [HomeTap(), MapTap(), FavouriteTap(), ProfileTap()];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add, color: AppColors.whiteColor, size: 30),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          backgroundColor: Theme.of(context).primaryColor,
          type: BottomNavigationBarType.fixed,
          items: [
            buildBottomNavBarItem(
              index: 0,
              selectedIconName: AppAssets.home1,
              ubSelectedIconName: AppAssets.home,
              label: AppLocalizations.of(context)!.home,
            ),
            buildBottomNavBarItem(
              index: 1,
              selectedIconName: AppAssets.map1,
              ubSelectedIconName: AppAssets.map,
              label: AppLocalizations.of(context)!.map,
            ),
            buildBottomNavBarItem(
              index: 2,
              selectedIconName: AppAssets.heart1,
              ubSelectedIconName: AppAssets.heart,
              label: AppLocalizations.of(context)!.love,
            ),
            buildBottomNavBarItem(
              index: 3,
              selectedIconName: AppAssets.profile1,
              ubSelectedIconName: AppAssets.profile,
              label: AppLocalizations.of(context)!.profile,
            ),
          ],
        ),
        body: TabsList[selectedIndex],
      ),
    );
  }

  BottomNavigationBarItem buildBottomNavBarItem({
    required String ubSelectedIconName,
    required String selectedIconName,
    required String label,
    required int index,
  }) {
    return BottomNavigationBarItem(
      icon: ImageIcon(
        AssetImage(
          selectedIndex == index ? selectedIconName : ubSelectedIconName,
        ),
      ),
      label: label,
    );
  }
}
