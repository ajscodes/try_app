import 'package:expense_tracker_app/models/transaction_model.dart';
import 'package:flutter/material.dart';

class AddTransactionProvider extends ChangeNotifier {
  TransactionType _selectedType = TransactionType.income;
  String? _selectedCategory;
  DateTime _selectedDate = DateTime.now();
  int _noteLength = 0;

  final List<String> _incomeCategories = ['Salary', 'Freelance', 'Bonus'];
  final List<String> _expenseCategories = [
    'Food',
    'Shopping',
    'Fuel',
    'Bills',
    'Entertainment',
    'Travel',
    'Medical',
    'Other',
  ];

  // Getters
  TransactionType get selectedType => _selectedType;
  String? get selectedCategory => _selectedCategory;
  DateTime get selectedDate => _selectedDate;
  int get noteLength => _noteLength;
  List<String> get incomeCategories => _incomeCategories;
  List<String> get expenseCategories => _expenseCategories;

  List<String> get currentCategories =>
      _selectedType == TransactionType.income
          ? _incomeCategories
          : _expenseCategories;

  /// Initialize form state for editing an existing transaction.
  void initForEdit(TransactionModel transaction) {
    _selectedType = transaction.transactionType;
    _selectedCategory = transaction.category;
    _selectedDate = transaction.date;
    if (_selectedDate.isAfter(DateTime.now())) {
      _selectedDate = DateTime.now();
    }
    _noteLength = transaction.notes.length;
    notifyListeners();
  }

  void setSelectedType(TransactionType type) {
    _selectedType = type;
    _selectedCategory = null;
    notifyListeners();
  }

  void setSelectedCategory(String? category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void updateNoteLength(int length) {
    _noteLength = length;
    notifyListeners();
  }

  /// Ensures category is still valid for the current type.
  /// Call this inside the build method to reset category if it no longer
  /// belongs to the active categories list.
  void validateCategory() {
    if (_selectedCategory != null &&
        !currentCategories.contains(_selectedCategory)) {
      _selectedCategory = null;
      // No notifyListeners here – this is called during build.
    }
  }
}
