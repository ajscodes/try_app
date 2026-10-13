import 'package:expense_tracker_app/utils/color_constants.dart';
import 'package:flutter/material.dart';

class SummaryCardData {
  final String title;
  final double price;
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;

  SummaryCardData({
    required this.title,
    required this.price,
    required this.icon,
    required this.iconColor,
    required this.iconBackgroundColor,
  });
}

class SummaryCard extends StatelessWidget {
  const SummaryCard({super.key, required this.data});

  final SummaryCardData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
        color: data.iconBackgroundColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorConstants.borderColor,)
      ),
      child: Column(
        children: [
          Text(
            data.title,
            style: TextStyle(
              color: data.iconColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            '\$ ${data.price.toStringAsFixed(2)}',
            style: TextStyle(
              overflow: TextOverflow.ellipsis,
              color: data.iconColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: data.iconColor.withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(data.icon, color: data.iconColor, size: 24),
          ),
        ],
      ),
    );
  }
}
