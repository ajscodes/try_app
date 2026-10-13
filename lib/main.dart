import 'package:expense_tracker_app/utils/color_constants.dart';
import 'package:expense_tracker_app/views/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/add_transaction_provider.dart';
import 'controllers/expense_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ExpenseProvider()),
        ChangeNotifierProvider(create: (context) => AddTransactionProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Expense Tracker App',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: ColorConstants.onPrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            scrolledUnderElevation: 0,
            backgroundColor: ColorConstants.primaryAppBar,
          ),
          primaryColor: ColorConstants.primaryColor,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedIconTheme: IconThemeData(color: ColorConstants.primaryColor),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            foregroundColor: ColorConstants.surfaceColor,
            backgroundColor: ColorConstants.primaryColor,
          ),
        ),
        home: BottomNavigation(),
      ),
    );
  }
}
