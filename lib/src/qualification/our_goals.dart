import 'dart:ui';
import 'package:flutter/material.dart';
import '../../constants/app_data.dart';

class OurGoalsPage extends StatefulWidget {
  const OurGoalsPage({super.key});

  @override
  State<OurGoalsPage> createState() => _OurGoalsPageState();
}

class _OurGoalsPageState extends State<OurGoalsPage> {
  int _activeIndex = 0;

  final List<String> _tabs = [
    "OUR GOALS",
    "HOW IT WORKS",
    "KARMA GROUP",
    "SPONSORS",
    "KARMA SONG HOAI",
    "KARMA CLUB",
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('${AppAPI.baseUrlGcp}${'assets/images/qualifications/OurGoalsBG2026.png'}'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Top navigation bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.home, color: Colors.white, size: 28),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          _tabs.length,
                              (index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                _activeIndex = index;
                              });
                            },
                            child: _buildNavItem(_tabs[index], _activeIndex == index),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 60),

                // Tab content
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4), // semi-transparent overlay
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.black.withOpacity(0.1), width: 0),
                        ),
                        child: _buildTabContent()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(String title, bool isActive) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              letterSpacing: 1,
            ),
          ),
          if (isActive)
            Container(
              margin: const EdgeInsets.only(top: 5),
              height: 2,
              width: 60,
              color: Colors.white,
            ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_activeIndex) {
      case 0:
        return _ourGoalsContent();
      case 1:
        return const Center(child: Text("HOW IT WORKS", style: TextStyle(color: Colors.white, fontSize: 24)));
      case 2:
        return const Center(child: Text("KARMA GROUP", style: TextStyle(color: Colors.white, fontSize: 24)));
      case 3:
        return const Center(child: Text("SPONSORS", style: TextStyle(color: Colors.white, fontSize: 24)));
      case 4:
        return const Center(child: Text("KARMA SONG HOAI", style: TextStyle(color: Colors.white, fontSize: 24)));
      case 5:
        return const Center(child: Text("KARMA CLUB", style: TextStyle(color: Colors.white, fontSize: 24)));
      default:
        return Container();
    }
  }

  Widget _ourGoalsContent() {
    return Column(
      children: [
        const Text(
          "OUR GOALS",
          style: TextStyle(
            color: Colors.white,
            fontSize: 36,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 40),
        const Wrap(
          alignment: WrapAlignment.center,
          spacing: 60,
          runSpacing: 30,
          children: [
            _GoalItem(imagePath:"assets/images/qualifications/promoting.png", title: "PROMOTING\nTOURISM IN VIETNAM"),
            _GoalItem(imagePath:"assets/images/qualifications/people.png", title: "HELPING\nLOCAL PEOPLE"),
            _GoalItem(imagePath:"assets/images/qualifications/business.png", title: "HELPING\nLOCAL\nBUSINESSES"),
            _GoalItem(imagePath:"assets/images/qualifications/investment.png", title: "INCREASING\nINVESTMENT IN VIETNAM"),
          ],
        ),
        const SizedBox(height: 60),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _imageItem('assets/images/qualifications/goals-group1.png'),
                _imageItem('assets/images/qualifications/goals-group2.png'),
                _imageItem('assets/images/qualifications/goals-group3.png'),
                _imageItem('assets/images/qualifications/goals-group4.png'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 40),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(10),
            child: const Icon(Icons.arrow_forward, color: Colors.white, size: 26),
          ),
        ),
      ],
    );
  }

  Widget _imageItem(String path) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1.1,
        child: Image.network('${AppAPI.baseUrlGcp}$path', fit: BoxFit.contain),
      ),
    );
  }
}

class _GoalItem extends StatelessWidget {
  final String imagePath;
  final String title;

  const _GoalItem({required this.imagePath, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const RadialGradient(
          colors: [Color(0xFFB87333), Colors.transparent],
          radius: 0.8,
        ),
        border: Border.all(color: Colors.orangeAccent.withOpacity(0.7), width: 2),
      ),
      child: Container(
        margin: const EdgeInsets.all(3), // thickness of the border
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          // Inner background color (optional)
          color: Colors.black.withOpacity(0.5),
          // Gradient border using ShaderMask trick
          border: Border.all(
            width: 3,
            color: Colors.transparent,
          ),
          // gradient: LinearGradient(colors:[Color()])
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network('${AppAPI.baseUrlGcp}$imagePath', fit: BoxFit.cover,height: 28,),
                const SizedBox(height: 10),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}