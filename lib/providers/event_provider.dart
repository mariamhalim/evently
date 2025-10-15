import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/model/events.dart';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../utils/firebase_utils.dart';

class EventListProvider extends ChangeNotifier {
  int selectedIndex = 0;
  List<Event> eventList = [];
  List<Event> eventFilterList = [];
  List<String> activities = [];

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

  Future<void> getAllEvents() async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventCollection().get();
    eventList = querySnapshot.docs.map((doc) => doc.data()).toList();

    eventFilterList = eventList;
    eventFilterList.sort((event1, event2) {
      return event1.eventDataTime.compareTo(event2.eventDataTime);
    });
    notifyListeners();
  }

  Future<void> getFilterList() async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventCollection().get();
    eventList = querySnapshot.docs.map((doc) => doc.data()).toList();

    eventFilterList = eventList.where((event) {
      return event.eventName == activities[selectedIndex];
    }).toList();
    eventFilterList.sort((event1, event2) {
      return event1.eventDataTime.compareTo(event2.eventDataTime);
    });
    notifyListeners();
  }

  void changeSelectedIndex(int newSelectedIndex) {
    selectedIndex = newSelectedIndex;
    selectedIndex == 0 ? getAllEvents() : getFilterList();
  }

  Future<void> deleteEvent(Event event) async {
    try {
      await FirebaseFirestore.instance
          .collection('events')
          .doc(event.id)
          .delete();

      eventList.removeWhere((e) => e.id == event.id);
      eventFilterList.removeWhere((e) => e.id == event.id);

      notifyListeners();
    } catch (e) {
      debugPrint('❌ Error deleting event: $e');
    }
  }
}
