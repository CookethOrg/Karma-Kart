import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karmakart/models/trade.dart';

enum TradeCardType {
  recommended,
  active
}

class TradeCard extends StatelessWidget {
  final Trade trade;
  final TradeCardType cardType;

  const TradeCard({
    super.key,
    required this.trade,
    required this.cardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 700.w,
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
            children: _buildHeaderContent(),
          ),
          SizedBox(height: cardType == TradeCardType.recommended ? 12 : 16),
          Text(
            trade.heading,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          _buildCardBody(),
          if (cardType == TradeCardType.recommended) ...[
            SizedBox(height: 12),
            _buildSkillTags(trade.tags),
          ],
        ],
      ),
    );
  }

  List<Widget> _buildHeaderContent() {
    if (cardType == TradeCardType.recommended) {
      return [
        CircleAvatar(
          backgroundColor: Color(0xFF020315),
          child: Text(
            trade.heading[0],
            style: TextStyle(color: Colors.white),
          ),
        ),
        Icon(Icons.favorite_border, color: const Color(0xff874fff)),
      ];
    } else {
      return [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xffffa629).withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            trade.tradeProgress.toString(),
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
      ];
    }
  }

  Widget _buildCardBody() {
    if (cardType == TradeCardType.recommended) {
      return Text(
        trade.description,
        style: TextStyle(color: Color(0xFF656678), fontSize: 12),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );
    } else {
      return Text(
        trade.price.toString(),
        style: TextStyle(color: Color(0xFF656678), fontSize: 14),
      );
    }
  }

  Widget _buildSkillTags(List<String> skills) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: skills
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
}