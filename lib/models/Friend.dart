class Friend {
  String name;
  String phone;
  String imageUrl;
  int upcomingEvents;

  Friend(this.name, this.phone, this.imageUrl, this.upcomingEvents);

  // Convert a Friend object to a Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'imageUrl': imageUrl,
      'upcomingEvents': upcomingEvents,
    };
  }

  // Create a Friend object from a Map
  factory Friend.fromMap(Map<String, dynamic> map) {
    return Friend(
      map['name'] as String,
      map['phone'] as String,
      map['imageUrl'] as String,
      map['upcomingEvents'] as int,
    );
  }
}
