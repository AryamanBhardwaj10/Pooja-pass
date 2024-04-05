import 'package:flutter/material.dart';

class AboutTemplePage extends StatelessWidget {
  const AboutTemplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("About Mandir"),
      ),
      body: SingleChildScrollView(
        child: Center(child: Text("Temple details")),
      ),
    );
  }
}
