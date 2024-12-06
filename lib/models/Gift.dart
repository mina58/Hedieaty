import 'package:hedieaty/models/User.dart';

class Gift {
  Gift(this.id, this.name, this.price, this.description, this.eventName,
      this.canPledge, this.pledgedBy, this.category, this.imageURL);

  final int id;
  final String name;
  final int price;
  final String description;
  final String eventName;
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
      'eventName': eventName,
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
      map['eventName'] as String,
      map['canPledge'] as bool,
      map['pledgedBy'] != null
          ? User.fromMap(map['pledgedBy'] as Map<String, dynamic>)
          : null,
      // Convert Map to Friend if not null
      map['category'] as String,
      map['imageURL'] as String,
    );
  }
}
