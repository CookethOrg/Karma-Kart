import 'package:flutter/material.dart';
import 'package:karmakart/core/widgets/bottom_nav_bar.dart';
import 'package:karmakart/core/widgets/dashboard_search_bar.dart';
import 'package:karmakart/core/widgets/drawers/dashboard_drawer.dart';
import 'package:karmakart/core/widgets/trade_card.dart';
import 'package:karmakart/models/trade.dart';
import 'package:karmakart/providers/trade_provider.dart';
import 'package:karmakart/providers/authentication_provider.dart';
import 'package:karmakart/screens/create_trade.dart';
import 'package:karmakart/screens/dashboard_page.dart';
import 'package:karmakart/screens/my_trade_details.dart';
import 'package:karmakart/screens/profile.dart';
import 'package:karmakart/screens/recommended_for_you_page.dart';
import 'package:karmakart/screens/trade_details_page.dart';
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
  int _selectedIndex = 3;
  int selectedTabIndex = 0; // To track which tab is selected

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
                SizedBox(height: 15.h),
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
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
          // Handle navigation logic here
          switch (index) {
            case 0:
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => DashboardPage()));
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
                MaterialPageRoute(builder: (context) => TradeCreationPage()),
              );
            case 3:
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => AllTradesPage()));
            case 4:
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => ProfilePage()));
          }
        },
      ),
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
    bool isSelected = selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTabIndex = index;
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

  Widget _buildTradeCard(Trade trade, int idx) {
    return GestureDetector(
      onTap: () {
        idx == 0
            ? Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TradeDetailsPage(trade: trade),
              ),
            )
            : Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TradeDetails(trade: trade),
              ),
            );
      },
      child: Container(
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
                          trade.tradeProgress.name,
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
                trade.heading,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              Text(
                trade.price.toString(),
                style: TextStyle(color: Color(0xFF656678), fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTradesList() {
    // Choose which data to display based on selected tab
    final TradeProvider tp = Provider.of<TradeProvider>(context, listen: false);
    final dataToDisplay =
        selectedTabIndex == 0 ? tp.yourTrades : tp.postedTrades;

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
      children:
          dataToDisplay
              .map((trade) => _buildTradeCard(trade, selectedTabIndex))
              .toList(),
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
}
