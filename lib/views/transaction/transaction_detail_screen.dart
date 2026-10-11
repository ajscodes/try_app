import 'package:expense_tracker_app/controllers/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../models/transaction_model.dart';
import '../../utils/category_icon.dart';
import '../../utils/color_constants.dart';
import '../../utils/string_constants.dart';
import '../widgets/alert_dialogue.dart';
import 'add_transaction_screen.dart';

class TransactionDetailScreen extends StatelessWidget {
  final String transactionID;

  const TransactionDetailScreen({super.key, required this.transactionID});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ExpenseProvider>(context, listen: false);

    final TransactionModel transaction = prov.transactions.firstWhere((t) => t.id == transactionID);

    final isIncome = transaction.transactionType == TransactionType.income;
    final amountColor = isIncome
        ? ColorConstants.incomeColor
        : ColorConstants.expenseColor;
    final prefix = isIncome ? '+' : '-';

    final categoryColor = ColorConstants.getCategoryColor(transaction.category);
    final categoryIcon = CategoryIcon.getCategoryIcon(transaction.category);

    return Consumer<ExpenseProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: ColorConstants.surfaceColor,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: ColorConstants.onPrimaryColor,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              TransactionDetailConstants.transactionDetailAppBarTitle,
              style: TextStyle(
                color: ColorConstants.onPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: ColorConstants.surfaceColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: ColorConstants.borderSecondary,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: ColorConstants.borderColor.withValues(
                                alpha: 0.05,
                              ),
                              spreadRadius: 2,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: isIncome
                                    ? ColorConstants.incomeLabelIconBackGround
                                    : ColorConstants.expenseLabelIconBackGround,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                              ),
                            ),

                            Container(
                              padding: const EdgeInsets.only(
                                top: 40,
                                bottom: 24,
                                left: 16,
                                right: 16,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    isIncome
                                        ? AddTransactionConstants
                                              .addTransactionCardLabel1
                                        : AddTransactionConstants
                                              .addTransactionCardLabel2,
                                    style: TextStyle(
                                      color: amountColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    transaction.title,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: ColorConstants.onPrimaryColor,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '$prefix\$${transaction.amount.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: amountColor,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: ColorConstants.borderSecondary,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.calendar_today_outlined,
                                          size: 14,
                                          color:
                                              ColorConstants.onSecondaryColor,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          DateFormat(
                                            TransactionDetailConstants
                                                .transactionDetailDateFormate,
                                          ).format(transaction.date),
                                          style: TextStyle(
                                            color:
                                                ColorConstants.onSecondaryColor,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Positioned(
                        top: 36,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: ColorConstants.surfaceColor,
                            shape: BoxShape.circle,
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: categoryColor.withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              categoryIcon,
                              color: categoryColor,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  const Text(
                    TransactionDetailConstants
                        .transactionDetailTransactionInformation,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 6),

                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorConstants.borderSecondary),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        _buildInfoRow(
                          Icons.label_outline,
                          Colors.green,
                          AddTransactionConstants.addTransactionTitle,
                          transaction.title,
                        ),
                        const Divider(height: 1),
                        _buildInfoRow(
                          Icons.attach_money,
                          Colors.blue,
                          AddTransactionConstants.addTransactionAmount,
                          '$prefix\$${transaction.amount.toStringAsFixed(2)}',
                          amountColor,
                        ),
                        const Divider(height: 1),
                        _buildInfoRow(
                          Icons.swap_horiz,
                          Colors.purple,
                          TransactionDetailConstants.transactionDetailType,
                          isIncome
                              ? AddTransactionConstants.addTransactionCardLabel1
                              : AddTransactionConstants
                                    .addTransactionCardLabel2,
                          amountColor,
                        ),
                        const Divider(height: 1),
                        _buildInfoRow(
                          Icons.grid_view,
                          Colors.orange,
                          AddTransactionConstants.addTransactionCategory,
                          transaction.category,
                        ),
                        const Divider(height: 1),
                        _buildInfoRow(
                          Icons.calendar_today,
                          Colors.blue,
                          AddTransactionConstants.addTransactionDate,
                          DateFormat(
                            TransactionDetailConstants
                                .transactionDetailDateFormate,
                          ).format(transaction.date),
                        ),
                        if (transaction.notes.isNotEmpty) ...[
                          const Divider(height: 1),
                          _buildInfoRow(
                            Icons.note_alt_outlined,
                            Colors.grey,
                            AddTransactionConstants.addTransactionNote,
                            transaction.notes,
                          ),
                        ],
                      ],
                    ),
                  ),

                  const SizedBox(height: 14),
                  const Text(
                    TransactionDetailConstants.transactionDetailAction,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 6),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddTransactionScreen(
                                  editTransaction: transaction,
                                ),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.edit_outlined,
                            color: ColorConstants.linkColor,
                          ),
                          label: Text(
                            TransactionDetailConstants.transactionDetailEdit,
                            style: TextStyle(color: ColorConstants.linkColor),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: BorderSide(
                              color: ColorConstants.linkColorSecondary,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor: ColorConstants.linkColorOnPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _showDeleteDialog(context, provider),
                          icon: Icon(
                            Icons.delete_outline,
                            color: ColorConstants.redPrimary,
                          ),
                          label: Text(
                            TransactionDetailConstants.transactionDetailDelete,
                            style: TextStyle(color: ColorConstants.redPrimary),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: BorderSide(
                              color: ColorConstants.redSecondary,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor:
                                ColorConstants.expenseLabelIconBackGround,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(
    IconData icon,
    Color iconBgColor,
    String label,
    String value, [
    Color? valueColor,
  ]) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBgColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconBgColor, size: 20),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: ColorConstants.onSecondaryColor,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: valueColor ?? ColorConstants.onPrimaryColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, ExpenseProvider expenseProvider) {
    showDialog(
      context: context,
      builder: (ctx) => CustomAlertDialog(
        title: TransactionDetailConstants.transactionDetailDelete,
        content:
            TransactionDetailConstants.transactionDetailDeleteTransactionContent,
        onConfirm: () {
          expenseProvider.deleteTransaction(transactionID);
          Navigator.pop(context);
        },
      ),
    );
  }
}
