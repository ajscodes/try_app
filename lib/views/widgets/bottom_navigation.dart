import 'package:expense_tracker_app/views/home/home_screen.dart';
import 'package:expense_tracker_app/views/report/report_screen.dart';
import 'package:expense_tracker_app/views/setting/setting_screen.dart';
import 'package:expense_tracker_app/views/transaction/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/expense_provider.dart';
import '../../utils/color_constants.dart';
import '../../utils/string_constants.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  static final List<Widget> _screens = [
    const HomeScreen(),
    const TransactionList(),
    const ReportScreen(),
    const SettingScreen()
  ];

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    final expenseProvider = context.watch<ExpenseProvider>();
    final selectedIndex = expenseProvider.currentNavIndex;

    return Scaffold(
      backgroundColor: ColorConstants.secondaryColor,
      body: IndexedStack(
        index: selectedIndex,
        children: BottomNavigation._screens,
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: ColorConstants.primaryColor,
          backgroundColor: ColorConstants.bottomNavigationBackGroundColor,
          currentIndex: selectedIndex,
          onTap: (index) {
            context.read<ExpenseProvider>().updateNavIndex(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_filled),
              label: BottomNavigationBarScreenConstants.bottomNavigationLabel1,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.list),
              label: BottomNavigationBarScreenConstants.bottomNavigationLabel2,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.pie_chart_rounded),
              label: BottomNavigationBarScreenConstants.bottomNavigationLabel3,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: BottomNavigationBarScreenConstants.bottomNavigationLabel4,
            ),
          ],
        ),
      ),
    );
  }
}
