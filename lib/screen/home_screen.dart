import 'package:flutter/material.dart';
import 'package:ulis_ync/screen/custom_drawer.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () { Scaffold.of(context).openDrawer(); },
            );
          },
        ),
        title: Text('Home'),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
      drawer: const CustomDrawer(), // Thêm Drawer ở đây
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'YOUR TEAMS:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 0.8,
              children: [
                TeamCard(image: 'assets/images/team1.jpg', name: 'ELT 1 - GROUP 1'),
                TeamCard(image: 'assets/images/team2.jpg', name: 'GEO 4 - GROUP 6'),
                TeamCard(image: 'assets/images/team3.jpg', name: 'LING 2 - GROUP 2'),
                TeamCard(image: 'assets/images/team1.jpg', name: 'ELT 2 - GROUP 1'),
                TeamCard(image: 'assets/images/team2.jpg', name: 'GEO 3 - GROUP 6'),
                TeamCard(image: 'assets/images/team3.jpg', name: 'LING 4 - GROUP 2'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TeamCard extends StatelessWidget {
  final String image;
  final String name;

  const TeamCard({Key? key, required this.image, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(image, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}