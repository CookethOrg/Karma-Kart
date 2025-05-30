import 'package:flutter/material.dart';
import 'package:karmakart/core/widgets/bottom_nav_bar.dart';
import 'package:karmakart/core/widgets/dashboard_search_bar.dart';
import 'package:karmakart/core/widgets/drawers/dashboard_drawer.dart';
import 'package:karmakart/core/widgets/trade_card.dart';
import 'package:karmakart/providers/trade_provider.dart';
import 'package:karmakart/screens/all_trades_page.dart';
import 'package:karmakart/screens/profile.dart';
import 'package:karmakart/screens/trade_details_page.dart';
import '../core/widgets/trade_card_rfy.dart';
import 'package:karmakart/providers/authentication_provider.dart';
import 'package:karmakart/screens/create_trade.dart';
import 'package:karmakart/screens/dashboard_page.dart';
import 'package:provider/provider.dart';
import 'package:radix_icons/radix_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecommendedForYouPage extends StatefulWidget {
  const RecommendedForYouPage({super.key});

  @override
  State<RecommendedForYouPage> createState() => _RecommendedForYouPageState();
}

class _RecommendedForYouPageState extends State<RecommendedForYouPage> {
  final List<Map<String, String>> _recommendedTrades = [
    {
      'name': 'Kat Dunphy',
      'title': 'React Website Developer',
      'description':
          'I need a react developer who can code my static portfolio website',
      'skills': 'Web Development, React',
    },
    {
      'name': 'Kat Dunphy',
      'title': 'React Website',
      'description': 'I need a react developer who can code my static',
      'skills': 'Web Development, React',
    },
    {
      'name': 'Kat Dunphy',
      'title': 'React Website Developer',
      'description':
          'I need a react developer who can code my static portfolio website',
      'skills': 'Web Development, React',
    },
    {
      'name': 'Kat Dunphy',
      'title': 'React Website',
      'description': 'I need a react developer who can code my static',
      'skills': 'Web Development, React',
    },
    {
      'name': 'Kat Dunphy',
      'title': 'React Website Developer',
      'description':
          'I need a react developer who can code my static portfolio website',
      'skills': 'Web Development, React',
    },
    {
      'name': 'Kat Dunphy',
      'title': 'React Website',
      'description': 'I need a react developer who can code my static',
      'skills': 'Web Development, React',
    },
    {
      'name': 'Kat Dunphy',
      'title': 'React Website Developer',
      'description':
          'I need a react developer who can code my static portfolio website',
      'skills': 'Web Development, React',
    },
    {
      'name': 'Kat Dunphy',
      'title': 'React Website',
      'description': 'I need a react developer who can code my static',
      'skills': 'Web Development, React',
    },
    {
      'name': 'Kat Dunphy',
      'title': 'React Website Developer',
      'description':
          'I need a react developer who can code my static portfolio website',
      'skills': 'Web Development, React',
    },
    {
      'name': 'Kat Dunphy',
      'title': 'React Website',
      'description': 'I need a react developer who can code my static',
      'skills': 'Web Development, React',
    },
    {
      'name': 'Kat Dunphy',
      'title': 'React Website Developer',
      'description':
          'I need a react developer who can code my static portfolio website',
      'skills': 'Web Development, React',
    },
    {
      'name': 'Kat Dunphy',
      'title': 'React Website',
      'description': 'I need a react developer who can code my static',
      'skills': 'Web Development, React',
    },
    {
      'name': 'Kat Dunphy',
      'title': 'React Website Developer',
      'description':
          'I need a react developer who can code my static portfolio website',
      'skills': 'Web Development, React',
    },
    {
      'name': 'Kat Dunphy',
      'title': 'React Website',
      'description': 'I need a react developer who can code my static',
      'skills': 'Web Development, React',
    },
  ];

  final List<Map<String, String>> _activeTrades = [
    {
      'title': 'React Website Developer',
      'points': '200 Karma points',
      'status': 'Ongoing',
    },
    {'title': 'React Websi', 'points': '200 Karma points', 'status': 'Ongoing'},
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTopBar(),
                SizedBox(height: 24.h),
                _buildGreetingSection(),
                SizedBox(height: 12.h),
                DashboardSearchBar(),
                SizedBox(height: 12.h),
                _buildRecommendedSection(),
              ],
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
  }

  Widget _buildGreetingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Recommended for You",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 42.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4),
        Text(
          "Active Trades, Just for you!",
          style: TextStyle(color: Color(0xFF656678), fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            // Navigate back to DashboardPage
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => DashboardPage()),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff020315), Color(0xff1d1f2e)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
              borderRadius: BorderRadius.circular(8.r), // Make responsive
            ),
            padding: EdgeInsets.all(8.w), // Make responsive
            child: Icon(
              RadixIcons.Arrow_Left, // Corrected case (lowercase)
              color: Colors.white,
              size: 54.w, // Make responsive
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendedSection() {
    return Consumer<TradeProvider>(
      builder: (context, tp, child) {
        return Center(
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
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
                                padding: EdgeInsets.only(right: 20.w),
                                child: TradeCard(
                                  trade: trade,
                                  cardType: TradeCardType.recommended,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                  // _recommendedTrades
                  //     .map(
                  //       (trade) => Padding(
                  //         padding: EdgeInsets.only(right: 20.w),
                  //         child: TradeCardRFY(trade: trade),
                  //       ),
                  //     )
                  //     .toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  
}
