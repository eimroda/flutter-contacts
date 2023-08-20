import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String url = "http://localhost/coc/contacts/api/user.php";
  TextEditingController _fullNameCntrl = TextEditingController();
  TextEditingController _usernameCntrl = TextEditingController();
  TextEditingController _passwordCntrl = TextEditingController();

  Future<void> register() async {
    Map<String, String> _jsonData = {
      'fullname': _fullNameCntrl.text,
      'username': _usernameCntrl.text,
      'password': _passwordCntrl.text
    };

    Map<String, String> requestData = {
      'json': jsonEncode(_jsonData),
      'operation': 'signup'
    };

    var response = await http.post(Uri.parse(url), body: requestData);
    print(response.body);
    if (response.body == '1') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("You have registered successfully!"),
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something is wrong."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "My Contacts Database",
              style: TextStyle(color: Colors.red, fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                labelText: "Full Name",
                hintText: "Enter your full name",
                prefixIcon: Icon(Icons.abc_outlined),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                labelText: "Username",
                hintText: "Enter your username",
                prefixIcon: Icon(Icons.person_2),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                labelText: "Password",
                hintText: "Enter your password",
                prefixIcon: Icon(Icons.password),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  register();
                },
                child: Text("Register"),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
