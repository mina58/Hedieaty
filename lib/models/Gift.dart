import 'package:hedieaty/models/Event.dart';
import 'package:hedieaty/models/User.dart';

class Gift {
  Gift(this.id, this.name, this.price, this.description, this.event,
      this.canPledge, this.pledgedBy, this.category, this.imageURL);

  final int id;
  final String name;
  final int price;
  final String description;
  final Event event;
  final bool canPledge;
  final User? pledgedBy;
  final String category;
  final String imageURL;

  bool get isPledged => pledgedBy != null;

  // Convert a Gift object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'eventName': event.toMap(),
      'category': category,
      'canPledge': canPledge,
      'pledgedBy': pledgedBy?.toMap(),
      'imageURL': imageURL, // Convert Friend to Map if not null
    };
  }

  // Create a Gift object from a Map
  factory Gift.fromMap(Map<String, dynamic> map) {
    return Gift(
      map['id'] as int,
      map['name'] as String,
      map['price'] as int,
      map['description'] as String,
      Event.fromMap(map["event"] as Map<String, dynamic>),
      map['canPledge'] as bool,
      map['pledgedBy'] != null
          ? User.fromMap(map['pledgedBy'] as Map<String, dynamic>)
          : null,
      // Convert Map to Friend if not null
      map['category'] as String,
      map['imageURL'] as String,
    );
  }

  Gift copyWith({
    int? id,
    String? name,
    int? price,
    String? description,
    Event? event,
    bool? canPledge,
    User? pledgedBy,
    String? category,
    String? imageURL,
  }) {
    return Gift(
      id ?? this.id,
      name ?? this.name,
      price ?? this.price,
      description ?? this.description,
      event ?? this.event,
      canPledge ?? this.canPledge,
      pledgedBy ?? this.pledgedBy,
      category ?? this.category,
      imageURL ?? this.imageURL,
    );
  }
}
