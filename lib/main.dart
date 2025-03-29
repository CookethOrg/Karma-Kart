import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karmakart/core/services/image_services.dart';
import 'package:karmakart/core/services/supabase_service.dart';
import 'package:karmakart/providers/authentication_provider.dart';
import 'package:karmakart/providers/trade_provider.dart';
import 'package:karmakart/screens/auth_screens/bio_profile.dart';
import 'package:karmakart/screens/auth_screens/log_in.dart';
import 'package:karmakart/screens/auth_screens/skill_selection.dart';
import 'package:karmakart/screens/auth_screens/verify_details.dart';
import 'package:karmakart/screens/auth_screens/splash.dart';
import 'package:karmakart/screens/create_trade.dart';
import 'package:karmakart/screens/dashboard_page.dart';
import 'package:karmakart/screens/recommended_for_you_page.dart';
import 'package:karmakart/screens/transaction_history.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/auth_screens/sign_up.dart';
import 'providers/transaction_history_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  String supabaseUrl = dotenv.env["SUPABASE_URL"] ?? 'url';
  String supabaseKey = dotenv.env["SUPABASE_KEY"] ?? 'key';
  final instance = await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SupabaseService>(
          create: (_) => SupabaseService(instance.client),
        ),
        ChangeNotifierProxyProvider<SupabaseService, AuthenticationProvider>(
          create:
              (ctx) => AuthenticationProvider(
                Provider.of<SupabaseService>(ctx, listen: false),
              ),
          update:
              (context, supabaseService, previousAuth) =>
                  previousAuth ?? AuthenticationProvider(supabaseService),
        ),
        ChangeNotifierProvider<TradeProvider>(
          create: (_) => TradeProvider(instance.client),
        ),
        ChangeNotifierProvider<TransactionProvider>(
          create: (_) => TransactionProvider(),
        ),
        ChangeNotifierProvider<ImageServices>(
          create: (_) => ImageServices(instance.client),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(844, 390),
      minTextAdapt: true,
      child: MaterialApp(
        title: 'Karma Kart',
        theme: ThemeData(fontFamily: 'Inter'),
        debugShowCheckedModeBanner: false,
        // home: RecommendedForYouPage(),
        home: Splash(),
        // home: LogIn(),
        // home: TradeCreationPage(),
        home: LogIn(),
        // home: VerifyDetails(),
      ),
    );
  }
}
