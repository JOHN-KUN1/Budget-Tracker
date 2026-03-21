import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file_manager/open_file_manager.dart';
import 'package:permission_handler/permission_handler.dart';

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
          'AI Analysis',
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
              onPressed: () async {
                if (await Permission
                    .manageExternalStorage
                    .isPermanentlyDenied || await Permission.storage.isPermanentlyDenied) {
                  if (!mounted) return;
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          'Permission Request',
                          style: GoogleFonts.poppins(),
                        ), 
                        content: Text('Storage permission is required to perform Ai analysis', style: GoogleFonts.poppins(),),
                        actions: [
                          TextButton(
                            onPressed: () {
                              openAppSettings();
                            },
                            child: Text(
                              'Open settings',
                              style: GoogleFonts.poppins(),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }else if(await Permission.manageExternalStorage.request().isGranted || await Permission.storage.request().isGranted){
                  FilePickerResult? result = await FilePicker.platform.pickFiles();
                }
              },
              icon: const Icon(
                Icons.file_upload_outlined,
                size: 100,
                color: Colors.blue,
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
