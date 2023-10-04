import 'package:flutter/material.dart';

class ResponsiveContainer extends StatelessWidget {
  final List<Widget> children;
  final AppBar? appBar;
  final Alignment alignment;
  final Color? backgroundColor;

  const ResponsiveContainer({
    super.key,
    required this.children,
    this.appBar,
    this.alignment = Alignment.center,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Container(
          alignment: alignment,
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: children),
          ),
        ),
      ),
    );
  }
}
