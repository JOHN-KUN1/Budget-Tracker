import 'package:budget_tracker/view_models/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:budget_tracker/screens/dashboard_screen.dart';
import 'package:budget_tracker/screens/settings_screen.dart';
import 'package:budget_tracker/screens/transactions_screen.dart';
import 'package:budget_tracker/widgets/side_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _screenIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeProvider) == ThemeData.dark() ? true : false; 
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          _screenIndex == 0
              ? 'Transactions'
              : _screenIndex == 1
              ? 'Dashboard'
              : 'Settings',
          style: GoogleFonts.poppins(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        actions: [
          if (_screenIndex == 0)
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  useSafeArea: true,
                  enableDrag: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(10),
                  ),
                  context: context,
                  builder: (context) {
                    return const AddTransactionBottomSheet();
                  },
                );
              },
              icon: Icon(
                Icons.add_circle_outlined,
                color: Colors.white,
                size: 35,
              ),
            ),
        ],
      ),
      drawer: const SideDrawer(),
      body: _screenIndex == 0
          ? const TransactionsScreen()
          : _screenIndex == 1
          ? const DashboardScreen()
          : const SettingsScreen(),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _screenIndex = 0;
                });
              },
              child: Wrap(
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Icon(
                    size: 30,
                    Icons.list,
                    color: _screenIndex == 0 ? Colors.blue : Colors.grey,
                  ),
                  Text(
                    'Transactions',
                    style: GoogleFonts.poppins(
                      color: _screenIndex == 0 ? Colors.blue : Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _screenIndex = 1;
                });
              },
              child: Wrap(
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Icon(
                    size: 30,
                    Icons.dashboard,
                    color: _screenIndex == 1 ? Colors.blue : Colors.grey,
                  ),
                  Text(
                    'Dashboard',
                    style: GoogleFonts.poppins(
                      color: _screenIndex == 1 ? Colors.blue : Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _screenIndex = 2;
                });
              },
              child: Wrap(
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Icon(
                    size: 30,
                    Icons.settings,
                    color: _screenIndex == 2 ? Colors.blue : Colors.grey,
                  ),
                  Text(
                    'Settings',
                    style: GoogleFonts.poppins(
                      color: _screenIndex == 2 ? Colors.blue : Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
