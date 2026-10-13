import 'package:expense_tracker_app/controllers/add_transaction_provider.dart';
import 'package:expense_tracker_app/models/transaction_model.dart';
import 'package:expense_tracker_app/utils/category_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../controllers/expense_provider.dart';
import '../../utils/color_constants.dart';
import '../../utils/string_constants.dart';

class AddTransactionScreen extends StatefulWidget {
  final TransactionModel? editTransaction;

  const AddTransactionScreen({super.key, this.editTransaction});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _amountController;
  late TextEditingController _noteController;

  late bool _isEditMode;

  @override
  void initState() {
    super.initState();
    _isEditMode = widget.editTransaction != null;

    _titleController = TextEditingController(
      text: _isEditMode ? widget.editTransaction!.title : '',
    );
    _amountController = TextEditingController(
      text: _isEditMode ? widget.editTransaction!.amount.toString() : '',
    );
    _noteController = TextEditingController(
      text: _isEditMode ? widget.editTransaction?.notes : '',
    );

    // Defer provider initialisation to after the first frame so the
    // widget tree is fully built and Provider.of can resolve.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final addProvider = Provider.of<AddTransactionProvider>(
        context,
        listen: false,
      );
      if (_isEditMode) {
        addProvider.initForEdit(widget.editTransaction!);
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void saveTransaction() {
    final addProvider = Provider.of<AddTransactionProvider>(
      context,
      listen: false,
    );

    if (_formkey.currentState!.validate()) {
      if (addProvider.selectedCategory == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              AddTransactionConstants.addTransactionCategoryRequired,
            ),
          ),
        );
        return;
      }

      final amt = double.tryParse(_amountController.text.trim());

      if (amt == null || amt <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(AddTransactionConstants.amountGreaterThanZero),
          ),
        );
        return;
      }

      final now = DateTime.now();
      final endOfToday = DateTime(now.year, now.month, now.day, 23, 59, 59);
      if (addProvider.selectedDate.isAfter(endOfToday)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(AddTransactionConstants.futureDateNotAllowed),
          ),
        );
        return;
      }

      final newTransaction = TransactionModel(
        id:
        widget.editTransaction?.id ??
            DateTime.now().microsecondsSinceEpoch.toString(),
        title: _titleController.text.trim(),
        amount: amt,
        transactionType: addProvider.selectedType,
        category: addProvider.selectedCategory!,
        date: addProvider.selectedDate,
        notes: _noteController.text.trim(),
      );

      final prov = Provider.of<ExpenseProvider>(context, listen: false);

      if (widget.editTransaction != null) {
        prov.updateTransaction(newTransaction);
      } else {
        prov.addTransaction(newTransaction);
      }
      Navigator.pop(context);
    }
  }

  Widget _buildLabel(String text) {
    return RichText(
      text: TextSpan(
        text: text.replaceAll(' *', ''),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: ColorConstants.onSecondaryColor,
          fontSize: 14,
        ),
        children: [
          TextSpan(
            text: ' *',
            style: TextStyle(color: ColorConstants.redPrimary),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesLabel() {
    return RichText(
      text: TextSpan(
        text: AddTransactionConstants.addTransactionNote,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: ColorConstants.onSecondaryColor,
          fontSize: 14,
        ),
        children: [
          TextSpan(
            text: AddTransactionConstants.addTransactionNoteOptional,
            style: TextStyle(
              color: ColorConstants.onSecondaryColor,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddTransactionProvider>(
      builder: (context, addProvider, _) {
        final categories = addProvider.currentCategories;
        addProvider.validateCategory();

        return Scaffold(
          backgroundColor: ColorConstants.secondaryColor,

          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              _isEditMode
                  ? AddTransactionConstants.addTransactionAppBarTitleEditMode
                  : AddTransactionConstants.addTransactionAppBarTitle,
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formkey,
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildTypeButton(
                            addProvider: addProvider,
                            title: HomeScreenConstants.homeScreenFilterIncome,
                            type: TransactionType.income,
                            color: ColorConstants.primaryColor,
                            bgColor: ColorConstants.incomeLabelIconBackGround,
                            icon: Icons.arrow_upward,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildTypeButton(
                            addProvider: addProvider,
                            title: HomeScreenConstants.homeScreenFilterExpense,
                            type: TransactionType.expense,
                            color: ColorConstants.redPrimary,
                            bgColor: ColorConstants.expenseLabelIconBackGround,
                            icon: Icons.arrow_downward,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
            
                    _buildLabel(AddTransactionConstants.addTransactionTitle),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _titleController,
                      maxLength: 15,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: ColorConstants.surfaceColor,
                        hintText: AddTransactionConstants.addTransactionTitleHint,
                        hintStyle: TextStyle(
                          color: ColorConstants.onSecondaryColor,
                        ),
                        counterText: '',
                        prefixIcon: Icon(
                          Icons.description_outlined,
                          color: ColorConstants.onSecondaryColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: ColorConstants.borderColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: ColorConstants.borderColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: ColorConstants.primaryColor),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: ColorConstants.redPrimary),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: ColorConstants.redPrimary,
                            width: 2,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return AddTransactionConstants.titleRequired;
                        }
                        if (!RegExp(r'[a-zA-Z]').hasMatch(value)) {
                          return AddTransactionConstants.titleCharactersRequired;
                        }
                        if (value.trim().length > 15) {
                          return AddTransactionConstants.titleMaxLength;
                        }
                        if(value.trim().length < 3){
                          return AddTransactionConstants.titleMinLength;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 13),
            
                    _buildLabel(AddTransactionConstants.addTransactionAmount),
                    const SizedBox(height: 7),
                    TextFormField(
                      controller: _amountController,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,4}'))
                      ],
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: ColorConstants.surfaceColor,
                        hintText: AddTransactionConstants.addTransactionAmountHint,
                        hintStyle: TextStyle(
                          color: ColorConstants.onSecondaryColor,
                        ),
                        prefixIcon: Icon(
                          Icons.attach_money,
                          color: ColorConstants.onSecondaryColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: ColorConstants.borderColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: ColorConstants.borderColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: ColorConstants.primaryColor),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: ColorConstants.redPrimary),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: ColorConstants.redPrimary,
                            width: 2,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return AddTransactionConstants.amountRequired;
                        }
                        final amt = double.tryParse(value.trim());
                        if (amt == null || amt <= 0) {
                          return AddTransactionConstants.amountGreaterThanZero;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 13),
            
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel(
                                AddTransactionConstants.addTransactionCategory,
                              ),
                              const SizedBox(height: 8),
                              DropdownButtonFormField<String>(
                                initialValue: addProvider.selectedCategory,
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: ColorConstants.onSecondaryColor,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: ColorConstants.surfaceColor,
                                  prefixIcon: Icon(
                                    Icons.sell_outlined,
                                    color: ColorConstants.primaryColor,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 14,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: ColorConstants.borderColor,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: ColorConstants.borderColor,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: ColorConstants.primaryColor,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: ColorConstants.redPrimary,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: ColorConstants.redPrimary,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                hint: Text(
                                  AddTransactionConstants
                                      .addTransactionCategoryHint,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: ColorConstants.onSecondaryColor,
                                  ),
                                ),
                                isExpanded: true,
                                items: List.generate(categories.length, (i) {
                                  return DropdownMenuItem(
                                    value: categories[i],
                                    child: Text(
                                      categories[i],
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                }),
                                onChanged: (val) =>
                                    addProvider.setSelectedCategory(val),
                                validator: (value) => value == null
                                    ? AddTransactionConstants.categoryRequired
                                    : null,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel(AddTransactionConstants.addTransactionDate),
                              const SizedBox(height: 8),
                              InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () async {
                                  final now = DateTime.now();
                                  final date = await showDatePicker(
                                    context: context,
                                    initialDate: addProvider.selectedDate.isAfter(now)
                                        ? now
                                        : addProvider.selectedDate,
                                    firstDate: DateTime(2000),
                                    lastDate: now,
                                  );
                                  if (date != null) {
                                    addProvider.setSelectedDate(date);
                                  }
                                },
                                child: InputDecorator(
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: ColorConstants.surfaceColor,
                                    prefixIcon: Icon(
                                      Icons.calendar_today_outlined,
                                      color: ColorConstants.primaryColor,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 14,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: ColorConstants.borderColor,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: ColorConstants.borderColor,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          DateFormat(
                                            AddTransactionConstants.dateFormate,
                                          ).format(addProvider.selectedDate),
                                          style: const TextStyle(fontSize: 14),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_down,
                                        color: ColorConstants.onSecondaryColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 13),
            
                    _buildNotesLabel(),
                    const SizedBox(height: 7),
                    Stack(
                      children: [
                        TextFormField(
                          controller: _noteController,
                          maxLines: 4,
                          maxLength: 200,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: ColorConstants.surfaceColor,
                            hintText:
                            AddTransactionConstants.addTransactionNoteHint,
                            hintStyle: TextStyle(
                              color: ColorConstants.onSecondaryColor,
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(bottom: 60),
                              child: Icon(
                                Icons.description_outlined,
                                color: ColorConstants.onSecondaryColor,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: ColorConstants.borderColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: ColorConstants.borderColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: ColorConstants.primaryColor,
                              ),
                            ),
                            counterText: '',
                            contentPadding: const EdgeInsets.fromLTRB(
                              12,
                              16,
                              12,
                              30,
                            ),
                          ),
                          onChanged: (val) =>
                              addProvider.updateNoteLength(val.length),
                        ),
                        Positioned(
                          bottom: 12,
                          right: 12,
                          child: Text(
                            '${addProvider.noteLength}/200',
                            style: TextStyle(
                              color: ColorConstants.onSecondaryColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
            
                    Text(
                      AddTransactionConstants.addTransactionQuickCategory,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.onSecondaryColor,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 7),
            
                    Container(
                      height: 48,
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorConstants.borderColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => addProvider.setSelectedType(
                                TransactionType.income,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: ColorConstants.surfaceColor,
                                  border: addProvider.selectedType == TransactionType.income
                                      ? Border.all(
                                    color: ColorConstants.primaryColor,
                                    width: 1.5,
                                  )
                                      : null,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    AddTransactionConstants
                                        .addTransactionIncomeCategories,
                                    style: TextStyle(
                                      color: addProvider.selectedType == TransactionType.income
                                          ? ColorConstants.primaryColor
                                          : ColorConstants.onSecondaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => addProvider.setSelectedType(
                                TransactionType.expense,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: ColorConstants.surfaceColor,
                                  border: addProvider.selectedType == TransactionType.expense
                                      ? Border.all(
                                    color: ColorConstants.redPrimary,
                                    width: 1.5,
                                  )
                                      : null,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    AddTransactionConstants
                                        .addTransactionExpenseCategories,
                                    style: TextStyle(
                                      color: addProvider.selectedType == TransactionType.expense
                                          ? ColorConstants.redPrimary
                                          : ColorConstants.onSecondaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 13),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(categories.length, (i) {
                          final c = categories[i];
                          return Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                addProvider.setSelectedCategory(c);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: ColorConstants.surfaceColor,
                                  border: Border.all(
                                    color: addProvider.selectedCategory == c
                                        ? ColorConstants.getCategoryColor(c)
                                        : ColorConstants.borderSecondary,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorConstants.secondaryColor,
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: ColorConstants.getCategoryColor(c),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        CategoryIcon.getCategoryIcon(c),
                                        color: ColorConstants.surfaceColor,
                                        size: 16,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      c,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: ColorConstants.onPrimaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 15),
            
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: ColorConstants.surfaceColor,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              side: BorderSide(color: ColorConstants.borderColor),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              AddTransactionConstants.addTransactionCancelButton,
                              style: TextStyle(
                                color: ColorConstants.onPrimaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: saveTransaction,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConstants.primaryColor,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              AddTransactionConstants
                                  .addTransactionSaveTransactionButton,
                              style: TextStyle(
                                color: ColorConstants.surfaceColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTypeButton({
    required AddTransactionProvider addProvider,
    required String title,
    required TransactionType type,
    required Color color,
    required Color bgColor,
    required IconData icon,
  }) {
    final isSelected = addProvider.selectedType == type;
    return InkWell(
      onTap: () {
        addProvider.setSelectedType(type);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: ColorConstants.surfaceColor,
          border: Border.all(
            color: isSelected ? color : ColorConstants.borderColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: bgColor,
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 1),
              ),
              child: Icon(icon, color: color, size: 16),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}