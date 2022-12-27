import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            loginText(),
            textField(),
            SizedBox(
              height: 50,
            ),
            loginButton(),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Belum mempunyai Akun ? ",
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Container();
                        },
                      ),
                    );
                  },
                  child: const Text(
                    "Daftar",
                    style: TextStyle(
                      color: Color.fromARGB(255, 107, 53, 165),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget loginText() {
    return Row(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 20, top: 150, right: 0, bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Text(
                "Selamat Datang Di",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(""),
              // ignore: prefer_const_constructors
              Text(
                "E-Ticketing Wisata Donorojo",
                // ignore: prefer_const_constructors
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget textField() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              suffixIcon: const Icon(Icons.person),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            obscureText: true,
            controller: passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              suffixIcon: Icon(Icons.lock),
            ),
          ),
        ),
      ],
    );
  }

  Widget loginButton() {
    return SizedBox(
      width: 150,
      child: Hero(
        tag: "login_btn",
        child: ElevatedButton(
          // style: ButtonStyle(
          //   backgroundColor: MaterialStatePropertyAll<Color>(Colors.white)),
          onPressed: () {},
          child: Text(
            style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
            "Login".toUpperCase(),
          ),
        ),
      ),
      // textButton(
      //     onPressed: (() async {
      //       // User? user = await loginUsingEmailPassword(
      //       //     email: emailController.text,
      //       //     password: passwordController.text,
      //       //     context: context);
      //       // print(user);
      //       // if (user != null) {
      //       //   // ignore: use_build_context_synchronously
      //       //   Navigator.of(context).pushReplacement(
      //       //       MaterialPageRoute(builder: (context) => home()));
      //       // }T
      //     }),
      //     child: Text('Masuk')),
    );
  }

  Widget registerButton() {
    return SizedBox(
      width: 150,
      child: OutlinedButton(
          onPressed: () {
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => Register()));
          },
          child: Text('Daftar')),
    );
  }
}
