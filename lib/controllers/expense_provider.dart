import 'package:expense_tracker_app/models/transaction_model.dart';
import 'package:flutter/cupertino.dart';

class ExpenseProvider extends ChangeNotifier {
  String _searchQuery = '';
  TransactionType? filterType;
  List<TransactionModel> transactions = <TransactionModel>[];
  bool lightTheme = false;
  int currentNavIndex = 0;

  String get searchQuery => _searchQuery;

  void updateNavIndex(int index) {
    currentNavIndex = index;
    notifyListeners();
  }

  List<TransactionModel> get recentTransaction {
    List<TransactionModel> recentTransactionList = [];
    recentTransactionList = transactions.reversed.take(5).toList();
    return recentTransactionList;
  }

  List<TransactionModel> get searchTransactionsList {
    List<TransactionModel> filteredList = [];

    for (TransactionModel transaction in transactions) {
      bool matchedSearch = transaction.title.toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );
      bool matchedType = filterType == null || transaction.transactionType == filterType;

      if (matchedSearch && matchedType) {
        filteredList.add(transaction);
      }
    }
    return filteredList.reversed.take(5).toList();

  }

  double get totalExpense{
    double total = 0;

    for (TransactionModel transaction in transactions) {
      if (transaction.transactionType == TransactionType.expense) {
        total += transaction.amount;
      }
    }
    return total;
  }

  double get totalIncome {
    double total = 0;

    for (TransactionModel transaction in transactions) {
      if (transaction.transactionType == TransactionType.income) {
        total += transaction.amount;
      }
    }
    return total;
  }

  double get totalBalance {
    return totalIncome - totalExpense;
  }

  void addTransaction(TransactionModel transaction) {
    transactions.add(transaction);
    print("Add transaction id ${transaction.id}");
    notifyListeners();
  }

  void updateTransaction(TransactionModel transaction) {
    print("Update transaction id ${transaction.id}");
    int index = transactions.indexWhere((t) => t.id == transaction.id);
    if (index != -1) {
      transactions[index] = transaction;
      notifyListeners();
    }
  }

  void deleteTransaction(String id) {
    transactions.removeWhere((t) => t.id == id);
    notifyListeners();
  }

  void searchTransaction(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void filterTransaction(TransactionType? type) {
    filterType = type;
    notifyListeners();
  }

  void clearAllTransaction() {
    transactions.clear();
    notifyListeners();
  }

  void switchTheme(bool value) {
    lightTheme = value;
    notifyListeners();
  }
}

