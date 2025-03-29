import 'package:karmakart/core/services/supabase_service.dart';
import 'package:karmakart/core/utils/state_handler.dart';

class TradeProvider extends StateHandler {
  SupabaseService supabaseService;
  TradeProvider(this.supabaseService) : super();
}
