import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

// import 'package:image_picker/image_picker.dart'; // Import image picker
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? username;
  String? email;
  List<dynamic> scores = [];
  bool isLoading = true;
  File? _image; // To store the selected image

  @override
  void initState() {
    super.initState();
    _getUserData();
    // _loadProfileImage(); // Load profile image from SharedPreferences
  }

  Future<void> _getUserData() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? storedUsername = prefs.getString('username');

    var box = await Hive.openBox('userBox'); // Open the box to retrieve the username
    String? storedUsername = box.get('username');

    if (storedUsername != null) {
      setState(() {
        username = storedUsername;
      });

      // API URL to fetch the user's scores
      String url = 'http://192.168.0.110/peart/profiledatafatch.php?username=$username';

      try {
        final response = await http.get(Uri.parse(url));

        // Debugging: print the raw response to see what you get from the server
        print('Response body: ${response.body}');

        if (response.statusCode == 200) {
          // Try to decode the response as JSON
          var jsonData = json.decode(response.body);

          if (jsonData['status'] == 'success') {
            setState(() {
              email = jsonData['email'];
              scores = jsonData['scores'];
              isLoading = false;
            });
          } else {
            print("Error: ${jsonData['message']}");
            setState(() {
              isLoading = false;
            });
          }
        } else {
          print("Failed to fetch data: ${response.statusCode}");
          setState(() {
            isLoading = false;
          });
        }
      } catch (e) {
        // Handle JSON parsing errors or other exceptions
        print("Error parsing response: $e");
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // // Load profile image from SharedPreferences
  // Future<void> _loadProfileImage() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? imagePath = prefs.getString('profile_image');
  //   if (imagePath != null) {
  //     setState(() {
  //       _image = File(imagePath);
  //     });
  //   }
  // }
  //
  // // Pick image from gallery
  // Future<void> _pickImage() async {
  //   final ImagePicker picker = ImagePicker();
  //   final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  //
  //   if (image != null) {
  //     setState(() {
  //       _image = File(image.path);
  //     });
  //
  //     // Save image path to SharedPreferences
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     prefs.setString('profile_image', image.path);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blueAccent,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          children: [
            // Display profile picture or a placeholder
            GestureDetector(
              // onTap: _pickImage, // Pick image when tapped
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _image != null
                    ? FileImage(_image!) // Display selected image
                    : const AssetImage('assets/palceholder.jpg') as ImageProvider, // Default placeholder
                child: _image == null
                    ? Align(alignment: Alignment.bottomRight,
                    child: const Icon(Icons.camera_alt, size: 25, color: Colors.green))
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '$username',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '$email',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            // const Text(
            //   'Scores:',
            //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            // ),

            // ElevatedButton(
            //   onPressed: () {
            //     // Navigate to leaderboard page
            //     Navigator.pushNamed(context, '/leaderboard');
            //   },
            //   child: const Text('View Leaderboard'),
            // ),





            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: scores.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Score: ${scores[index]}'),
                );
              },
            ),
            const SizedBox(height: 20),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, '/leaderboard');
        },
        child: Text('Leader Board',style: TextStyle(
          color: Colors.red
        ),),
        tooltip: 'Leader Boardr',
      ),

    );
  }
}
