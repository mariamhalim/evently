import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/model/events.dart';
import 'package:evently/providers/event_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

import 'package:provider/provider.dart';

class EventItem extends StatelessWidget {
  final Event event;
  final VoidCallback? onTap;

  const EventItem({super.key, required this.event, this.onTap});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var eventListProvider = Provider.of<EventListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);

    return Directionality(
      textDirection: ui.TextDirection.ltr,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.03,
            vertical: height * 0.01,
          ),
          child: Container(
            height: height * 0.25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.blueColor),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(event.eventImage),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.03,
                vertical: height * 0.01,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: width * 0.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme
                          .of(context)
                          .dividerColor,
                    ),
                    child: Column(
                      children: [
                        Text(event.eventDataTime.day.toString(),
                            style: AppStyles.bold20Blue),
                        Text(
                          DateFormat('MMM').format(event.eventDataTime),
                          style: AppStyles.bold16Blue,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: height * 0.05,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme
                          .of(context)
                          .dividerColor,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                      child: Row(
                        children: [
                          Text(
                            event.title,
                            style: Theme
                                .of(context)
                                .textTheme
                                .headlineLarge,
                          ),
                          const Spacer(),
                          InkWell(
                              onTap: () {
                                eventListProvider.updateIsFavorite(
                                    event, userProvider.currentUser!.id);
                              },
                              child: event.isFavourite == true ?
                              Icon(CupertinoIcons.heart_solid,
                                color: AppColors.blueColor,)
                                  :
                              Icon(CupertinoIcons.heart,
                                color: AppColors.blueColor,)
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}