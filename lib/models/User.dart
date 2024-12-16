class User {
  String id;
  String name;
  String phone;
  String imageUrl;
  int upcomingEvents;

  User(this.id, this.name, this.phone, this.imageUrl, this.upcomingEvents);

  // Convert a User object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'imageUrl': imageUrl,
      'upcomingEvents': upcomingEvents,
    };
  }

  // Create a User object from a Map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      map['id'] as String,
      map['name'] as String,
      map['phone'] as String,
      map['imageUrl'] as String,
      map['upcomingEvents'] as int,
    );
  }

  User copyWith({
    String? id,
    String? name,
    String? phone,
    String? imageUrl,
    int? upcomingEvents,
  }) {
    return User(
      id ?? this.id,  // Use the provided value or keep the current value
      name ?? this.name,
      phone ?? this.phone,
      imageUrl ?? this.imageUrl,
      upcomingEvents ?? this.upcomingEvents,
    );
  }
}
