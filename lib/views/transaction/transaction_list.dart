import 'package:expense_tracker_app/controllers/expense_provider.dart';
import 'package:expense_tracker_app/utils/string_constants.dart';
import 'package:expense_tracker_app/views/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/color_constants.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
      builder: (context, prov, child) {
        return Scaffold(
          backgroundColor: ColorConstants.secondaryColor,
          appBar: AppBar(
            title: Text(TransactionListConstants.appBarTitle),
            backgroundColor: ColorConstants.surfaceColor,
          ),

          body: Column(
            children: [
              SizedBox(height: 5,),
              Expanded(
                child: prov.transactions.isEmpty
                    ? Center(
                        child: Text(
                          TransactionListConstants.noTransactions,
                          style: TextStyle(
                            color: ColorConstants.onPrimaryColor,
                            fontSize: 22,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: prov.transactions.length,
                        itemBuilder: (context, index) {
                          int reversedIndex = prov.transactions.length - index - 1;
                          return TransactionCard(
                            transactionId: prov.transactions[reversedIndex].id,
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
