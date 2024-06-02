import 'package:flutter/material.dart';
import 'dart:ui_web' as ui;
import 'dart:html' as html;

class HtmlImageViewCustom extends StatefulWidget {
  final String imageUrl;
  final double height;
  final double width;

  HtmlImageViewCustom(
      {required this.imageUrl, required this.height, required this.width});

  @override
  _HtmlImageViewCustomState createState() => _HtmlImageViewCustomState();
}

class _HtmlImageViewCustomState extends State<HtmlImageViewCustom> {
  late html.Element viewTypeElement;

  @override
  void initState() {
    super.initState();

    // Create a unique viewType ID for this widget
    final viewType = 'html-img-${widget.imageUrl}';

    // Register the view factory
    ui.platformViewRegistry.registerViewFactory(viewType, (int viewId) {
      // Create an <img> element
      final imgElement = html.ImageElement()
        ..src = widget.imageUrl
        ..style.border = 'none';

      // Return the element
      return imgElement;
    });

    viewTypeElement = html.DivElement()
      ..id = viewType
      ..style.width = '100%'
      ..style.height = '100%';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width, // Specify the width
      height: widget.height, // Specify the height
      child: HtmlElementView(viewType: viewTypeElement.id),
    );
  }
}
