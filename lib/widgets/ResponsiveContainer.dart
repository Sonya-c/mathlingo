import 'package:flutter/material.dart';

class ResponsiveContainer extends StatelessWidget {
  final List<Widget> children;
  final AppBar? appBar;
  const ResponsiveContainer({super.key, required this.children, this.appBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Center(
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
