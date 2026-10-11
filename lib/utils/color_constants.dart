import 'package:flutter/material.dart';

abstract class ColorConstants {
  static final Color primaryColor = Colors.green;
  static final Color secondaryColor = Colors.grey.shade100;
  static final Color onPrimaryColor = Colors.black;
  static final Color onSecondaryColor = Colors.grey;
  static final Color surfaceColor = Colors.white;
  static final Color linkColor = Colors.blue;
  static final Color linkColorSecondary = Colors.blue.shade200;
  static final Color linkColorOnPrimary = Colors.blue.shade50;
  static final Color bottomNavigationBackGroundColor = Colors.white70;
  static final Color primaryAppBar = Colors.white30;
  static final Color textSecondary = Colors.blueGrey;
  static final Color borderColor = Colors.grey.shade300;
  static final Color borderSecondary = Colors.grey.shade200;
  static final Color redPrimary = Colors.red;
  static final Color redSecondary = Colors.red.shade200;

  //category
  static final Color salaryColor = Colors.green;
  static final Color foodColor = Colors.deepOrange;
  static final Color fuelColor = Colors.amber;
  static final Color billColor = Colors.pink;
  static final Color entertainmentColor = Colors.blueAccent;
  static final Color travelColor = Colors.teal;

  //summary_card
  static final Color totalBalanceIconPrimaryColor = Colors.green.shade400;
  static final Color totalBalanceIconSecondaryColor = Colors.green.shade200;
  static final Color totalIncomeIconPrimaryColor = Colors.blue.shade400;
  static final Color totalIncomeIconSecondaryColor = Colors.blue.shade200;
  static final Color totalExpenseIconPrimaryColor = Colors.red.shade400;

  //income-Expense
  static Color incomeColor = Colors.green.shade600;
  static Color expenseColor = Colors.red.shade600;
  static Color incomeLabelIconBackGround = Colors.green.shade50;
  static Color expenseLabelIconBackGround = Colors.red.shade50;

  //setting_screen
  static final Color settingScreenCurrencyIcon = Colors.purple;
  static final Color settingScreenOrangeIcon = Colors.orange;
  static final Color settingScreenClearAllButton = Colors.red;
  static final Color settingScreenClearAllButtonBorder = Colors.red.shade200;
  static final Color settingScreenClearAllWarning = Colors.red.shade50;
  static final Color settingScreenClearAllSubText = Colors.red.shade800;


  //Category
  static Color getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'salary':
        return salaryColor;
      case 'freelance':
        return Colors.purple;
      case 'bonus':
        return Colors.blue;
      case 'food':
        return foodColor;
      case 'fuel':
        return fuelColor;
      case 'shopping':
        return billColor;
      case 'bills':
        return billColor;
      case 'entertainment':
        return entertainmentColor;
      case 'travel':
        return travelColor;
      case 'medical':
        return expenseColor;
      default:
        return Colors.grey.shade600;
    }
  }
}