import 'package:hedieaty/models/Friend.dart';

class Gift {
  Gift(this.id, this.name, this.price, this.description, this.eventName,
      this.canPledge, this.pledgedBy, this.category);

  final int id;
  final String name;
  final int price;
  final String description;
  final String eventName;
  final String category;
  final bool canPledge;
  final Friend? pledgedBy;

  bool get isPledged => pledgedBy != null;
}
