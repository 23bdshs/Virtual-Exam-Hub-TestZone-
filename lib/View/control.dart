import 'package:flutter/material.dart';
// layout for bottom navigation

import 'profile.dart';
import 'lang_list.dart';



class control extends StatefulWidget {
  const control({super.key});

  @override
  State<control> createState() => _controlState();
}

class _controlState extends State<control> {
  // Current index for BottomNavigationBar
  var _selectedIndex = 0;

  // List of pages that correspond to each BottomNavigationBar item
  final List<Widget> _pages = [
   const langlist(),
    const Profile(),




  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Display the selected screen
      bottomNavigationBar: BottomNavigationBar(
        // type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // Update the selected index
        selectedItemColor: Colors.blue, // Optional: Color for selected icon
        unselectedItemColor: Colors.black38,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer),
            label: 'Exam',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
