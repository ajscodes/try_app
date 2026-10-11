import 'package:expense_tracker_app/controllers/expense_provider.dart';
import 'package:expense_tracker_app/utils/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/transaction_model.dart';
import '../../utils/category_icon.dart';
import '../../utils/color_constants.dart';
import '../transaction/transaction_detail_screen.dart';

class TransactionCard extends StatelessWidget {
  final String transactionId;

  const TransactionCard({super.key, required this.transactionId});

  @override
  Widget build(BuildContext context) {
    final exp = Provider.of<ExpenseProvider>(context, listen: false);

    final TransactionModel transaction = exp.transactions.firstWhere(
      (t) => t.id == transactionId,
    );

    final isIncome = transaction.transactionType == TransactionType.income;
    final amountColor = isIncome
        ? ColorConstants.incomeColor
        : ColorConstants.expenseColor;
    final prefix = isIncome ? '+' : '-';

    final categoryColor = ColorConstants.getCategoryColor(transaction.category);
    final categoryIcon = CategoryIcon.getCategoryIcon(transaction.category);

    return Card(
      elevation: 0,
      color: ColorConstants.surfaceColor,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(color: ColorConstants.borderSecondary),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  TransactionDetailScreen(transactionID: transactionId),
            ),
          );
        },
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: categoryColor.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(categoryIcon, color: categoryColor, size: 24),
        ),
        title: Text(
          transaction.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: RichText(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            children: [
              TextSpan(
                text: transaction.category,
                style: TextStyle(
                  color: categoryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
              TextSpan(
                text: '  •  ',
                style: TextStyle(
                  color: ColorConstants.onSecondaryColor,
                  fontSize: 12,
                ),
              ),
              TextSpan(
                text: DateFormat(AddTransactionConstants.dateFormate)
                    .format(transaction.date),
                style: TextStyle(
                  color: ColorConstants.onSecondaryColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$prefix\$${transaction.amount.toStringAsFixed(2)}',
              style: TextStyle(
                color: amountColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.chevron_right,
              color: ColorConstants.onSecondaryColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
