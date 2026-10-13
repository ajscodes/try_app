import 'package:expense_tracker_app/models/transaction_model.dart';
import 'package:expense_tracker_app/utils/color_constants.dart';
import 'package:expense_tracker_app/utils/string_constants.dart';
import 'package:expense_tracker_app/views/widgets/summary_card.dart';
import 'package:expense_tracker_app/views/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/expense_provider.dart';
import '../transaction/add_transaction_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
      builder: (context, provider, child) {
        bool isSearching =
            provider.searchQuery.isNotEmpty || provider.filterType != null;
        List<TransactionModel> displayList = isSearching
            ? provider.searchTransactionsList
            : provider.recentTransaction;

        return Scaffold(
          backgroundColor: ColorConstants.secondaryColor,
          appBar: AppBar(
            backgroundColor: ColorConstants.secondaryColor,
            title: Text(
              HomeScreenConstants.homeScreenAppBarTitle,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            //leading: Icon(Icons.menu),
            actions: [
              IconButton(
                onPressed: () {
                  provider.updateNavIndex(3);
                },
                icon: Icon(Icons.settings_outlined),
              ),
            ],
          ),
          body: SafeArea(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constrains) {
                if (constrains.maxWidth > 600) {
                  return Center();
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 8,
                        ),
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _searchController,
                                  onChanged: (value) {
                                    provider.searchTransaction(value.trim());
                                  },
                                  decoration: InputDecoration(
                                    hintText: HomeScreenConstants
                                        .homeScreenSearchHintText,
                                    prefixIcon: Icon(Icons.search),

                                    fillColor: ColorConstants.surfaceColor,
                                    filled: true,
                                    contentPadding: EdgeInsets.symmetric(),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: ColorConstants.borderColor,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: ColorConstants.borderColor,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: ColorConstants.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: ColorConstants.surfaceColor,
                                  border: Border.all(
                                    color: ColorConstants.borderColor,
                                  ),
                                ),
                                child: PopupMenuButton<String>(
                                  icon: Icon(
                                    Icons.filter_alt_outlined,
                                    color: provider.filterType != null
                                        ? ColorConstants.primaryColor
                                        : ColorConstants.onPrimaryColor,
                                  ),
                                  initialValue: provider.filterType == null
                                      ? HomeScreenConstants.homeScreenFilterAll
                                      : provider.filterType ==
                                            TransactionType.income
                                      ? HomeScreenConstants
                                            .homeScreenFilterIncome
                                      : HomeScreenConstants
                                            .homeScreenFilterExpense,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  color: ColorConstants.surfaceColor,
                                  onSelected: (String value) {
                                    if (value ==
                                        HomeScreenConstants
                                            .homeScreenFilterIncome) {
                                      provider.filterTransaction(
                                        TransactionType.income,
                                      );
                                    } else if (value ==
                                        HomeScreenConstants
                                            .homeScreenFilterExpense) {
                                      provider.filterTransaction(
                                        TransactionType.expense,
                                      );
                                    } else {
                                      provider.filterTransaction(null);
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      value: HomeScreenConstants
                                          .homeScreenFilterAll,
                                      child: Text(
                                        HomeScreenConstants.homeScreenFilterAll,
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: HomeScreenConstants
                                          .homeScreenFilterIncome,
                                      child: Text(
                                        HomeScreenConstants
                                            .homeScreenFilterIncome,
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: HomeScreenConstants
                                          .homeScreenFilterExpense,
                                      child: Text(
                                        HomeScreenConstants
                                            .homeScreenFilterExpense,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      //summary_card
                      Padding(
                        padding: EdgeInsetsGeometry.symmetric(horizontal: 12),
                        child: Row(
                          spacing: 8,
                          children: <Widget>[
                            Expanded(
                              child: SummaryCard(
                                data: SummaryCardData(
                                  title: HomeScreenConstants.homeScreenCardTitle1,
                                  price: provider.totalBalance,
                                  icon: Icons.account_balance_wallet_outlined,
                                  iconColor:
                                      ColorConstants.totalBalanceIconPrimaryColor,
                                  iconBackgroundColor: ColorConstants
                                      .totalBalanceIconSecondaryColor,
                                ),
                              ),
                            ),

                            Expanded(
                              child: SummaryCard(
                                data: SummaryCardData(
                                  title: HomeScreenConstants.homeScreenCardTitle2,
                                  price: provider.totalIncome,
                                  icon: Icons.arrow_circle_down_sharp,
                                  iconColor:
                                      ColorConstants.totalIncomeIconPrimaryColor,
                                  iconBackgroundColor:
                                      ColorConstants.linkColorSecondary,
                                ),
                              ),
                            ),

                            Expanded(
                              child: SummaryCard(
                                data: SummaryCardData(
                                  title: HomeScreenConstants.homeScreenCardTitle3,
                                  price: provider.totalExpense,
                                  icon: Icons.arrow_circle_up,
                                  iconColor:
                                      ColorConstants.totalExpenseIconPrimaryColor,
                                  iconBackgroundColor:
                                      ColorConstants.redSecondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              HomeScreenConstants
                                  .homeScreenRecentTransactionLabel,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton.icon(
                              onPressed: provider.transactions.isEmpty ? null : () =>
                                provider.updateNavIndex(1),
                              label: Text(
                                HomeScreenConstants
                                    .homeScreenViewAllTransaction,
                                style: TextStyle(
                                  color: provider.transactions.isEmpty ? ColorConstants.greyDisable : ColorConstants.linkColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              icon: Icon(
                                Icons.chevron_right,
                                color: provider.transactions.isEmpty ? ColorConstants.greyDisable : ColorConstants.linkColor,
                              ),
                              iconAlignment: IconAlignment.end,
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: CustomScrollView(
                          physics: displayList.isEmpty
                              ? NeverScrollableScrollPhysics()
                              : AlwaysScrollableScrollPhysics(),
                          slivers: [
                            provider.searchTransactionsList.isEmpty
                                ? SliverFillRemaining(
                                    hasScrollBody: false,
                                    child: Center(
                                      child: Text(
                                        HomeScreenConstants
                                            .homeScreenNoTransaction,
                                        style: TextStyle(
                                          color:
                                              ColorConstants.onSecondaryColor,
                                        ),
                                      ),
                                    ),
                                  )
                                : SliverList.builder(
                                    itemBuilder: (context, index) {
                                      return TransactionCard(
                                        transactionId: displayList[index].id,
                                      );
                                    },
                                    itemCount: displayList.length,
                                  ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),

          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTransactionScreen()),
              );
            },
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}
