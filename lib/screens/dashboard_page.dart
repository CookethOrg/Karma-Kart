import 'package:flutter/material.dart';
import 'package:karmakart/providers/authentication_provider.dart';
import 'dart:io';

import 'package:provider/provider.dart';

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
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFF020315),
      drawer: _buildDrawer(),
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
                _buildSearchBar(),
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

  Widget _buildSkillTags(List<String> skills) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children:
            skills
                .map(
                  (tag) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFF0F1120),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
      ),
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

  Widget _buildDrawer() {
    final auth = Provider.of<AuthenticationProvider>(context, listen: false);
    return Drawer(
      backgroundColor: Color(0xFF0F1120),
      child: ListView(
        // Ensures proper scrolling
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF0F1120)),
            accountName: Text(
              auth.firstNameController.text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(
              auth.emailController.text,
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            currentAccountPicture: CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFF0F1120),
              backgroundImage: auth.image != null ? FileImage(auth.image!) : null,
              child:
                  auth.image == null
                      ? Icon(Icons.person, size: 50, color: Color(0xFF656678))
                      : null,
            ),
            otherAccountsPictures: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.close, color: Colors.white),
              ),
            ],
          ),

          _buildDrawerItem(Icons.settings, 'Account Settings'),
          _buildDrawerItem(Icons.support_agent, 'Help & Support'),
          _buildDrawerItem(Icons.privacy_tip, 'Privacy Policy'),
          _buildDrawerItem(Icons.article, 'Terms And Conditions'),
          _buildDrawerItem(Icons.info, 'About'),

          Spacer(),

          ListTile(
            leading: Icon(Icons.logout, color: Colors.white),
            title: Text(
              "Log Out",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              // Handle logout logic
            },
          ),
          SizedBox(height: 16), // Adds some spacing at the bottom
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: TextStyle(color: Colors.white)),
      onTap: () {
        // Handle navigation
      },
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search for trades',
        hintStyle: TextStyle(color: Color(0xFF656678), fontSize: 14),
        prefixIcon: Icon(Icons.search, color: Color(0xFF656678)),
        filled: true,
        fillColor: Color(0xFF0F1120),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
      style: TextStyle(color: Colors.white),
    );
  }

  Widget _buildRecommendedSection() {
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
              style: TextStyle(color: const Color(0xff874fff), fontSize: 12),
            ),
          ],
        ),
        SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children:
                _recommendedTrades
                    .map(
                      (trade) => Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: _buildRecommendedTradeCard(trade),
                      ),
                    )
                    .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendedTradeCard(Map<String, String> trade) {
    return Container(
      width: 250,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff020315), Color(0xff1d1f2e)],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: Color(0xFF020315),
                child: Text(
                  trade['name']?[0] ?? '',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Icon(Icons.favorite_border, color: const Color(0xff874fff)),
            ],
          ),
          SizedBox(height: 12),
          Text(
            trade['title'] ?? '',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            trade['description'] ?? '',
            style: TextStyle(color: Color(0xFF656678), fontSize: 12),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 12),
          _buildSkillTags(trade['skills']?.split(', ') ?? []),
        ],
      ),
    );
  }

  Widget _buildTradesSection() {
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
              style: TextStyle(color: const Color(0xff874fff), fontSize: 12),
            ),
          ],
        ),
        SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children:
                _activeTrades
                    .map(
                      (trade) => Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: _buildTradeCard(trade),
                      ),
                    )
                    .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTradeCard(Map<String, String> trade) {
    return Container(
      width: 250,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff020315), Color(0xff1d1f2e)],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xffffa629).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  trade['status'] ?? '',
                  style: TextStyle(
                    color: const Color(0xffffa629),
                    fontSize: 10,
                  ),
                ),
              ),
              Icon(
                Icons.chat_bubble_outline,
                color: const Color(0xff874fff),
                size: 20,
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            trade['title'] ?? '',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            trade['points'] ?? '',
            style: TextStyle(color: Color(0xFF656678), fontSize: 14),
          ),
        ],
      ),
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
        // Perform some action when the center button is clicked
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
