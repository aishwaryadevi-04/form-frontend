import 'package:flutter/material.dart';
import 'package:flutter_application_1/confirmation.dart';
import 'package:flutter_application_1/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MaterialApp(
      home: Home(),
      initialRoute: '/form',
      routes: {
        '/form':(context) =>  Home(),
        '/confirmation': (context) => const Confirm(),
      },
    ));

class Home extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  User user = User('', '', '', 0);
  @override
  Widget build(BuildContext context) {
    TextEditingController numberController = TextEditingController();
     var url = Uri.parse("https://form-app-vgmb.onrender.com/form");
     Future<String?> save() async {
      try {
        var res = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json;charSet=UTF-8'
          },
          body: json.encode({
            'name': user.name,
            'email': user.email,
            'password': user.password,
            'phoneno': user.phoneno
          })
        );
        var data = json.decode(res.body);
        if (data['error'] != null) {
          return data['error'];
        } else {
          return null;
        }
      } catch (error) {
        return 'An error occurred';
      }
    }

        return Scaffold(
            body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/gradient.jpg"),
              fit: BoxFit.cover,
            ),
          ),

          child: Column(children: [
            const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
            Text(
              "Welcome",
              style: GoogleFonts.lobster(
                textStyle: const TextStyle(color: Colors.white),
                fontSize: 45,
              ),
            ),

            Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.purple,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),

                    child: Form(
                        key: formKey,
                        child: Column(children: <Widget>[
                          TextFormField(
                            controller: TextEditingController(text: user.name),
                            onChanged: (value) {
                              user.name = value;
                            },
                            autofocus: true,
                            decoration: const InputDecoration(
                              labelText: 'Name',
                            ),
                          validator: (value) {
                                if (value!.isEmpty) return "Name is required";
                                if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) return "Enter a valid name";
                                return null;
                              },

                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 10.0),

                          TextFormField(
                            controller: TextEditingController(text: user.email),
                            onChanged: (value) {
                              user.email = value;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Email',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) return "Email is required";
                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) return "Enter a valid email";
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 10.0),

                          TextFormField(
                            obscureText: true,
                            controller: TextEditingController(text: user.password),
                            onChanged: (value) {
                              user.password = value;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Password',
                            ),
                              validator: (value) {
                                  if (value!.isEmpty) return "Password is required";
                                  if (value.length < 6) {
                                    return "Password must be at least 6 characters";
                                  }
                                  return null;
                                },
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 10.0),

                          TextFormField(
                            controller: numberController, 
                            keyboardType: TextInputType.number, 
                            onChanged: (value) {
                              user.phoneno = int.tryParse(value) ?? 0;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Phone no',
                            ),
                            validator: (value) {
                                if (value!.isEmpty) return "Phone no is required";
                                if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) return "Enter a valid 10-digit phone number";
                                return null;
                              },
                          ),
                          const SizedBox(height: 70.0),

                          ElevatedButton(
                            onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      final errorMessage = await save();
                                      if (errorMessage == null) {
                                        Navigator.pushNamed(context, '/confirmation');
                                        formKey.currentState!.reset();
                                      } else {
                                        final snackBar = SnackBar(
                                          content: Center(
                                            child: Text(errorMessage),
                                          ),

                                          backgroundColor: Colors.red,
                                        );
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      }
                                    }
                              },

                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(172, 55, 28, 191),
                              textStyle: const TextStyle(fontSize: 18),
                              padding: const EdgeInsets.all(15),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              minimumSize: const Size(150, 50),
                            ),
                            child: const Text('SUBMIT'),
                          )
                    ]))
              )),
      ]),
    ));
  }
}


