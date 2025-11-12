import 'package:flutter/material.dart';

class KarmaTabsPage extends StatelessWidget {
  const KarmaTabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5, // total tabs
      child: Scaffold(
        backgroundColor: const Color(0xFF300010),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Karma Group",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          bottom: const TabBar(
            isScrollable: true,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.amber,
            indicatorWeight: 3,
            labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: "OUR GOALS"),
              Tab(text: "HOW IT WORKS"),
              Tab(text: "KARMA GROUP"),
              Tab(text: "SPONSORS"),
              Tab(text: "KARMA CLUB"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            GoalsTab(),
            Center(child: Text("How It Works", style: TextStyle(color: Colors.white))),
            Center(child: Text("Karma Group", style: TextStyle(color: Colors.white))),
            Center(child: Text("Sponsors", style: TextStyle(color: Colors.white))),
            Center(child: Text("Karma Club", style: TextStyle(color: Colors.white))),
          ],
        ),
      ),
    );
  }
}

// Example for OUR GOALS tab
class GoalsTab extends StatelessWidget {
  const GoalsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            "OUR GOALS",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GoalCircle(icon: Icons.campaign, text: "PROMOTING\nTOURISM\nIN VIETNAM"),
              GoalCircle(icon: Icons.people, text: "HELPING\nLOCAL\nPEOPLE"),
              GoalCircle(icon: Icons.store, text: "HELPING\nLOCAL\nBUSINESSES"),
              GoalCircle(icon: Icons.monetization_on, text: "INCREASING\nINVESTMENT\nIN VIETNAM"),
            ],
          ),
          const SizedBox(height: 20),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 2,
            crossAxisSpacing: 10,
            children: [
              Image.network("assets/images/good-karma/Experience Karma.jpg", fit: BoxFit.contain),
              Image.network("assets/images/good-karma/Experience Karma.jpg", fit: BoxFit.contain),
              Image.network("assets/images/good-karma/Experience Karma.jpg", fit: BoxFit.contain),
              Image.network("assets/images/good-karma/Experience Karma.jpg", fit: BoxFit.contain),
            ],
          ),
        ],
      ),
    );
  }
}

class GoalCircle extends StatelessWidget {
  final IconData icon;
  final String text;
  const GoalCircle({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.amber, width: 2),
            gradient: const LinearGradient(
              colors: [Colors.black54, Colors.black26],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Icon(icon, color: Colors.white, size: 32),
        ),
        const SizedBox(height: 10),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}