import 'package:flutter/material.dart';
import 'package:karmakart/core/widgets/dashboard_search_bar.dart';
import 'package:karmakart/core/widgets/drawers/dashboard_drawer.dart';
import 'package:karmakart/core/widgets/trade_card.dart';
import 'package:karmakart/providers/trade_provider.dart';
import 'package:karmakart/providers/authentication_provider.dart';
import 'package:karmakart/screens/create_trade.dart';
import 'package:karmakart/screens/dashboard_page.dart';
import 'package:provider/provider.dart';
import 'package:radix_icons/radix_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllTradesPage extends StatefulWidget {
  const AllTradesPage({super.key});
  @override
  State<AllTradesPage> createState() => _AllTradesPageState();
}

class _AllTradesPageState extends State<AllTradesPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  int _selectedTabIndex = 0; // To track which tab is selected

  // Sample data for "Your trades" tab
  final List<Map<String, String>> _yourTrades = [
    {
      'title': 'React Website Developer',
      'points': '200 karma points',
      'status': 'Ongoing',
    },
    {
      'title': 'UI/UX Designer Needed',
      'points': '150 karma points',
      'status': 'Ongoing',
    },
    {
      'title': 'Flutter App Development',
      'points': '300 karma points',
      'status': 'Ongoing',
    },
  ];

  // Sample data for "Posted by you" tab
  final List<Map<String, String>> _postedByYou = [
    {
      'title': 'Node.js Backend Developer',
      'points': '250 karma points',
      'status': 'Ongoing',
    },
    {
      'title': 'Python Data Analysis',
      'points': '180 karma points',
      'status': 'Ongoing',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFF020315),
      drawer: DashboardDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                _buildTopBar(),
                SizedBox(height: 24.h),
                _buildHeader(),
                SizedBox(height: 12.h),
                _buildSearchBar(),
                SizedBox(height: 20.h),
                _buildTabs(),
                SizedBox(height: 20.h),
                _buildTradesList(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "All Trades",
          style: TextStyle(
            color: Colors.white,
            fontSize: 32.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4),
        Text(
          "View all the trades you are currently on",
          style: TextStyle(color: Color(0xFF656678), fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF0F1120),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(Icons.search, color: Color(0xFF656678)),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search in All trades",
                hintStyle: TextStyle(color: Color(0xFF656678)),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Row(
      children: [
        _buildTab("Your trades", 0),
        SizedBox(width: 20),
        _buildTab("Posted by you", 1),
      ],
    );
  }

  Widget _buildTab(String title, int index) {
    bool isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
          SizedBox(height: 8),
          Container(
            height: 3,
            width: 90.w,
            decoration: BoxDecoration(
              color: isSelected ? Colors.purple : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTradeCard(Map<String, String> trade) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Color(0xFF0F1120),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.circle, color: Colors.amber, size: 8),
                      SizedBox(width: 4),
                      Text(
                        trade['status'] ?? "Ongoing",
                        style: TextStyle(color: Colors.amber, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.chat_bubble_outline,
                  color: Colors.white.withOpacity(0.5),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              trade['title'] ?? "Trade Title",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            Text(
              trade['points'] ?? "Karma points",
              style: TextStyle(color: Color(0xFF656678), fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTradesList() {
    // Choose which data to display based on selected tab
    final dataToDisplay = _selectedTabIndex == 0 ? _yourTrades : _postedByYou;

    if (dataToDisplay.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(top: 40.h),
          child: Text(
            "No trades available",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      );
    }

    return Column(
      children: dataToDisplay.map((trade) => _buildTradeCard(trade)).toList(),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
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
              borderRadius: BorderRadius.circular(8.r),
            ),
            padding: EdgeInsets.all(8.w),
            child: Icon(RadixIcons.Arrow_Left, color: Colors.white, size: 55.w),
          ),
        ),
      ],
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
      },
      child: Container(
        decoration: BoxDecoration(color: Colors.purple, shape: BoxShape.circle),
        padding: const EdgeInsets.all(8.0),
        child: Icon(Icons.add, color: Colors.white),
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
