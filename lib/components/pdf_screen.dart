import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/go_back.dart';

class PdfScreen extends StatefulWidget {
  final String pdfPath;
  final Map<String, dynamic>? title;

  const PdfScreen({super.key, required this.pdfPath, this.title});

  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  int currentPage = 0;
  int totalPages = 0;

  String? localPdfPath;
  bool isLoading = true;

  PdfController? pdfController;

  @override
  void initState() {
    super.initState();
    _preparePdf();
  }

  Future<void> _preparePdf() async {
    final path = widget.pdfPath.trim();

    if (File(path).existsSync()) {
      _initPdf(path);
    } else {
      await _downloadPdf(path);
    }
  }

  void _initPdf(String path) {
    pdfController?.dispose();

    pdfController = PdfController(
      document: PdfDocument.openFile(path),
    );

    setState(() {
      localPdfPath = path;
      isLoading = false;
    });
  }

  Future<void> _downloadPdf(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final dir = await getTemporaryDirectory();
        final file = File("${dir.path}/temp.pdf");

        await file.writeAsBytes(response.bodyBytes);

        _initPdf(file.path);
      } else {
        debugPrint("PDF download failed: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("PDF download error: $e");
    }
  }

  @override
  void dispose() {
    pdfController?.dispose();
    super.dispose();
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
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 70),
            child: isLoading || pdfController == null
                ? const Center(child: CircularProgressIndicator())
                : PdfView(
              controller: pdfController!,
              backgroundDecoration: const BoxDecoration(
                color: AppColors.ultraLightGray,
              ),
            ),
          ),

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

          const GoBack(),
        ],
      ),
    );
  }
}
