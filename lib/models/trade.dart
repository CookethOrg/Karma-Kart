import 'package:karmakart/core/utils/utils.dart';

class Trade {
  String tradeId;
  String clientUserId;
  String heading;
  String description;
  List<ServiceTags> tags;
  double price;
  DateTime expectedDeliveryTime;
  int hoursPerDay;
  Urgency urgency;
  bool isFav;

  Trade({
    required this.tradeId,
    required this.clientUserId,
    this.heading = "New Trade",
    required this.description,
    required this.price,
    required this.expectedDeliveryTime,
    required this.hoursPerDay,
    this.urgency = Urgency.medium,
    this.isFav = false
  }) : tags = <ServiceTags>[];

  Map<String, dynamic> toJson() {
    return {
      "tradeId": tradeId,
      "clientUserId": clientUserId,
      "heading": heading,
      "description": description,
      "tags": [...tags],
      "price": price,
      "expectedDeliveryTime": expectedDeliveryTime,
      "hoursPerDay": hoursPerDay,
      "urgency": urgency,
      "isFav" : isFav
    };
  }

  factory Trade.fromJson(Map<String, dynamic> json) {
    Trade trade = Trade(
      tradeId: json["tradeId"],
      clientUserId: json["clientUserId"],
      description: json["description"],
      price: json["price"],
      expectedDeliveryTime: json["expectedDeliveryTime"],
      hoursPerDay: json["hoursPerDay"],
      urgency: json["urgency"],
      isFav: json["isFav"]
    );
    if (json["tags"] != null) {
      for (var i in json["tags"]) {
        trade.tags.add(i);
      }
    }

    return trade;
  }
}
