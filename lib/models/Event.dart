class Event {
  Event(this.id, this.name, this.date);

  final int id;
  final String name;
  final DateTime date;

  // Convert an Event object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date.toIso8601String(),
    };
  }

  // Create an Event object from a Map
  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      map['id'] as int,
      map['name'] as String,
      DateTime.parse(map['date'] as String),
    );
  }
}
