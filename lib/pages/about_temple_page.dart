import 'package:flutter/material.dart';

class AboutTemplePage extends StatelessWidget {
  const AboutTemplePage({super.key});
  final String image = 'assets/images/temple-img-1.jpeg';
  final String details =
      "The Ayodhya Ram Mandir is considered to be one of the most important pilgrimage sites for Hindus. It is believed to be the birthplace of Lord Ram and is considered a sacred site. The construction of the temple is seen as a symbolic victory for the Hindu community, who had been fighting for the temple's construction for decades.\nThe temple is expected to contribute to the development of Ayodhya as a major religious and cultural center. It is also expected to create jobs and generate economic growth in the region. The temple is expected to attract millions of devotees from across India and the world, contributing to the development of Ayodhya as a major religious and cultural center.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("About Mandir"),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            )),
          ),
          Container(
            color: Color(0xFFF5F5F5).withOpacity(0.7),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Center(
                  child: Text(
                details,
                style: TextStyle(
                  fontSize: 18,
                  height: 1.8,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
