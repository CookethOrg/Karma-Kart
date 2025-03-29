import 'package:karmakart/core/utils/utils.dart';

class Trade {
  String tradeId;
  String clientUserId;
  String heading;
  String description;
  List<String> tags;
  double price;
  String expectedDeliveryTime;
  int hoursPerDay;
  // Urgency urgency;
  bool isFav;
  bool isLive;

  Trade({
    required this.tradeId,
    required this.clientUserId,
    required this.heading,
    required this.description,
    required this.price,
    required this.expectedDeliveryTime,
    this.hoursPerDay = 4,
    required this.tags,
    // this.urgency = Urgency.medium,
    this.isFav = false,
    this.isLive = true,
  });

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
      // "urgency": urgency,
      "isFav": isFav,
      'isLive': isLive,
    };
  }

  factory Trade.fromJson(Map<String, dynamic> json) {
    return Trade(
      tradeId: json["tradeId"],
      heading: json["heading"],
      clientUserId: json["clientUserId"],
      description: json["description"],
      // Convert price to double
      price:
          json["price"] is int
              ? (json["price"] as int).toDouble()
              : json["price"],
      // Convert tags to List<String>
      tags: (json["tags"] as List).map((item) => item.toString()).toList(),
      expectedDeliveryTime: json["expectedDeliveryTime"],
      // Ensure hoursPerDay is an int
      hoursPerDay:
          json["hoursPerDay"] is int
              ? json["hoursPerDay"]
              : int.parse(json["hoursPerDay"].toString()),
      // Ensure boolean fields
      isFav: json["isFav"] is bool ? json["isFav"] : json["isFav"] == true,
      isLive: json["isLive"] is bool ? json["isLive"] : json["isLive"] == true,
    );
  }
}
