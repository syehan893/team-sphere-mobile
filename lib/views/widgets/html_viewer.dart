import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class HtmlViewer extends StatelessWidget {
  final String htmlContent;

  const HtmlViewer({super.key, required this.htmlContent});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Html(
        data: htmlContent,
        style: {
          "body": Style(
            fontSize: FontSize.large,
            padding: HtmlPaddings.all(8),
            color: Colors.black87,
          ),
          "h1": Style(
            fontSize: FontSize.xLarge,
            fontWeight: FontWeight.bold,
          ),
          "p": Style(
            fontSize: FontSize.medium,
            margin: Margins.symmetric(vertical: 8),
          ),
        },
      ),
    );
  }
}

class CustomHtmlWidget extends StatelessWidget {
  final String htmlContent;
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;

  const CustomHtmlWidget({
    super.key,
    required this.htmlContent,
    this.width,
    this.height,
    this.textStyle,
    this.backgroundColor = Colors.transparent,
    this.padding = const EdgeInsets.all(8.0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      color: backgroundColor,
      child: SingleChildScrollView(
        child: HtmlWidget(
          htmlContent,
          customStylesBuilder: (element) {
            if (textStyle != null) {
              return {
                'font-family': textStyle?.fontFamily ?? '',
                'font-size': '${textStyle?.fontSize}px',
                'color': textStyle?.color?.toString() ?? '',
                'font-weight': textStyle?.fontWeight?.toString() ?? '',
              };
            }
            return null;
          },
          onErrorBuilder: (context, element, error) => Text('Error: $error'),
          onLoadingBuilder: (context, element, loadingProgress) => const Center(
            child: CircularProgressIndicator(),
          ),
          renderMode: RenderMode.column,
          textStyle: textStyle,
        ),
      ),
    );
  }
}
