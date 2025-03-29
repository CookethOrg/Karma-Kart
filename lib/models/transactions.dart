class Transactions {
  String txId;
  String tradeId;
  DateTime timestamp;
  String comment;
  String clientUserId;
  String serviceProviderUserId;
  double clientOfferPrice;
  double serviceProviderOfferPrice;
  double clientReceivedPrice;
  double serviceProviderReceivedPrice;
  double clientRateToProv;
  double provRateToClient;

  Transactions({
    required this.txId,
    required this.tradeId,
    required this.timestamp,
    this.comment = "",
    required this.clientUserId,
    required this.serviceProviderUserId,
    required this.clientOfferPrice,
    required this.serviceProviderOfferPrice,
    required this.clientReceivedPrice,
    required this.serviceProviderReceivedPrice,
    required this.clientRateToProv,
    required this.provRateToClient,
  });

  // for serialization
  Map<String, dynamic> toJson() {
    return {
      "txId": txId,
      "tradeId": tradeId,
      "timestamp": timestamp,
      "comment": comment,
      "clientUserId": clientUserId,
      "serviceProviderUserId": serviceProviderUserId,
      "clientOfferPrice": clientOfferPrice,
      "serviceProviderOfferPrice": serviceProviderOfferPrice,
      "clientReceivedPrice": clientReceivedPrice,
      "serviceProviderReceivedPrice": serviceProviderReceivedPrice,
      "clientRateToProv": clientRateToProv,
      "provRateToClient": provRateToClient,
    };
  }

  // to deserialize
  factory Transactions.fromJson(Map<String, dynamic> json) {
    Transactions tx = Transactions(
      txId: json["txId"],
      tradeId: json["tradeId"],
      timestamp: json["timestamp"],
      clientUserId: json["clientUserId"],
      serviceProviderUserId: json["serviceProviderUserId"],
      clientOfferPrice: json["clientOfferPrice"],
      serviceProviderOfferPrice: json["serviceProviderOfferPrice"],
      clientReceivedPrice: json["clientReceivedPrice"],
      serviceProviderReceivedPrice: json["serviceProviderReceivedPrice"],
      clientRateToProv: json["clientRateToProv"],
      provRateToClient: json["provRateToClient"],
    );

    return tx;
  }
}
