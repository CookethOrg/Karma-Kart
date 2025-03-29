import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:karmakart/core/utils/state_handler.dart';

class TradeProvider extends StateHandler {
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
    'Cameraman'
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

  // Get trade data
  Map<String, dynamic> getTradeData() {
    return {
      'heading': _headingController.text.trim(),
      'description': _descriptionController.text.trim(),
      'karmaPoints': int.tryParse(_karmaPointsController.text) ?? 0,
      // 'startDate': _startDate?.toIso8601String(),
      'endDate': _endDate?.toIso8601String(),
      'tags': List.from(_selectedTags),
    };
  }

  @override
  void dispose() {
    _headingController.dispose();
    _descriptionController.dispose();
    _karmaPointsController.dispose();
    super.dispose();
  }
}
