import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/model/events.dart';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../utils/app_colors.dart';
import '../utils/firebase_utils.dart';
import '../utils/toast_utiles.dart';

class EventListProvider extends ChangeNotifier {
  int selectedIndex = 0;
  List<Event> eventList = [];
  List<Event> eventFilterList = [];
  List<String> activities = [];
  List<Event> favoriteList = [];

  void getEventListName(BuildContext context) {
    activities = [
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
  }

  Future<void> getAllEvents(String uId) async {
    QuerySnapshot<Event> querySnapshot =
    await FirebaseUtils.getEventCollection(uId).get();

    eventList = querySnapshot.docs.map((doc) => doc.data()).toList();
    eventFilterList = eventList;

    eventFilterList.sort(
            (event1, event2) =>
            event1.eventDataTime.compareTo(event2.eventDataTime));

    notifyListeners();
  }

  Future<void> getFilterList(String uId) async {
    QuerySnapshot<Event> querySnapshot =
    await FirebaseUtils.getEventCollection(uId).get();

    eventList = querySnapshot.docs.map((doc) => doc.data()).toList();
    eventFilterList = eventList
        .where((event) => event.eventName == activities[selectedIndex])
        .toList();

    eventFilterList.sort(
            (event1, event2) =>
            event1.eventDataTime.compareTo(event2.eventDataTime));

    notifyListeners();
  }

  void changeSelectedIndex(int newSelectedIndex, String uId) {
    selectedIndex = newSelectedIndex;
    selectedIndex == 0 ? getAllEvents(uId) : getFilterList(uId);
  }

  Future<void> deleteEvent(Event event, String uId) async {
    try {
      await FirebaseUtils.getEventCollection(uId).doc(event.id).delete();

      eventList.removeWhere((e) => e.id == event.id);
      eventFilterList.removeWhere((e) => e.id == event.id);

      notifyListeners();
    } catch (e) {
      debugPrint('❌ Error deleting event: $e');
    }
  }

  Future<void> updateIsFavorite(Event event, String uId) async {
    try {
      await FirebaseUtils.getEventCollection(uId)
          .doc(event.id)
          .update({'isFavourite': !event.isFavourite});

      ToastUtils.showToastMes(
        message: 'Event updated successfully',
        backGroundColor: AppColors.blueColor,
        textColor: AppColors.whiteColor,
      );

      selectedIndex == 0
          ? await getAllEvents(uId)
          : await getFilterList(uId);
    } catch (e) {
      debugPrint('❌ Error updating favorite: $e');
    }
  }

  Future<void> getAllFavoriteEvents(String uId) async {
    QuerySnapshot<Event> querySnapshot =
    await FirebaseUtils.getEventCollection(uId).get();

    eventList = querySnapshot.docs.map((doc) => doc.data()).toList();
    favoriteList =
        eventList.where((event) => event.isFavourite == true).toList();

    notifyListeners();
  }
}
