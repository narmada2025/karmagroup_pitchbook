import 'package:flutter/material.dart';

class ReVisitVietnamTab extends StatelessWidget {
  const ReVisitVietnamTab({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.network(
              'assets/images/qualifications/Re-VisitVietnam2026.png', // add your image here
              fit: BoxFit.cover,
            ),
          ),

          // Dark overlay for readability
          Container(
            color: Colors.black.withValues(alpha: 0.3),
          ),

          // Centered Text and Button
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Stars
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Icon(Icons.star, color: Colors.white, size: 30),
                    SizedBox(width: 8),
                    Icon(Icons.star, color: Colors.white, size: 20),
                  ],
                ),
                const SizedBox(height: 20),

                // Title
                Text(
                  'RE-VISIT VIETNAM',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size.width * 0.05,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),

                // Subtitle
                const Text(
                  'PROMOTION',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(height: 40),

                // Circular arrow button
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios,
                        color: Colors.white, size: 20),
                    onPressed: () {
                      Navigator.pushNamed(context, '/our-goals');
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
