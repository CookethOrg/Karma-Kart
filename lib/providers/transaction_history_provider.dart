import 'package:flutter/foundation.dart';

class Transaction {
  final String name;
  final String date;
  final int points;
  final String? username;
  final String? service;

  Transaction({
    required this.name,
    required this.date,
    required this.points,
    this.username,
    this.service,
  });

  bool get isPositive => points > 0;
}

class TransactionProvider with ChangeNotifier {
  List<Transaction> _transactions = [
    Transaction(
      name: 'Mike Wazuski',
      date: '25 March, 6:30 p.m.',
      points: -200,
      username: '@mikey',
      service: 'Logo Design for Startup',
    ),
    Transaction(
      name: 'Hehe Hehe',
      date: '25 March, 4:30 p.m.',
      points: 30,
      username: '@hehe',
      service: 'Content Writing',
    ),
    Transaction(
      name: 'Mike Wazuski',
      date: '24 March, 6:30 p.m.',
      points: -200,
      username: '@mikey',
      service: 'Website Development',
    ),
    Transaction(
      name: 'Hehe Hehe',
      date: '24 March, 4:30 p.m.',
      points: 30,
      username: '@hehe',
      service: 'Graphic Design',
    ),
  ];

  List<Transaction> get transactions => [..._transactions];

  Transaction getTransactionAt(int index) {
    return _transactions[index];
  }

  void addTransaction(Transaction transaction) {
    _transactions.add(transaction);
    notifyListeners();
  }
}
