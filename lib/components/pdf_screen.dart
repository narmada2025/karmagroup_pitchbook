import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/go_back.dart';

class PdfScreen extends StatefulWidget {
  final String pdfPath; // Can be local or URL
  final Map<String, dynamic>? title;

  const PdfScreen({super.key, required this.pdfPath, this.title});

  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  int currentPage = 0;
  int totalPages = 0;

  String? localPdfPath; // final file passed to PDFView
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _preparePdf();
  }

  /// ✅ Check if the pdfPath is a URL or local file
  Future<void> _preparePdf() async {
    final path = widget.pdfPath.trim();
    // ✅ If already a valid local file
    if (File(path).existsSync()) {
      setState(() {
        localPdfPath = path;
        isLoading = false;
      });
      return;
    }

    // ✅ Otherwise assume it's a URL → download
    await _downloadPdf(path);
  }

  /// ✅ Downloads PDF from GCP URL and saves locally
  Future<void> _downloadPdf(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final dir = await getTemporaryDirectory();
        final file = File("${dir.path}/temp.pdf");

        await file.writeAsBytes(response.bodyBytes);

        setState(() {
          localPdfPath = file.path;
          isLoading = false;
        });
      } else {
        debugPrint("PDF download failed: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("PDF download error: $e");
    }
  }

  void onPageChanged(int page, int total) {
    setState(() {
      currentPage = page;
      totalPages = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Locale locale = Localizations.localeOf(context);
    String lang = locale.languageCode;

    return Container(
      width: size.width,
      height: size.height,
      color: AppColors.ultraLightGray,
      child: Stack(
        children: [
          /// ✅ Show loader until PDF is ready
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 70),
            child: isLoading || localPdfPath == null
                ? const Center(child: CircularProgressIndicator())
                : PDFView(
              backgroundColor: AppColors.ultraLightGray,
              filePath: localPdfPath!,
              enableSwipe: true,
              swipeHorizontal: true,
              autoSpacing: true,
              pageSnap: true,
              onPageChanged: (page, total) =>
                  onPageChanged(page!, total!),
              fitPolicy: FitPolicy.BOTH,
            ),
          ),

          /// ✅ Bottom title + page number
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 40),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(200),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                widget.title?[lang] != null
                    ? '${widget.title?[lang]}   |   Page ${currentPage + 1} of $totalPages'
                    : 'Page ${currentPage + 1} of $totalPages',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),

          /// ✅ Back button
          const GoBack(),
        ],
      ),
    );
  }
}
