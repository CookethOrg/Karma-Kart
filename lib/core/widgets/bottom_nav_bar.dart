import 'package:flutter/material.dart';
import 'package:karmakart/screens/create_trade.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF0F1120),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navBarItem(context, Icons.home, "Home", 0),
            _navBarItem(context, Icons.list, "Recommended", 1),
            _centerActionButton(context),
            _navBarItem(context, Icons.work, 'All Trades', 3),
            _navBarItem(context, Icons.person, 'Profile', 4)
          ],
        ),
      ),
    );
  }

  Widget _navBarItem(BuildContext context, IconData icon, String label, int index) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        onItemSelected(index);
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

  Widget _centerActionButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => TradeCreationPage())
        );
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
}