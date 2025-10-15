import 'package:evently/add_event/date_or_time_widget.dart';
import 'package:evently/home/tabs/FavouriteTap/widget/costum_form_feild.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/login/widgets/costtum_Elevated_button.dart';
import 'package:evently/model/events.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/event_provider.dart';
import '../utils/firebase_utils.dart';
import 'event_tap_item.dart';
import 'dart:ui' as ui;

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  int selectedIndex = 0;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime? selectDate;
  TimeOfDay? selectTime;
  String formatDate = '';
  String formatTime = '';
  String selectedEventImage = '';
  String selectedEventName = '';
  var formKey = GlobalKey<FormState>();
  late EventListProvider eventListProvider;

  // validation flags
  bool dateError = false;
  bool timeError = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    eventListProvider = Provider.of<EventListProvider>(context);
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

    return Directionality(
      textDirection: ui.TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.trancColor,
          title: Text(
            AppLocalizations.of(context)!.create_event,
            style: TextStyle(color: AppColors.blueColor),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColors.blueColor),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            width: double.infinity,
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
                        separatorBuilder: (context, index) {
                          return SizedBox(width: width * 0.02);
                        },
                        itemCount: activities.length,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(
                        AppLocalizations.of(context)!.title,
                        textAlign: TextAlign.start,
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
                      borderSideColor: Theme.of(context).canvasColor,
                      hintTextStyle: Theme.of(context).textTheme.bodySmall,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter Title';
                        }
                        return null;
                      },
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(
                        AppLocalizations.of(context)!.description,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    CostumeFormField(
                      controller: descriptionController,
                      hintText: AppLocalizations.of(context)!.event_description,
                      borderSideColor: Theme.of(context).canvasColor,
                      hintTextStyle: Theme.of(context).textTheme.bodySmall,
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
                      onChooseDateOrTime: chooseTime,
                      textDate: selectTime == null
                          ? AppLocalizations.of(context)!.choose_time
                          : formatTime,
                    ),
                    if (timeError)
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "Please choose a time",
                          style: AppStyles.MidRedt16,
                        ),
                      ),
                    SizedBox(height: height * 0.01),
                    Container(
                      width: double.infinity,
                      child: Text(
                        AppLocalizations.of(context)!.location,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
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
                          Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.blueColor,
                          ),
                          SizedBox(width: width * 0.02),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    CostumeElevatedButton(
                      onPressed: addEvent,
                      hasIcon: true,
                      childIconWidget: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: width * 0.02),
                          Text(
                            AppLocalizations.of(context)!.add_event,
                            style: AppStyles.MidWhite20,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                  ],
                ),
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
      lastDate: DateTime.now().add(Duration(days: 365)),
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

  void addEvent() {
    setState(() {
      dateError = selectDate == null;
      timeError = selectTime == null;
    });

    if (formKey.currentState?.validate() == true &&
        selectDate != null &&
        selectTime != null) {
      Event event = Event(
        title: titleController.text,
        description: descriptionController.text,
        eventDataTime: selectDate!,
        eventImage: selectedEventImage,
        eventName: selectedEventName,
        eventTime: formatTime,
      );

      FirebaseUtils.addEventToFireStore(event)
          .then((_) {
            print('Event added!');
            eventListProvider.getAllEvents();
            Navigator.pop(context);
          })
          .catchError((error) {
            print('Error adding event: $error');
          });
    }
  }
}
