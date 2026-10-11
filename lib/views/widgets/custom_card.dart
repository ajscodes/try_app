import 'package:expense_tracker_app/utils/color_constants.dart';
import 'package:flutter/material.dart';

class CustomCardData {
  final List<Widget> items;

  CustomCardData({required this.items});
}

class CustomCard extends StatelessWidget {
  final CustomCardData data;
  const CustomCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorConstants.borderColor),
      ),
      child: Column(
        children: data.items,
      ),
    );
  }
}
