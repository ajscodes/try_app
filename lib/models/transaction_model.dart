enum TransactionType{
  income,
  expense
}

class TransactionModel {
  final String id;
   String title;
   double amount;
   TransactionType transactionType;
   String category;
   DateTime date;
   String notes;

  TransactionModel({
    required this.title,
    required this.amount,
    required this.transactionType,
    required this.category,
    required this.date,
    required this.notes,
    required this.id,
  });
}
