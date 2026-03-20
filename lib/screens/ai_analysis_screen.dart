import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AiAnalysisScreen extends StatefulWidget {
  const AiAnalysisScreen({super.key});

  @override
  State<AiAnalysisScreen> createState() => _AiAnalysisScreenState();
}

class _AiAnalysisScreenState extends State<AiAnalysisScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AI Anaylysis',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.inbox_outlined,
                size: 100,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Tap icon to uplaod bank statement',
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: Colors.grey,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
