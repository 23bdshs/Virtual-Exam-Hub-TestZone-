import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
// import 'package:learn_program/control/control.dart';
// import 'package:onlineexam/View/quiz/Screen/quiz_screen.dart';
import 'registration.dart';
import 'package:http/http.dart' as http;
import 'control.dart';
// import 'controllar/namecontrol.dart';


class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  Future<void> login(String username, String password, BuildContext context) async {
    if (username.isEmpty || password.isEmpty) {
      final snackBar = SnackBar(
        content: Text('Please fill in all fields'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return; // Exit the function if fields are empty
    }

    final response = await http.post(
      Uri.parse('http://192.168.0.110/peart/login.php'),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data['message']);

      if (data['status'] == 'success') {

        //i want to add here username store in getx controlalr from controllar/namecontrol.dart

       // final nameController namecontroller = Get.put(nameController());
       //  namecontroller.setUsername(username);

       // Open the box
       var box = await Hive.openBox('userBox');
// Put data into the box
        box.put('username', username);

        Navigator.pushReplacement(
          context,
          // MaterialPageRoute(builder: (context) => QuizScreen()),
          MaterialPageRoute(builder: (context) => control()),
        );

        //here screen route





      } else {
        print('Login failed: ${data['message']}');

       late SnackBar snackBar = SnackBar(
          content: Text('Login failed: ${data['message']}'),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }
    } else {
      print('Login failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(onPressed: () {
                      // Get.offNamed('/faq');
                    }, icon: Icon(Icons.policy)),
                  ],
                ),
                Lottie.asset(
                  'assets/lottie/login.json',
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 40),
                Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                    backgroundColor: Colors.white60,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: "Username",
                    labelStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.email, color: Colors.blueAccent),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.lock, color: Colors.blueAccent),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      print("Forgot Password tapped");
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                ),
                SizedBox(height: 20),



                ElevatedButton(
                  onPressed: () {
                    login(
                      _usernameController.text,
                      _passwordController.text,
                      context,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 18, color: Colors.blue),
                  ),
                ),



                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Don\'t have an account?'),
                    TextButton(
                      onPressed: () {
                        Get.to(RegisterScreen());
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sign In With',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.facebook, color: Colors.red),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.mail_outline_rounded, color: Colors.red),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.language, color: Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
