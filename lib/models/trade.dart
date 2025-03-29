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
  bool isFav;
  TradeProgress tradeProgress;
  String approachee;
  bool isLive;

  Trade({
    required this.tradeId,
    required this.clientUserId,
    required this.heading,
    required this.description,
    required this.price,
    required this.expectedDeliveryTime,
    required this.approachee,
    this.hoursPerDay = 4,
    required this.tags,
    required this.tradeProgress,
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
      'approachee': approachee,
      'tradeProgress': tradeProgress.toString().split('.').last, // e.g., "live"
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
      // Parse tradeProgress from string to enum
      tradeProgress: TradeProgress.values.firstWhere(
        (e) => e.toString().split('.').last == json['tradeProgress'],
        orElse: () => TradeProgress.live, // Default value if no match
      ),
      approachee: json['approachee'] == null ? '' : json['approachee'].toString(),
      price: json["price"] is int
          ? (json["price"] as int).toDouble()
          : json["price"],
      tags: (json["tags"] as List).map((item) => item.toString()).toList(),
      expectedDeliveryTime: json["expectedDeliveryTime"],
      hoursPerDay: json["hoursPerDay"] is int
          ? json["hoursPerDay"]
          : int.parse(json["hoursPerDay"].toString()),
      isFav: json["isFav"] is bool ? json["isFav"] : json["isFav"] == true,
      isLive: json["isLive"] is bool ? json["isLive"] : json["isLive"] == true,
    );
  }
}