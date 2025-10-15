class Event {
  static const String collectionName = 'events';

  String id;
  String title;
  String description;
  String eventImage;
  String eventName;
  DateTime eventDataTime;
  String eventTime;
  bool isFavourite;

  Event({
    this.id = '',
    required this.title,
    required this.description,
    required this.eventDataTime,
    required this.eventImage,
    required this.eventName,
    required this.eventTime,
    this.isFavourite = false,
  });

  Event.fromFireStore(Map<String, dynamic> data)
    : this(
        id: data['id'] ?? '',
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        eventDataTime: DateTime.fromMillisecondsSinceEpoch(
          data['eventDataTime'],
        ),
        eventImage: data['eventImage'] ?? '',
        eventName: data['eventName'] ?? '',
        eventTime: data['eventTime'] ?? '',
        isFavourite: data['isFavourite'] ?? false,
      );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'eventName': eventName,
      'eventDataTime': eventDataTime.millisecondsSinceEpoch,
      'eventImage': eventImage,
      'eventTime': eventTime,
      'isFavourite': isFavourite,
    };
  }
}
