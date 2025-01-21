import 'package:flutter/material.dart';
import 'package:onlineexam/View/quiz/Screen/quiz_screen.dart';
import 'package:get/get.dart';
class langlist extends StatefulWidget {
  const langlist({super.key});

  @override
  State<langlist> createState() => _langlistState();
}

class _langlistState extends State<langlist> {

  final List<String> language = [
  'Python',
  'C',
  'C++',
  'Java',
  'C#',
  'Dart',
  'rust',
  'Go',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exam Topic'),
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Drawer Header
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            // Drawer Items
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_page),
              title: Text('Contact Us'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),





      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              //maxCrossAxisExtent: 150, // Maximum width of each item
              crossAxisSpacing: 20,
              mainAxisSpacing: 10,

              padding: const EdgeInsets.all(10),
              children: List.generate(language.length, (index) {
                return InkWell(
                  onTap: () {
                    Get.to(const QuizScreen(), arguments: language[index]);
                    print(language[index]);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        language[index],
                        style: const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
