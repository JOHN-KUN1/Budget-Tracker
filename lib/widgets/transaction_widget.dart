import 'package:budget_tracker/view_models/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:budget_tracker/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TransactionWidget extends ConsumerWidget {
  final TransactionModel transactionModel;
  const TransactionWidget({super.key, required this.transactionModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Map<Category, IconData> categoryIcons = {
      Category.salary: Icons.monetization_on,
      Category.investment: Icons.trending_up,
      Category.gift: Icons.card_giftcard,
      Category.refund: Icons.restart_alt,
      Category.other: Icons.category,
    };
    final isDark = ref.watch(themeProvider) == ThemeData.dark(useMaterial3: true) ? true : false;
    return Container(
      padding: EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isDark ? Colors.black.withValues(alpha: 0.7) : Colors.white,
      ),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor:
                transactionModel.transactionType.name.toLowerCase() == 'income'
                ? Colors.green[200]
                : Colors.red[200],
            child: Icon(
              categoryIcons[transactionModel.category],
              color:
                  transactionModel.transactionType.name.toLowerCase() ==
                      'income'
                  ? Colors.green
                  : Colors.red,
            ),
          ),
          // const SizedBox(
          //   width: 10,
          // ),
          Column(
            crossAxisAlignment: .start,
            mainAxisSize: .min,
            children: [
              Text(
                transactionModel.title.substring(0,1).toUpperCase() + transactionModel.title.substring(1),
                style: GoogleFonts.poppins(
                  color:isDark ? Colors.white : Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                transactionModel.category.name.substring(0,1).toUpperCase() + transactionModel.category.name.substring(1),
                style: GoogleFonts.poppins(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${DateFormat.yMMMd().format(transactionModel.date)} at ${transactionModel.date.hour}:${transactionModel.date.minute}',
                style: GoogleFonts.poppins(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          Text(
            '${transactionModel.transactionType == TransactionType.income ? '+\$' : '-\$'}${transactionModel.amount}',
            style: GoogleFonts.poppins(
              color:
                  transactionModel.transactionType.name.toLowerCase() ==
                      'income'
                  ? Colors.greenAccent
                  : Colors.redAccent,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
