class User {
  String name;
  String phone;
  String imageUrl;
  int upcomingEvents;

  User(this.name, this.phone, this.imageUrl, this.upcomingEvents);

  // Convert a User object to a Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'imageUrl': imageUrl,
      'upcomingEvents': upcomingEvents,
    };
  }

  // Create a User object from a Map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      map['name'] as String,
      map['phone'] as String,
      map['imageUrl'] as String,
      map['upcomingEvents'] as int,
    );
  }
}
