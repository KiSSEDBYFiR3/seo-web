import 'package:flutter/material.dart';
import 'package:seo_web/core/common/utils/seo_helper.dart';

class SEOWidget extends StatefulWidget {
  final String? h1Title;
  final String? h1Id;

  final String? metaImageLink;
  final String? metaAlt;
  final Widget child;

  const SEOWidget({
    super.key,
    this.h1Title,
    this.metaAlt,
    this.metaImageLink,
    this.h1Id,
    required this.child,
  });

  @override
  State<SEOWidget> createState() => _SEOWidgetState();
}

class _SEOWidgetState extends State<SEOWidget> {
  @override
  void initState() {
    SEOHelper.addH1(h1Id: widget.h1Id, h1Title: widget.h1Title);
    SEOHelper.addImage(
      imageLink: widget.metaImageLink,
      imageAlt: widget.metaAlt,
    );
    super.initState();
  }

  @override
  void dispose() {
    SEOHelper.disposeInfo(
      imageAlt: widget.metaAlt,
      imageLink: widget.metaImageLink,
      h1Id: widget.h1Id,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
