import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:team_sphere_mobile/app/themes/colors.dart';
import 'package:team_sphere_mobile/views/widgets/widgets.dart';

class PdfViewerWidget extends StatelessWidget {
  final String pdfUrl;

  const PdfViewerWidget({
    super.key,
    required this.pdfUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SfPdfViewer.network(
      pdfUrl,
      onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
        CustomToast.showToast(
            context, 'Failed to load content', TSColors.alert.red700);
      },
    );
  }
}
