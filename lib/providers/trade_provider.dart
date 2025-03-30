import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:karmakart/core/utils/state_handler.dart';
import 'package:karmakart/core/utils/utils.dart';
import 'package:karmakart/models/trade.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class TradeProvider extends StateHandler {
  SupabaseClient supabaseClient;
  TradeProvider(this.supabaseClient) : super() {
    initializeTradeList();
  }
  // Controllers for text fields
  final TextEditingController _headingController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _karmaPointsController = TextEditingController();
  final TextEditingController _deliveryDateController = TextEditingController();
  final List<Trade> _tradeList = [];
  final List<Trade> _postedTrades = [];
  bool _isLoading = false;
  final List<Trade> _yourTrades = [];

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
  DateTime? get endDate => _endDate;
  List<String> get selectedTags => List.unmodifiable(_selectedTags);
  List<String> get availableTags => List.unmodifiable(_availableTags);
  List<String> get myTags => _myTags;
  List<Trade> get tradeList => _tradeList;
  List<Trade> get postedTrades => _postedTrades;
  bool get isLoading => _isLoading;
  List<Trade> get yourTrades => _yourTrades;

  // Duration setter
  void setDuration(DateTime? end) {
    // _startDate = start;
    _endDate = end;
    notifyListeners();
  }

  void setLoading(bool val) {
    if (_isLoading != val) _isLoading = val;
    notifyListeners();
  }

  Future<void> initializeTradeList() async {
    print('Starting initializeTradeList');
    setLoading(true);
    try {
      var res = supabaseClient.auth.currentUser;
      print('Current user: $res');
      if (res == null) {
        print('No Authenticated user found');
        setLoading(false);
        return;
      }
      print('About to query Supabase');
      var response = await supabaseClient
          .from('Trade')
          .select()
          .eq('tradeProgress', 'TradeProgress.live');
      var ures = await supabaseClient
          .from('Trade')
          .select()
          .eq('clientUserId', res.id);
      var yourTrades = await supabaseClient
          .from('Trade')
          .select()
          .eq('approachee', res.id)
          .eq('tradeProgress', 'TradeProgress.ongoing');
      print('Supabase response received: $response');
      List<Map<String, dynamic>> dbTradeList = response;
      List<Map<String, dynamic>> dbPostedTradeList = ures;
      List<Map<String, dynamic>> dbYourTrades = yourTrades;
      print('Cast response to list');
      for (var trade in dbTradeList) {
        _tradeList.add(Trade.fromJson(trade));
        print('Added trade: ${trade['tradeId']}');
      }

      for (var trade in dbPostedTradeList) {
        _postedTrades.add(Trade.fromJson(trade));
      }

      for (var trade in dbYourTrades) {
        _yourTrades.add(Trade.fromJson(trade));
      }
      print('tradelist : $_tradeList');
      notifyListeners();
    } catch (e) {
      print('Error in initializeTradeList: ${e.toString()}');
      setLoading(false);
    } finally {
      setLoading(false); // Make sure loading is set to false in all cases
    }
  }

  void updateTradeLists() async {
    var res = supabaseClient.auth.currentUser;
    var response = await supabaseClient
        .from('Trade')
        .select()
        .eq('tradeProgress', 'TradeProgress.live');
    var ures = await supabaseClient
        .from('Trade')
        .select()
        .eq('clientUserId', res!.id);
    var yourTrades = await supabaseClient
        .from('Trade')
        .select()
        .eq('approachee', res.id)
        .eq('tradeProgress', 'TradeProgress.ongoing');
    List<Map<String, dynamic>> dbYourTrades = yourTrades;
    List<Map<String, dynamic>> dbTradeList = response;
    List<Map<String, dynamic>> dbPostedTradeList = ures;
    print('Cast response to list');
    _tradeList.clear();
    _postedTrades.clear();
    _yourTrades.clear();
    for (var trade in dbTradeList) {
      _tradeList.add(Trade.fromJson(trade));
      print('Added trade: ${trade['tradeId']}');
    }

    for (var trade in dbPostedTradeList) {
      _postedTrades.add(Trade.fromJson(trade));
    }
    for (var trade in dbYourTrades) {
      _yourTrades.add(Trade.fromJson(trade));
    }
    print('tradelist : $_tradeList');
    notifyListeners();
  }

  // Add a tag
  void addTag(String tag) {
    if (!_selectedTags.contains(tag) && _selectedTags.length < 5) {
      _selectedTags.add(tag);
      notifyListeners();
    }
  }

  Future<String> fetchClientUserName(Trade trade) async {
    final id = trade.clientUserId;
    final res =
        await supabaseClient.from('User').select('name').eq('id', id).single();
    return res['name'];
  }

  Future<String> fetchApproacheeUserName(Trade trade) async {
    final id = trade.approachee;
    final res =
        await supabaseClient.from('User').select('name').eq('id', id).single();
    return res['name'];
  }

  Future<Map> fetchResponseTrade(Trade trade) async {
    final id = trade.responseTradeId;
    // final uid = supabaseClient.auth.currentUser!.id;
    final res =
        await supabaseClient
            .from('Trade')
            .select().eq('tradeId', id!)
            .single();
    print('Response trade: $res');
    return res;
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
        tradeProgress: TradeProgress.live,
        responseTradeId: null,
        approachee: '',
        tradeId: txid,
        heading: heading,
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
        'tradeProgress': newTrade.tradeProgress.toString(),
        'approachee': newTrade.approachee,
        'tags': newTrade.tags,
        'price': newTrade.price,
        'expectedDeliveryTime': newTrade.expectedDeliveryTime,
        'hoursPerDay': newTrade.hoursPerDay,
        // 'urgency': newTrade.urgency,
        'isFav': newTrade.isFav,
      });
      updateTradeLists();
      res = 'Trade Posted';
    } catch (e) {
      return e.toString();
    }
    return res;
  }

  Future<String> createResponseTrade({
    required Trade originalTrade,
    required String heading,
    required String description,
    required List<String> tags,
    required double price,
    required String expectedDeliveryDate,
  }) async {
    String res = 'Some error occurred';
    try {
      // Step 1: Update the original trade's approachee and tradeProgress
      final approacheeId = supabaseClient.auth.currentUser?.id;
      if (approacheeId == null) {
        return 'No authenticated user found';
      }
      String txid = const Uuid().v4();
      await supabaseClient
          .from('Trade')
          .update({
            'approachee': approacheeId,
            'tradeProgress': TradeProgress.negotiation.toString(),
            'responseTradeId': txid, // Set to negotiation
          })
          .eq('tradeId', originalTrade.tradeId);

      // Step 2: Create a new response trade with tradeProgress as negotiation

      final newTrade = Trade(
        tradeProgress: TradeProgress.negotiation,
        responseTradeId: null, // Set to negotiation
        approachee:
            originalTrade
                .clientUserId, // Original creator becomes the approachee
        tradeId: txid,
        heading: heading,
        clientUserId:
            approacheeId, // Current user (approachee) becomes the client
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
        'tradeProgress':
            newTrade.tradeProgress.toString(), // Set to negotiation
        'approachee': newTrade.approachee,
        'tags': newTrade.tags,
        'price': newTrade.price,
        'expectedDeliveryTime': newTrade.expectedDeliveryTime,
        'hoursPerDay': newTrade.hoursPerDay,
        'isFav': newTrade.isFav,
      });

      // Step 3: Update the trade lists to reflect the changes
      updateTradeLists();
      res = 'Response Trade Posted';
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
