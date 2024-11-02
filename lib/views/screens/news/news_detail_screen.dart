import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../widgets/widgets.dart';

class NewsDetailScreen extends StatelessWidget {
  const NewsDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'News',
      onBackTap: () {
        context.go('/home');
      },
      useBackButton: true,
      body: SfPdfViewer.network(
        "https://gqrrkswdhnhahfvgjzkj.supabase.co/storage/v1/object/public/company_news/one-long-page.pdf",
        enableDoubleTapZooming: true,
        enableTextSelection: true,
        pageSpacing: 0,
        canShowScrollHead: true,
        canShowScrollStatus: true,
      ),
    );
  }
}
