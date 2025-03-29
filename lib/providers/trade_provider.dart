import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:karmakart/core/utils/state_handler.dart';

class TradeProvider extends StateHandler {
  // Controllers for text fields
  final TextEditingController _headingController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _karmaPointsController = TextEditingController();

  // Other trade data
  DateTime? _startDate;
  DateTime? _endDate;
  List<String> _availableTags = [
    'UI/UX',
    'Development',
    'Flutter',
    'Design',
    'Backend',
    'Frontend',
    'Mobile',
  ];
  List<String> _selectedTags = [];

  // Getters
  TextEditingController get headingController => _headingController;
  TextEditingController get descriptionController => _descriptionController;
  TextEditingController get karmaPointsController => _karmaPointsController;
  DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;
  List<String> get availableTags => _availableTags;
  List<String> get selectedTags => _selectedTags;

  // Duration setter
  void setDuration(DateTime? start, DateTime? end) {
    _startDate = start;
    _endDate = end;
    notifyListeners();
  }

  // Tags management
  void addTag(String tag) {
    final normalizedTag = tag.trim();
    if (normalizedTag.isNotEmpty &&
        !_selectedTags.contains(normalizedTag) &&
        _selectedTags.length < 5) {
      _selectedTags.add(normalizedTag);
      notifyListeners();
    }
  }

  void removeTag(String tag) {
    _selectedTags.remove(tag);
    notifyListeners();
  }

  List<String> getSuggestedTags() {
    return _availableTags.where((tag) => !_selectedTags.contains(tag)).toList();
  }

  // Clear all data
  void clearAll() {
    _headingController.clear();
    _descriptionController.clear();
    _karmaPointsController.clear();
    _startDate = null;
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
      'startDate': _startDate?.toIso8601String(),
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
