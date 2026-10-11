abstract class BottomNavigationBarScreenConstants {
  static const String bottomNavigationLabel1 = 'Home';
  static const String bottomNavigationLabel2 = 'Transactions';
  static const String bottomNavigationLabel3 = 'Reports';
  static const String bottomNavigationLabel4 = 'Settings';
}

abstract class HomeScreenConstants {
  static const String homeScreenAppBarTitle = 'Expense Tracker';
  static const String homeScreenCardTitle1 = 'Total Balance';
  static const String homeScreenCardTitle2 = 'Total Income';
  static const String homeScreenCardTitle3 = 'Total Expense';
  static const String homeScreenSearchHintText = 'Search transactions...';
  static const String homeScreenRecentTransactionLabel = 'Recent Transactions';
  static const String homeScreenViewAllTransaction = 'View All';
  static const String homeScreenNoTransaction = 'No Transactions';
  static const String homeScreenFilterAll = 'All';
}

abstract class AddTransactionConstants {
  static const String addTransactionAppBarTitle = 'Add Transactions';
  static const String addTransactionAppBarTitleEditMode = 'Edit Transactions';
  static const String addTransactionCardLabel1 = 'Income';
  static const String addTransactionCardLabel2 = 'Expense';
  static const String addTransactionTitle = 'Title';
  static const String titleRequired = 'Title is required';
  static const String addTransactionTitleHint = 'Enter title';
  static const String addTransactionAmount = 'Amount';
  static const String addTransactionAmountHint = 'Enter Amount';
  static const String amountRequired = 'Amount is required';
  static const String addTransactionCategory = 'Category';
  static const String addTransactionCategoryHint = 'Select category';
  static const String categoryRequired = 'Category is required';
  static const String addTransactionDate = 'Date';
  static const String dateFormate = 'MMM dd, yyyy';
  static const String addTransactionDateHint = 'May 24, 2025';
  static const String addTransactionNote = 'Notes';
  static const String addTransactionNoteOptional = '(Optional)';
  static const String addTransactionNoteHint = 'Add notes (optional)';
  static const String addTransactionQuickCategory = 'QUICK CATEGORIES';
  static const String addTransactionIncomeCategories = 'Income Categories';
  static const String addTransactionExpenseCategories = 'Expense Categories';
  static const String addTransactionCancelButton = 'Cancel';
  static const String addTransactionSaveTransactionButton = 'Save Transaction';
  static const String addTransactionAmountNotValid = 'Amount must be valid number';
  static const String amountGreaterThanZero = 'Amount must be greater than 0';
  static const String addTransactionCategoryRequired = 'Category is required';
  static const String titleCharactersRequired = 'Title must contain characters';
  static const String titleMaxLength = 'Title must not exceed 15 characters';
  static const String futureDateNotAllowed = 'Future date cannot be selected';
}

abstract class SettingConstants {
  static const String settingScreenAppBarTitle = 'Settings';
  static const String settingScreenAppearance = 'APPEARANCE';
  static const String settingScreenDarkMode = 'Dark Mode';
  static const String settingScreenDarkModeSubText = 'Use dark theme across the app';
  static const String settingScreenGeneral = 'GENERAL';
  static const String settingScreenCurrency = 'Currency';
  static const String settingScreenCurrencySubText = 'Select your preferred currency';
  static const String settingScreenFirstDayOfWeek = 'First Day Of Week';
  static const String settingScreenFirstDayOfWeekSubText = 'Choose which day starts the week';
  static const String settingScreenData = 'DATA';
  static const String settingScreenClearTransaction = 'Clear All Transactions';
  static const String settingScreenClearTransactionSubText = 'This will remove all your transactions';
  static const String settingScreenClearTransactionWarningTitle = 'This action cannot be undone!';
  static const String settingScreenClearTransactionWarningSubText = 'All your income, expense and transaction data will be permanently deleted.';
  static const String settingScreenAbout = 'ABOUT';
  static const String settingScreenCardTitle1 = 'About Expense Tracker';
  static const String settingScreenCardSubTitle1 = 'Version 1.0.0';
  static const String settingScreenCardTitle2 = 'Rate Us';
  static const String settingScreenCardSubTitle2 = 'If you like the app, please rate us';
  static const String settingScreenCurrencyOption = 'USD (\$)';
  static const String settingScreenDay = 'Monday';
}

abstract class TransactionDetailConstants {
  static const String transactionDetailAppBarTitle = 'Transaction Details';
  static const String transactionDetailDateFormate = 'MMM dd, yyyy • hh:mm a';
  static const String transactionDetailTransactionInformation = 'Transaction Information';
  static const String transactionDetailType = 'Type';
  static const String transactionDetailAction = 'Action';
  static const String transactionDetailEdit = 'Edit Transaction';
  static const String transactionDetailDelete = 'Delete Transaction';
  static const String transactionDetailDeleteTransactionContent = 'Are you sure you want to delete this transaction?';
}

abstract class TransactionListConstants {
  static const String appBarTitle = 'Transaction List';
  static const String noTransactions = 'No transactions found.';
}

abstract class ReportConstants {
  static const String reportScreenAppBarTitle = 'Report';
  static const String reportScreenBody = 'Will be soon';
}

abstract class AlertDialogue {
  static const String
  delete = 'Delete';
  static const String cancel = 'Cancel';
}
