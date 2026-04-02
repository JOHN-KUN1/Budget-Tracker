import 'package:budget_tracker/models/transaction_model.dart';
import 'package:budget_tracker/view_models/filtered_transactions/filtered_transactions_provider.dart';
import 'package:budget_tracker/view_models/search/search_provider.dart';
import 'package:budget_tracker/widgets/transaction_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:string_validator/string_validator.dart';

import '../view_models/theme/theme_provider.dart';
import '../view_models/transaction/transaction_provider.dart';

class TransactionsScreen extends ConsumerWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transaction = ref.watch(filteredTransactionsProvider);
    return SafeArea(
      child: Center(
        child: Column(
          crossAxisAlignment: .start,
          children: [
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 10,
              ),
              child: SearchBar(
                onChanged: (value) {
                  ref.read(searchProvider.notifier).changeSearchTerm(value);
                },
                shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(10),
                  ),
                ),
                hintText: 'Search Transactions',
                leading: const Icon(Icons.search),
              ),
            ),
            if (transaction.isEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: .center,
                    children: [
                      const Icon(
                        Icons.inbox_outlined,
                        size: 100,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'No transactions yet',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.grey,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Add your first transaction',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.grey,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ListView.builder(
                    itemCount: transaction.length,
                    itemBuilder: (context, index) {
                      final transactionModel = transaction[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),
                        child: Dismissible(
                          direction: DismissDirection.horizontal,
                          key: ValueKey(transactionModel.id),
                          onDismissed: (direction) async {
                            await ref
                                .read(transactionProvider.notifier)
                                .deleteTransaction(id: transactionModel.id);
                          },
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                useSafeArea: true,
                                enableDrag: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    10,
                                  ),
                                ),
                                context: context,
                                builder: (context) {
                                  return AddTransactionBottomSheet(
                                    id: transactionModel.id,
                                    title: transactionModel.title,
                                    amount: transactionModel.amount.toString(),
                                    notes: transactionModel.note,
                                    category: transactionModel.category,
                                    transactionType:
                                        transactionModel.transactionType,
                                  );
                                },
                              );
                            },
                            child: TransactionWidget(
                              transactionModel: transactionModel,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class AddTransactionBottomSheet extends ConsumerStatefulWidget {
  final String? id;
  final String? title;
  final String? amount;
  final String? notes;
  final Category? category;
  final TransactionType? transactionType;
  const AddTransactionBottomSheet({
    super.key,
    this.id,
    this.title,
    this.amount,
    this.notes,
    this.category,
    this.transactionType,
  });

  @override
  ConsumerState<AddTransactionBottomSheet> createState() =>
      _AddTransactionBottomSheetState();
}

class _AddTransactionBottomSheetState
    extends ConsumerState<AddTransactionBottomSheet> {
  late Category categoryValue;
  late TransactionType transactionType;
  var now = DateTime.now();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  bool error = false;
  bool amountError = false;
  bool titleError = false;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController.text = widget.title ?? '';
    _amountController.text = widget.amount ?? '';
    _notesController.text = widget.notes ?? '';
    categoryValue = widget.category ?? Category.gift;
    transactionType = widget.transactionType ?? TransactionType.income;
  }

  @override
  Widget build(BuildContext context) {
    final isDark =
        ref.watch(themeProvider) == ThemeData.dark(useMaterial3: true)
        ? true
        : false;
    return Column(
      crossAxisAlignment: .start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: GoogleFonts.poppins(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (_titleController.text.trim().isEmpty ||
                      _amountController.text.trim().isEmpty) {
                    setState(() {
                      error = true;
                    });
                    return;
                  }
                  if (!isAlpha(_titleController.text.trim())) {
                    setState(() {
                      titleError = true;
                    });
                    return;
                  }
                  if (isAlpha(_amountController.text.trim()) ||
                      double.tryParse(_amountController.text.trim()) == null) {
                    setState(() {
                      amountError = true;
                    });
                    return;
                  }
                  widget.id != null
                      ? ref
                            .read(transactionProvider.notifier)
                            .updateTransaction(
                              widget.id!,
                              _titleController.text.trim(),
                              double.tryParse(_amountController.text.trim())!,
                              _notesController.text.trim().isEmpty
                                  ? ''
                                  : _notesController.text.trim(),
                              categoryValue,
                              transactionType,
                            )
                      : ref
                            .read(transactionProvider.notifier)
                            .addTransactions(
                              transactionType: transactionType,
                              title: _titleController.text.trim(),
                              amount: double.tryParse(
                                _amountController.text.trim(),
                              )!,
                              date: now,
                              category: categoryValue,
                              note: _notesController.text.trim().isEmpty
                                  ? ''
                                  : _notesController.text.trim(),
                            );
                  Navigator.pop(context);
                },
                child: Text(
                  widget.id != null ? 'Update' : 'Save',
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            'Add Transaction',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
          ),
          child: Row(
            mainAxisAlignment: .center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: isDark
                      ? Colors.black.withValues(alpha: 0.7)
                      : Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SegmentedButton(
                    segments: [
                      ButtonSegment(
                        value: TransactionType.income,
                        label: Text(
                          'Income',
                          style: GoogleFonts.poppins(
                            color: isDark ? Colors.white : Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      ButtonSegment(
                        value: TransactionType.expense,
                        label: Text(
                          'Expense',
                          style: GoogleFonts.poppins(
                            color: isDark ? Colors.white : Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                    selected: <TransactionType>{transactionType},
                    onSelectionChanged: (Set selection) {
                      setState(() {
                        transactionType = selection.first;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0, bottom: 5),
          child: Text(
            'DETIALS',
            style: GoogleFonts.poppins(color: Colors.grey, fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isDark
                  ? Colors.black.withValues(alpha: 0.7)
                  : Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: .min,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      errorText: titleError
                          ? 'title must only contain alphabets'
                          : error
                          ? 'value cannot be empty'
                          : null,
                    ),
                  ),
                  TextField(
                    controller: _amountController,
                    decoration: InputDecoration(
                      prefixText: '\$',
                      labelText: 'Amount',
                      errorText: error
                          ? 'value cannot be empty'
                          : amountError
                          ? 'value must be a number'
                          : null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Row(
                      children: [
                        Text(
                          'Date',
                          style: GoogleFonts.poppins(
                            color: isDark ? Colors.white : Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Expanded(
                          child: SizedBox(
                            width: double.infinity,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color(0xFFD8BFD8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                DateFormat.yMMMd().format(now),
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFD8BFD8),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                '${now.hour}:${now.minute}',
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0, bottom: 5),
          child: Text(
            'CATEGORY',
            style: GoogleFonts.poppins(color: Colors.grey, fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsetsGeometry.symmetric(horizontal: 15),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isDark
                  ? Colors.black.withValues(alpha: 0.7)
                  : Colors.white,
            ),
            child: Row(
              children: [
                Text(
                  'Category',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: isDark ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Expanded(
                  child: const SizedBox(
                    width: double.infinity,
                  ),
                ),
                DropdownButton(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  value: categoryValue,
                  hint: Text(
                    'Category',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  items: [
                    for (final cat in Category.values)
                      DropdownMenuItem(
                        value: cat,
                        child: Text(
                          style: GoogleFonts.poppins(
                            color: isDark ? Colors.white : Colors.black,
                          ),
                          cat.name.substring(0, 1).toUpperCase() +
                              cat.name.substring(1),
                        ),
                      ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      categoryValue = value!;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0, bottom: 5),
          child: Text(
            'NOTES',
            style: GoogleFonts.poppins(color: Colors.grey, fontSize: 16),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 50),
            child: Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: isDark
                    ? Colors.black.withValues(alpha: 0.7)
                    : Colors.white,
              ),
              child: TextField(
                controller: _notesController,
                expands: true,
                maxLines: null,
                minLines: null,
                decoration: InputDecoration(
                  hint: Text(
                    'Enter your text here',
                    style: GoogleFonts.poppins(color: Colors.grey),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
        //   child: Container(
        //     margin: const EdgeInsets.only(bottom: 20),
        //     width: double.infinity,
        //     height: 100,
        //     decoration: BoxDecoration(
        //       color: Colors.white,
        //       borderRadius: BorderRadius.circular(10),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
