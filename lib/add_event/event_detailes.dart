import 'package:evently/login/widgets/costtum_Elevated_button.dart';
import 'package:evently/model/events.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';

import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/event_provider.dart';
import '../utils/app_assets.dart';
import 'dart:ui' as ui;

import 'edit_event.dart';

class EventDetailsPage extends StatelessWidget {
  final Event event;

  const EventDetailsPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final eventListProvider = Provider.of<EventListProvider>(
      context,
      listen: false,
    );

    return Directionality(
      textDirection: ui.TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.trancColor,
          title: Text(
            AppLocalizations.of(context)!.event_details,
            style: TextStyle(color: AppColors.blueColor),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColors.blueColor),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                final updated = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => EditEvent(event: event)),
                );
                if (updated == true) {
                  // رجعي تحميل القائمة بعد التعديل
                  Provider.of<EventListProvider>(
                    context,
                    listen: false,
                  ).getAllEvents();
                }
              },
            ),
            CostumeElevatedButton(
              childIconWidget: Icon(
                Icons.delete_outline,
                color: AppColors.redColor,
                size: 25,
              ),
              backgroundColor: AppColors.trancColor,
              hasIcon: true,
              onPressed: () async {
                await eventListProvider.deleteEvent(event);
                Navigator.pop(context);
              },
            ),
          ],
        ),

        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(event.eventImage),
                ),
                SizedBox(height: height * 0.02),
                Text(event.title, style: AppStyles.MidBluet24),
                SizedBox(height: height * 0.02),
                CostumeElevatedButton(
                  onPressed: () {},
                  backgroundColor: AppColors.trancColor,
                  borderColor: AppColors.blueColor,
                  hasIcon: true,
                  childIconWidget: Row(
                    children: [
                      SizedBox(width: width * 0.02),
                      Image(image: AssetImage(AppAssets.calender)),
                      SizedBox(width: width * 0.02),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat(
                              'd MMMM yyyy',
                            ).format(event.eventDataTime),
                            style: AppStyles.MidBluet16,
                          ),
                          Text(
                            '${event.eventTime}',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ],
                      ),

                      SizedBox(width: width * 0.02),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.02),
                CostumeElevatedButton(
                  onPressed: () {},
                  backgroundColor: AppColors.trancColor,
                  borderColor: AppColors.blueColor,
                  hasIcon: true,
                  childIconWidget: Row(
                    children: [
                      SizedBox(width: width * 0.02),
                      Image(image: AssetImage(AppAssets.location)),
                      SizedBox(width: width * 0.02),
                      Text(
                        AppLocalizations.of(context)!.choose_event_location,
                        style: AppStyles.MidBlue20,
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios, color: AppColors.blueColor),
                      SizedBox(width: width * 0.02),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.02),
                Image(image: AssetImage(AppAssets.gps)),
                SizedBox(height: height * 0.02),
                Container(
                  width: double.infinity,
                  child: Text(
                    AppLocalizations.of(context)!.description,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                SizedBox(height: height * 0.01),
                Text(
                  event.description,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
