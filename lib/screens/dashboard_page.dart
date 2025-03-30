import 'package:flutter/material.dart';
import 'package:karmakart/core/services/supabase_service.dart';
import 'package:karmakart/core/widgets/bottom_nav_bar.dart';
import 'package:karmakart/core/widgets/dashboard_search_bar.dart';
import 'package:karmakart/core/widgets/drawers/dashboard_drawer.dart';
import 'package:karmakart/core/widgets/trade_card.dart';
import 'package:karmakart/models/trade.dart';
import 'package:karmakart/providers/authentication_provider.dart';
import 'package:karmakart/providers/trade_provider.dart';
import 'package:karmakart/screens/all_trades_page.dart';
import 'package:karmakart/screens/create_trade.dart';
import 'package:karmakart/screens/profile.dart';
import 'package:karmakart/screens/trade_details_page.dart';
import 'package:provider/provider.dart';
import 'recommended_for_you_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer2<TradeProvider, SupabaseService>(
      builder: (context, tp, sp, child) {
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: Color(0xFF020315),
          drawer: DashboardDrawer(),
          body: SafeArea(
            top: true,
            minimum: EdgeInsets.only(top: 20), // Added top padding here
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: FutureBuilder(
                  future: sp.fetchCurrentUserName(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox();
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    }
                    var user = snapshot.data;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTopBar(),
                        SizedBox(height: 24),
                        _buildGreetingSection(user?['name']),
                        SizedBox(height: 24),
                        DashboardSearchBar(),
                        SizedBox(height: 24),
                        _buildRecommendedSection(),
                        SizedBox(height: 24),
                        _buildTradesSection(),
                        SizedBox(height: 24,),
                        _buildYourTradesSection()
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
          bottomNavigationBar: CustomBottomNavBar(
            selectedIndex: _selectedIndex,
            onItemSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
              // Handle navigation logic here
              switch (index) {
                case 0:
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => DashboardPage()),
                  );
                  print("Navigating to Home");
                  break;
                case 1:
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RecommendedForYouPage(),
                    ),
                  );
                  print("Navigating to Sync");
                  break;
                case 2:
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TradeCreationPage(),
                    ),
                  );
                case 3:
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AllTradesPage()),
                  );
                case 4:
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
              }
            },
          ),
        );
      },
    );
  }

  Widget _buildGreetingSection(String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Good Morning, ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        // SizedBox(height: 4),
        // Text(
        //   "You have new notifications!",
        //   style: TextStyle(color: Color(0xFF656678), fontSize: 14),
        // ),
      ],
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => _scaffoldKey.currentState?.openDrawer(),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff020315), Color(0xff1d1f2e)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.all(8),
            child: Icon(Icons.menu, color: Colors.white),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff020315), Color(0xff1d1f2e)],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.all(8),
          child: Stack(
            children: [
              Icon(Icons.notifications_none_outlined, color: Colors.white),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendedSection() {
    return Consumer<TradeProvider>(
      builder: (context, tp, child) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recommended for you',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                InkWell(
                  onTap:
                      () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RecommendedForYouPage(),
                        ),
                      ),
                  child: Text(
                    'View More >',
                    style: TextStyle(
                      color: const Color(0xff874fff),
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    tp.tradeList
                        .map(
                          (trade) => GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          TradeDetailsPage(trade: trade),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: TradeCard(
                                trade: trade,
                                cardType: TradeCardType.recommended,
                              ),
                            ),
                          ),
                        )
                        .toList(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTradesSection() {
    return Consumer<TradeProvider>(
      builder: (context, tp, child) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Posted Trades',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AllTradesPage()),
                    );
                  },
                  child: Text(
                    'View More >',
                    style: TextStyle(
                      color: const Color(0xff874fff),
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    tp.postedTrades
                        .map(
                          (trade) => Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: TradeCard(
                              trade: trade,
                              cardType: TradeCardType.active,
                            ),
                          ),
                        )
                        .toList(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildYourTradesSection() {
    return Consumer<TradeProvider>(
      builder: (context, tp, child) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your Trades',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AllTradesPage()),
                    );
                  },
                  child: Text(
                    'View More >',
                    style: TextStyle(
                      color: const Color(0xff874fff),
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    tp.yourTrades
                        .map(
                          (trade) => Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: TradeCard(
                              trade: trade,
                              cardType: TradeCardType.active,
                            ),
                          ),
                        )
                        .toList(),
              ),
            ),
          ],
        );
      },
    );
  }

  // Widget _centerActionButton() {
  //   return GestureDetector(
  //     onTap: () {
  //       Navigator.of(
  //         context,
  //       ).push(MaterialPageRoute(builder: (context) => TradeCreationPage()));
  //       print("Center button tapped!");
  //     },
  //     child: Container(
  //       decoration: BoxDecoration(color: Colors.purple, shape: BoxShape.circle),
  //       child: Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Icon(Icons.add, color: Colors.white),
  //       ),
  //     ),
  //   );
  // }
}
