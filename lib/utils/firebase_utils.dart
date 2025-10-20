import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/model/events.dart';
import 'package:evently/model/my_user.dart';

class FirebaseUtils {
  static CollectionReference<Event> getEventCollection(String uId) {
    return getUserCollection().doc(uId)
        .collection(Event.collectionName)
        .withConverter<Event>(
      fromFirestore: (snapshot, options) =>
          Event.fromFireStore(snapshot.data()!),
      toFirestore: (event, options) => event.toFireStore(),
    );
  }

  static Future<void> addEventToFireStore(Event event, String uId) {
    CollectionReference<Event> collectionRef = getEventCollection(uId);
    DocumentReference<Event> docRef = collectionRef.doc();
    event.id = docRef.id;
    return docRef.set(event);
  }

  static Future<void> updateEventInFireStore(Event event, String uId) {
    return getEventCollection(uId).doc(event.id).update(event.toFireStore());
  }

  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance.collection(MyUser.collectionNane)
        .withConverter<MyUser>(
      fromFirestore: (snapshot, options) =>
          MyUser.fromFireStore(snapshot.data()!),
      toFirestore: (user, options) => user.toFireStore(),
    );
  }

  static Future<void> addUserToFireStore(MyUser myUser) {
    return getUserCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUserFromFireStore(String id) async {
    var querySnapShot = await getUserCollection().doc(id).get();
    return querySnapShot.data();
  }

  static Future<void> createUserInFireStore({
    required String id,
    required String email,
    required String name,
  }) async {
    MyUser newUser = MyUser(
      id: id,
      email: email,
      name: name,
    );

    await getUserCollection().doc(id).set(newUser);
  }
}

