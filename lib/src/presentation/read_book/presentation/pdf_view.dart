
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';


class PDFViewerPage extends StatefulWidget {
  final File file;
  const PDFViewerPage({super.key, required this.file});

  @override
  PDFViewerPageState createState() => PDFViewerPageState();
}

class PDFViewerPageState extends State<PDFViewerPage> {
  late PDFViewController controller;
  int pages = 0;
  int indexPage = 0;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final text = '${indexPage + 1} of $pages';

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        actions: pages >= 2
            ? [
          Center(child: Text(text, style: const TextStyle(color: Colors.black),)),
          IconButton(
            icon: Icon(Icons.chevron_left, size: 32.h, color: indexPage > 0 ? Colors.black : Colors.grey,),
            onPressed: indexPage > 0 ? () {
              final page = indexPage - 1;
              controller.setPage(page);
            } : null,
          ),
          IconButton(
            icon: Icon(Icons.chevron_right, size: 32.h, color: indexPage < pages - 1 ? Colors.black : Colors.grey,),
            onPressed: indexPage < pages - 1 ? () {
              final page = indexPage + 1;
              controller.setPage(page);
            } : null,
          ),
        ]
            : null,

      ),
      body: PDFView(
        filePath: widget.file.path,
        autoSpacing: false,
        swipeHorizontal: true,
        fitEachPage: true,
        // pageSnap: false,
        // pageFling: true,
        onRender: (pages) => setState(() => this.pages = pages!),
        onViewCreated: (controller) =>
            setState(() => this.controller = controller),
        onPageChanged: (indexPage, _) =>
            setState(() => this.indexPage = indexPage!),
      ),
    );
  }
}