import 'package:flutter_test/flutter_test.dart';
import 'package:expense_tracker_app/main.dart';
import 'package:expense_tracker_app/controllers/expense_provider.dart';
import 'package:expense_tracker_app/models/transaction_model.dart';
import 'package:expense_tracker_app/utils/string_constants.dart';

void main() {
  group('ExpenseProvider Unit Tests', () {
    late ExpenseProvider provider;

    setUp(() {
      provider = ExpenseProvider();
    });

    test('Initial values are empty and zero', () {
      expect(provider.transactions, isEmpty);
      expect(provider.totalIncome, 0.0);
      expect(provider.totalExpense, 0.0);
      expect(provider.totalBalance, 0.0);
      expect(provider.filterType, isNull);
    });

    test('Adding income increases totalIncome and totalBalance', () {
      final item = TransactionModel(
        id: '1',
        title: 'Salary',
        amount: 5000.0,
        transactionType: TransactionType.income,
        category: 'Salary',
        date: DateTime.now(),
        notes: 'Monthly pay',
      );

      provider.addTransaction(item);

      expect(provider.transactions.length, 1);
      expect(provider.totalIncome, 5000.0);
      expect(provider.totalExpense, 0.0);
      expect(provider.totalBalance, 5000.0);
    });

    test('Adding expense increases totalExpense and decreases totalBalance', () {
      final income = TransactionModel(
        id: '1',
        title: 'Salary',
        amount: 5000.0,
        transactionType: TransactionType.income,
        category: 'Salary',
        date: DateTime.now(),
        notes: '',
      );
      final expense = TransactionModel(
        id: '2',
        title: 'Groceries',
        amount: 1500.0,
        transactionType: TransactionType.expense,
        category: 'Food',
        date: DateTime.now(),
        notes: '',
      );

      provider.addTransaction(income);
      provider.addTransaction(expense);

      expect(provider.transactions.length, 2);
      expect(provider.totalIncome, 5000.0);
      expect(provider.totalExpense, 1500.0);
      expect(provider.totalBalance, 3500.0);
    });

    test('Filtering transactions by type works correctly', () {
      final income = TransactionModel(
        id: '1',
        title: 'Freelance',
        amount: 2000.0,
        transactionType: TransactionType.income,
        category: 'Freelance',
        date: DateTime.now(),
        notes: '',
      );
      final expense = TransactionModel(
        id: '2',
        title: 'Dinner',
        amount: 500.0,
        transactionType: TransactionType.expense,
        category: 'Food',
        date: DateTime.now(),
        notes: '',
      );

      provider.addTransaction(income);
      provider.addTransaction(expense);

      // Default (All)
      expect(provider.searchTransactionsList.length, 2);

      // Filter Income
      provider.filterTransaction(TransactionType.income);
      expect(provider.searchTransactionsList.length, 1);
      expect(provider.searchTransactionsList.first.id, '1');

      // Filter Expense
      provider.filterTransaction(TransactionType.expense);
      expect(provider.searchTransactionsList.length, 1);
      expect(provider.searchTransactionsList.first.id, '2');

      // Filter All
      provider.filterTransaction(null);
      expect(provider.searchTransactionsList.length, 2);
    });

    test('Search queries filter transactions by title', () {
      final item1 = TransactionModel(
        id: '1',
        title: 'Coffee',
        amount: 50.0,
        transactionType: TransactionType.expense,
        category: 'Food',
        date: DateTime.now(),
        notes: '',
      );
      final item2 = TransactionModel(
        id: '2',
        title: 'Flight',
        amount: 800.0,
        transactionType: TransactionType.expense,
        category: 'Travel',
        date: DateTime.now(),
        notes: '',
      );

      provider.addTransaction(item1);
      provider.addTransaction(item2);

      provider.searchTransaction('cof');
      expect(provider.searchTransactionsList.length, 1);
      expect(provider.searchTransactionsList.first.title, 'Coffee');

      provider.searchTransaction('');
      expect(provider.searchTransactionsList.length, 2);
    });

    test('Updating a transaction modifies properties in list', () {
      final item = TransactionModel(
        id: '1',
        title: 'Lunch',
        amount: 100.0,
        transactionType: TransactionType.expense,
        category: 'Food',
        date: DateTime.now(),
        notes: '',
      );
      provider.addTransaction(item);

      final updated = TransactionModel(
        id: '1',
        title: 'Lunch Buffet',
        amount: 150.0,
        transactionType: TransactionType.expense,
        category: 'Food',
        date: DateTime.now(),
        notes: 'Updated',
      );
      provider.updateTransaction(updated);

      expect(provider.transactions.length, 1);
      expect(provider.transactions.first.title, 'Lunch Buffet');
      expect(provider.transactions.first.amount, 150.0);
      expect(provider.totalExpense, 150.0);
    });

    test('Deleting transaction removes it from list and updates totals', () {
      final item = TransactionModel(
        id: '1',
        title: 'Bonus',
        amount: 1000.0,
        transactionType: TransactionType.income,
        category: 'Bonus',
        date: DateTime.now(),
        notes: '',
      );
      provider.addTransaction(item);
      expect(provider.transactions.length, 1);

      provider.deleteTransaction('1');
      expect(provider.transactions, isEmpty);
      expect(provider.totalIncome, 0.0);
      expect(provider.totalBalance, 0.0);
    });

    test('Clearing all transactions removes everything', () {
      provider.addTransaction(TransactionModel(
        id: '1',
        title: 'A',
        amount: 10.0,
        transactionType: TransactionType.income,
        category: 'Salary',
        date: DateTime.now(),
        notes: '',
      ));
      provider.addTransaction(TransactionModel(
        id: '2',
        title: 'B',
        amount: 20.0,
        transactionType: TransactionType.expense,
        category: 'Food',
        date: DateTime.now(),
        notes: '',
      ));
      expect(provider.transactions.length, 2);

      provider.clearAllTransaction();
      expect(provider.transactions, isEmpty);
      expect(provider.totalBalance, 0.0);
    });
  });

  group('App Widget Smoke Tests', () {
    testWidgets('App launches and renders Home Screen correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Check App Title
      expect(find.text(HomeScreenConstants.homeScreenAppBarTitle), findsOneWidget);

      // Check Summary Cards
      expect(find.text(HomeScreenConstants.homeScreenCardTitle1), findsOneWidget);
      expect(find.text(HomeScreenConstants.homeScreenCardTitle2), findsOneWidget);
      expect(find.text(HomeScreenConstants.homeScreenCardTitle3), findsOneWidget);

      // Check Bottom Navigation labels
      expect(find.text(BottomNavigationBarScreenConstants.bottomNavigationLabel1), findsOneWidget);
      expect(find.text(BottomNavigationBarScreenConstants.bottomNavigationLabel2), findsOneWidget);
      expect(find.text(BottomNavigationBarScreenConstants.bottomNavigationLabel3), findsOneWidget);
      expect(find.text(BottomNavigationBarScreenConstants.bottomNavigationLabel4), findsOneWidget);

      // Check empty state
      expect(find.text(HomeScreenConstants.homeScreenNoTransaction), findsOneWidget);
    });
  });
}
