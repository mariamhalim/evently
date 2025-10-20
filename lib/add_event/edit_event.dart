import 'dart:ui' as ui;

import 'package:evently/add_event/date_or_time_widget.dart';
import 'package:evently/home/tabs/FavouriteTap/widget/costum_form_feild.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/login/widgets/costtum_Elevated_button.dart';
import 'package:evently/model/events.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/event_provider.dart';
import '../utils/firebase_utils.dart';
import 'event_tap_item.dart';

class EditEvent extends StatefulWidget {
  final Event event;

  const EditEvent({super.key, required this.event});

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  DateTime? selectDate;
  TimeOfDay? selectTime;
  String formatDate = '';
  String formatTime = '';
  late int selectedIndex;
  late String selectedEventImage;
  late String selectedEventName;
  var formKey = GlobalKey<FormState>();
  late EventListProvider eventListProvider;
  late UserProvider userProvider;

  bool dateError = false;
  bool timeError = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.event.title);
    descriptionController = TextEditingController(
      text: widget.event.description,
    );
    selectDate = widget.event.eventDataTime;
    selectTime = _parseTime(widget.event.eventTime);
    formatDate = DateFormat('dd/MM/yyyy').format(widget.event.eventDataTime);
    formatTime = widget.event.eventTime;
  }

  TimeOfDay _parseTime(String timeString) {
    try {
      final format = DateFormat.jm();
      final dateTime = format.parse(timeString);
      return TimeOfDay.fromDateTime(dateTime);
    } catch (e) {
      return TimeOfDay.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    eventListProvider = Provider.of<EventListProvider>(context);
    userProvider = Provider.of<UserProvider>(context);


    List<String> activities = [
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

    List<String> activitiesAssets = [
      AppAssets.sport,
      AppAssets.birthday,
      AppAssets.meeting,
      AppAssets.gaming,
      AppAssets.work,
      AppAssets.book,
      AppAssets.exhibition,
      AppAssets.holiday,
      AppAssets.eat,
    ];
    selectedIndex = activities.indexOf(widget.event.eventName);
    if (selectedIndex == -1) selectedIndex = 0;
    selectedEventImage = activitiesAssets[selectedIndex];
    selectedEventName = activities[selectedIndex];

    return Directionality(
      textDirection: ui.TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.trancColor,
          title: Text(
            AppLocalizations.of(context)!.edit_event,
            style: TextStyle(color: AppColors.blueColor),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColors.blueColor),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(activitiesAssets[selectedIndex]),
                  ),
                  SizedBox(height: height * 0.02),
                  SizedBox(
                    height: height * 0.08,
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return InkWell(
                          splashColor: AppColors.trancColor,
                          highlightColor: AppColors.trancColor,
                          onTap: () {
                            selectedIndex = index;
                            selectedEventImage = activitiesAssets[index];
                            selectedEventName = activities[index];
                            setState(() {});
                          },
                          child: EventTabItemAdd(
                            selectedTextColor: Theme.of(
                              context,
                            ).textTheme.bodyLarge,
                            selectedBgColor: AppColors.blueColor,
                            tapItemName: activities[index],
                            isSelected: selectedIndex == index,
                          ),
                        );
                      },
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) =>
                          SizedBox(width: width * 0.02),
                      itemCount: activities.length,
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppLocalizations.of(context)!.title,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  CostumeFormField(
                    controller: titleController,
                    hintText: AppLocalizations.of(context)!.event_title,
                    prefixIcon: Icon(
                      Icons.edit_note_outlined,
                      color: Theme.of(context).highlightColor,
                    ),
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please Enter Title';
                      }
                      return null;
                    },
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppLocalizations.of(context)!.description,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  CostumeFormField(
                    controller: descriptionController,
                    hintText: AppLocalizations.of(context)!.event_description,
                    maxLines: 3,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please Enter Description';
                      }
                      return null;
                    },
                  ),

                  // Date
                  DateOrTimeWidget(
                    iconName: Icons.calendar_month_rounded,
                    textTime: AppLocalizations.of(context)!.event_date,
                    textDate: selectDate == null
                        ? AppLocalizations.of(context)!.choose_date
                        : formatDate,
                    onChooseDateOrTime: chooseDate,
                  ),
                  if (dateError)
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "Please choose a date",
                        style: AppStyles.MidRedt16,
                      ),
                    ),

                  // Time
                  DateOrTimeWidget(
                    iconName: CupertinoIcons.clock,
                    textTime: AppLocalizations.of(context)!.event_time,
                    textDate: selectTime == null
                        ? AppLocalizations.of(context)!.choose_time
                        : formatTime,
                    onChooseDateOrTime: chooseTime,
                  ),
                  if (timeError)
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "Please choose a time",
                        style: AppStyles.MidRedt16,
                      ),
                    ),

                  SizedBox(height: height * 0.02),

                  CostumeElevatedButton(
                    onPressed: () {
                      saveChanges();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRoutes.RouteHomeScreen,
                        (route) => false,
                      );
                    },
                    hasIcon: true,
                    childIconWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.update_event,
                          style: AppStyles.MidWhite20,
                        ),
                      ],
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

  void chooseDate() async {
    var chooseDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (chooseDate != null) {
      selectDate = chooseDate;
      formatDate = DateFormat('dd/MM/yyyy').format(selectDate!);
      dateError = false;
      setState(() {});
    }
  }

  void chooseTime() async {
    var chooseTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (chooseTime != null) {
      selectTime = chooseTime;
      formatTime = selectTime!.format(context);
      timeError = false;
      setState(() {});
    }
  }

  void saveChanges() {
    setState(() {
      dateError = selectDate == null;
      timeError = selectTime == null;
    });

    if (formKey.currentState?.validate() == true &&
        selectDate != null &&
        selectTime != null) {
      Event updatedEvent = Event(
        id: widget.event.id,
        title: titleController.text,
        description: descriptionController.text,
        eventDataTime: selectDate!,
        eventImage: selectedEventImage,
        eventName: selectedEventName,
        eventTime: formatTime,
        isFavourite: widget.event.isFavourite,
      );

      FirebaseUtils.updateEventInFireStore(
          updatedEvent, userProvider.currentUser!.id)
          .then((_) {
        eventListProvider.getAllEvents(userProvider.currentUser!.id);
            Navigator.pop(context);
          })
          .catchError((error) {
            print('Error updating event: $error');
          });
    }
  }
}
