import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lesson01/register.dart';
import 'package:http/http.dart' as http;
import 'package:lesson01/mainpage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String url = 'http://localhost/coc/contacts/api/user.php';
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> login() async {
    //define jsonData
    Map<String, String> jsonData = {
      'username': _usernameController.text,
      'password': _passwordController.text
    };

    Map<String, String> requestBody = {
      'operation': 'login',
      'json': jsonEncode(jsonData)
    };
    var response = await http.post(Uri.parse(url), body: requestBody);
    if (response.body != '0') {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Mainpage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Invalid username or password, please try again!"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'My Contacts Database',
              style: TextStyle(fontSize: 20, color: Colors.blue),
            ),
            SizedBox(
              height: 30,
            ),
            ClipOval(
              child: Image.asset(
                'assets/pictures/buck.jpg',
                width: 250,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            const Text(
              'Login',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                labelText: "Username",
                hintText: "Inpur username",
                prefixIcon: Icon(Icons.person),
                suffixIcon: Icon(Icons.check),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                labelText: "Password",
                hintText: "Enter your password",
                prefixIcon: Icon(Icons.password),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 40.0,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  login();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: const Text("Login"),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Register()),
                  );
                },
                child: const Text(
                  "Click Here to Register",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
