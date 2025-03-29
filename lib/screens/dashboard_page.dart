import 'package:flutter/material.dart';
import 'package:karmakart/core/widgets/dashboard_search_bar.dart';
import 'package:karmakart/core/widgets/drawers/dashboard_drawer.dart';
import 'package:karmakart/core/widgets/trade_card.dart';
import 'package:karmakart/models/trade.dart';
import 'package:karmakart/providers/authentication_provider.dart';
import 'package:karmakart/providers/trade_provider.dart';
import 'package:karmakart/screens/create_trade.dart';
import 'package:provider/provider.dart';
import 'recommended_for_you_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<TradeProvider>(
      builder: (context, tp, child) {
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
                    SizedBox(height: 24),
                    _buildGreetingSection("Daniel"),
                    SizedBox(height: 24),
                    DashboardSearchBar(),
                    SizedBox(height: 24),
                    _buildRecommendedSection(),
                    SizedBox(height: 24),
                    _buildTradesSection(),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: _buildBottomNavBar(),
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
        SizedBox(height: 4),
        Text(
          "You have new notifications!",
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
                Text(
                  'View More >',
                  style: TextStyle(
                    color: const Color(0xff874fff),
                    fontSize: 12,
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
                          (trade) => Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: TradeCard(
                              trade: trade,
                              cardType: TradeCardType.recommended,
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
                  'Your Trades',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'View More >',
                  style: TextStyle(
                    color: const Color(0xff874fff),
                    fontSize: 12,
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

  Widget _buildBottomNavBar() {
    return Container(
      color: Color(0xFF0F1120),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navBarItem(Icons.home, "Home", 0),
            _navBarItem(Icons.sync, "Sync", 1),
            _centerActionButton(),
          ],
        ),
      ),
    );
  }

  Widget _navBarItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        _onNavItemTapped(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isSelected ? Colors.white : Color(0xFF656678)),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Color(0xFF656678),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _centerActionButton() {
    return GestureDetector(
      onTap: () {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => TradeCreationPage()));
        print("Center button tapped!");
      },
      child: Container(
        decoration: BoxDecoration(color: Colors.purple, shape: BoxShape.circle),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  void _onNavItemTapped(int index) {
    // Handle navigation logic here
    switch (index) {
      case 0:
        print("Navigating to Home");
        break;
      case 1:
        print("Navigating to Sync");
        break;
    }
  }
}
