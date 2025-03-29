import 'package:flutter/material.dart';

class TradeCardRFY extends StatelessWidget {
  final Map<String, String> trade;

  const TradeCardRFY({super.key, required this.trade});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
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
                backgroundColor: const Color(0xFF020315),
                child: Text(
                  trade['name']?[0] ?? '',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const Icon(Icons.favorite_border, color: Color(0xff874fff)),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            trade['title'] ?? '',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            trade['description'] ?? '',
            style: const TextStyle(color: Color(0xFF656678), fontSize: 12),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          _buildSkillTags(trade['skills']?.split(', ') ?? []),
        ],
      ),
    );
  }

  Widget _buildSkillTags(List<String> skills) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children:
          skills
              .map(
                (tag) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F1120),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    tag,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
              .toList(),
    );
  }
}
