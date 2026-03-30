
import 'package:doc_text_extractor/doc_text_extractor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

import '../view_models/repository/repository_provider.dart';
import '../view_models/theme/theme_provider.dart';

class AiAnalysisScreen extends ConsumerStatefulWidget {
  const AiAnalysisScreen({super.key});

  @override
  ConsumerState<AiAnalysisScreen> createState() => _AiAnalysisScreenState();
}

class _AiAnalysisScreenState extends ConsumerState<AiAnalysisScreen> {
  String? filePath;
  String analysis = '';

  Future<void> getInsights(String file) async {
    final extractor = TextExtractor();
    final extractedText = await extractor.extractText(file,isUrl: false);
    final aiAnalysis = await ref.read(aiRepositoryProvider).getInsight(extractedText.text);
    analysis = aiAnalysis;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeProvider) == ThemeData.dark(useMaterial3: true) ? true : false;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AI Analysis',
          style: GoogleFonts.poppins(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: filePath == null
          ? Center(
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  IconButton(
                    onPressed: () async {
                      if (await Permission
                              .manageExternalStorage
                              .isPermanentlyDenied ||
                          await Permission.storage.isPermanentlyDenied) {
                        if (!mounted) return;
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                'Permission Request',
                                style: GoogleFonts.poppins(),
                              ),
                              content: Text(
                                'Storage permission is required to perform AI analysis',
                                style: GoogleFonts.poppins(),
                              ),
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
                      } else if (await Permission.manageExternalStorage
                              .request()
                              .isGranted ||
                          await Permission.storage.request().isGranted) {
                        FilePickerResult? result = await FilePicker.platform
                            .pickFiles();
                        if (result != null) {
                          setState(() {
                            filePath = result.files.single.path!;
                          });
                        }
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
            )
          : FutureBuilder(
              future: getInsights(filePath!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return Markdown(
                    data: analysis,
                    styleSheet: MarkdownStyleSheet(
                      h1: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
                      h2: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
                      p: GoogleFonts.poppins(fontSize: 16),
                      strong: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                  );
                }
              },
            ),
    );
  }
}
