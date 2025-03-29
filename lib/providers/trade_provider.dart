import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:karmakart/core/utils/state_handler.dart';
import 'package:karmakart/models/trade.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class TradeProvider extends StateHandler {
  SupabaseClient supabaseClient;
  TradeProvider(this.supabaseClient) : super();
  // Controllers for text fields
  final TextEditingController _headingController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _karmaPointsController = TextEditingController();
  final TextEditingController _deliveryDateController = TextEditingController();

  // Other trade data
  // DateTime? _startDate;
  DateTime? _endDate;
  final List<String> _availableTags = [
    'UI/UX',
    'Development',
    'Flutter',
    'Design',
    'Backend',
    'Frontend',
    'Mobile',
    'Python',
    'Writing',
    'VideoGraphy',
    'Cameraman',
  ];
  final List<String> _selectedTags = [];
  List<String> _myTags = [];

  // Getters
  TextEditingController get headingController => _headingController;
  TextEditingController get descriptionController => _descriptionController;
  TextEditingController get karmaPointsController => _karmaPointsController;
  TextEditingController get deliveryDateController => _deliveryDateController;
  // DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;
  List<String> get selectedTags => List.unmodifiable(_selectedTags);
  List<String> get availableTags => List.unmodifiable(_availableTags);
  List<String> get myTags => _myTags;

  // Duration setter
  void setDuration(DateTime? end) {
    // _startDate = start;
    _endDate = end;
    notifyListeners();
  }

  // Add a tag
  void addTag(String tag) {
    if (!_selectedTags.contains(tag) && _selectedTags.length < 5) {
      _selectedTags.add(tag);
      notifyListeners();
    }
  }

  // Remove a tag
  void removeTag(String tag) {
    _selectedTags.remove(tag);
    notifyListeners();
  }

  // Clear all tags
  void clearTags() {
    _selectedTags.clear();
    notifyListeners();
  }

  // Set all tags at once
  void setTags(List<String> tags) {
    _selectedTags.clear();
    if (tags.length <= 5) {
      _selectedTags.addAll(tags);
    } else {
      _selectedTags.addAll(tags.sublist(0, 5));
    }
    notifyListeners();
  }

  // Add custom available tags
  void addAvailableTag(String tag) {
    if (!_availableTags.contains(tag)) {
      _availableTags.add(tag);
      notifyListeners();
    }
  }

  void onChangeTags(List<String> tags) {
    List<String> lst = _myTags;
    lst = [...tags];
    _myTags = lst;
    notifyListeners();
  }

  Future<String> createTrade({
    required String heading,
    required String description,
    required List<String> tags,
    required double price,
    required String expectedDeliveryDate,
  }) async {
    String res = 'Some error occured';
    try {
      String txid = Uuid().v4();
      final userId = supabaseClient.auth.currentUser?.id;
      final newTrade = Trade(
        tradeId: txid,
        clientUserId: userId!,
        description: description,
        tags: tags,
        price: price,
        expectedDeliveryTime: expectedDeliveryDate,
      );

      await supabaseClient.from('Trade').insert({
        'tradeId': newTrade.tradeId,
        'clientUserId': newTrade.clientUserId,
        'heading': newTrade.heading,
        'description': newTrade.description,
        'tags': newTrade.tags,
        'price': newTrade.price,
        'expectedDeliveryTime': newTrade.expectedDeliveryTime,
        'hoursPerDay': newTrade.hoursPerDay,
        // 'urgency': newTrade.urgency,
        'isFav': newTrade.isFav,
      });
      res = 'Trade Posted';
    } catch (e) {
      return e.toString();
    }
    return res;
  }

  // Clear all data
  void clearAll() {
    _headingController.clear();
    _descriptionController.clear();
    _karmaPointsController.clear();
    // _startDate = null;
    _endDate = null;
    _selectedTags.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    _headingController.dispose();
    _descriptionController.dispose();
    _karmaPointsController.dispose();
    _deliveryDateController.dispose();
    super.dispose();
  }
}
