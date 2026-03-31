
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:budget_tracker/widgets/transaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

import '../view_models/balance/balance_provider.dart';
import '../view_models/expense/expense_provider.dart';
import '../view_models/income/income_provider.dart';
import '../view_models/theme/theme_provider.dart';
import '../view_models/transaction/transaction_provider.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  String value = 'Month';

  @override
  Widget build(BuildContext context) {
    final transactions = ref.watch(transactionProvider);
    final income = ref.watch(incomeProvider);
    final expense = ref.watch(expenseProvider);
    final balance = ref.watch(balanceProvider);
    final percent = (expense / income).toStringAsFixed(1);
    final doublePercent = double.tryParse(percent);
    final isDark =
        ref.watch(themeProvider) == ThemeData.dark(useMaterial3: true)
        ? true
        : false;
    return Center(
      child: Column(
        crossAxisAlignment: .start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Container(
                  //width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green[50],
                  ),
                  child: Column(
                    crossAxisAlignment: .start,
                    mainAxisSize: .min,
                    children: [
                      Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          Text(
                            'Income',
                            style: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          const Icon(
                            Icons.expand_circle_down_sharp,
                            color: Colors.green,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '\$$income',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                //const Flexible(child: Spacer()),
                Container(
                  //width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red[50],
                  ),
                  child: Column(
                    crossAxisAlignment: .start,
                    mainAxisSize: .min,
                    children: [
                      Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          Text(
                            'Expenses',
                            style: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          const Icon(
                            Icons.expand_circle_down_sharp,
                            color: Colors.red,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '\$$expense',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue[50],
              ),
              child: Column(
                crossAxisAlignment: .center,
                children: [
                  Row(
                    children: [
                      Text(
                        'Current Balance',
                        style: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const Expanded(
                        child: SizedBox(
                          width: double.infinity,
                        ),
                      ),
                      const Icon(
                        Icons.money,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${ref.watch(balanceProvider) < 0 ? '-\$' : '+\$'}${balance.abs()}',
                    style: GoogleFonts.poppins(
                      color: Colors.blue,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  LinearPercentIndicator(
                    barRadius: const Radius.circular(20),
                    backgroundColor: Colors.grey,
                    progressColor: expense >= income ? Colors.red : Colors.blue,
                    lineHeight: 10.0,
                    percent: expense >= income
                        ? 1.0
                        : income == 0
                        ? 0.0
                        : doublePercent!,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: .start,
                    children: [
                      Text(
                        '${(expense >= income) ? '100' : (doublePercent! * 100).floor()}% of income used',
                        style: GoogleFonts.poppins(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: .center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SegmentedButton(
                segments: [
                  ButtonSegment(
                    value: 'Week',
                    label: Text(
                      'Week',
                      style: GoogleFonts.poppins(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  ButtonSegment(
                    value: 'Month',
                    label: Text(
                      'Month',
                      style: GoogleFonts.poppins(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  ButtonSegment(
                    value: 'Year',
                    label: Text(
                      'Year',
                      style: GoogleFonts.poppins(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
                selected: <String>{value},
                onSelectionChanged: (Set selection) {
                  setState(() {
                    value = selection.first.toString();
                  });
                },
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              'Category Breakdown',
              style: GoogleFonts.poppins(
                color: isDark ? Colors.white : Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsetsGeometry.symmetric(horizontal: 15.0),
            child: Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: isDark
                    ? Colors.black.withValues(alpha: 0.7)
                    : Colors.white,
              ),
              child: transactions.isEmpty
                  ? Center(
                      child: Text(
                        'Add transaction to view most recent category',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    )
                  : Row(
                      children: [
                        Text(
                          transactions.first.category.name.substring(0,1).toUpperCase() + transactions.first.category.name.substring(1),
                          style: GoogleFonts.poppins(
                            color:isDark ? Colors.white : Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: LinearPercentIndicator(
                            barRadius: const Radius.circular(20),
                            percent: 1.0,
                            progressColor: Colors.red,
                          ),
                        ),
                        Text(
                          '\$${transactions.last.amount}',
                          style: GoogleFonts.poppins(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: .start,
              children: [
                Text(
                  'Recent Transactions',
                  style: GoogleFonts.poppins(
                    color: isDark ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  child: TransactionWidget(
                    transactionModel: transaction,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
