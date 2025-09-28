import 'package:evently/home/tabs/homeTap/widget/event_item.dart';
import 'package:evently/home/tabs/homeTap/widget/event_tap_item.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';

class HomeTap extends StatefulWidget {
  HomeTap({super.key});

  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
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
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).primaryColor,
          title: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.welcome_back,
                    style: AppStyles.Reg14Wight,
                  ),
                  Text("Route Academy", style: AppStyles.bold24Wight),
                ],
              ),
              Spacer(),
              Image(image: AssetImage(AppAssets.imageTheme)),
              SizedBox(width: width * 0.02),
              Container(
                height: height * 0.04,
                width: width * 0.09,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(child: Text('EN', style: AppStyles.bold14blue)),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              height: height * 0.1,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: height * 0.01,
                      horizontal: width * 0.03,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: AppColors.whiteColor,
                        ),
                        Text(
                          AppLocalizations.of(context)!.cairo,
                          style: AppStyles.MidWight16,
                        ),
                        Text(', ', style: AppStyles.MidWight16),
                        Text(
                          AppLocalizations.of(context)!.egypt,
                          style: AppStyles.MidWight16,
                        ),
                      ],
                    ),
                  ),
                  DefaultTabController(
                    length: activities.length,

                    child: TabBar(
                      onTap: (index) {
                        selectedIndex = index;
                        setState(() {});
                      },
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      indicatorColor: AppColors.trancColor,
                      dividerColor: AppColors.trancColor,
                      tabs: activities
                          .map(
                            (tapItemName) => EventTabItem(
                              tapItemName: tapItemName,
                              isSelected:
                                  selectedIndex ==
                                  activities.indexOf(tapItemName),
                            ),
                          )
                          .toList(), // EventTabItem
                    ), // TabBar
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return EventItem();
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
    );
  }
}
