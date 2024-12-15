class Event {
  Event(this.id, this.name, this.date, this.isPublished);

  final int id;
  final String name;
  final DateTime date;
  final bool isPublished;

  // Convert an Event object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date.toIso8601String(),
      'isPublished': isPublished,
    };
  }

  // Create an Event object from a Map
  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      map['id'] as int,
      map['name'] as String,
      DateTime.parse(map['date'] as String),
      map['isPublished'] as bool,
    );
  }

  Event copyWith({
    int? id,
    String? name,
    DateTime? date,
    bool? isPublished,
  }) {
    return Event(
      id ?? this.id,
      name ?? this.name,
      date ?? this.date,
      isPublished ?? this.isPublished,
    );
  }
}
