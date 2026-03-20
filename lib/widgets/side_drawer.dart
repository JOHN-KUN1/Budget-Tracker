import 'package:budget_tracker/screens/ai_analysis_screen.dart';
import 'package:budget_tracker/services/get_it_service.dart';
import 'package:budget_tracker/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            child: Text(
              'Budget Tracker',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              getIt<NavigationService>().navigate(const AiAnalysisScreen());
            },
            leading: const Icon(Icons.bar_chart),
            title: Text('Preview AI Insights',style: GoogleFonts.poppins(
              color: Colors.black
            ),),
          )
        ],
      ),
    );
  }
}
