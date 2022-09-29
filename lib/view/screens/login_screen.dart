import 'package:demo_app/view/screens/employee_screen.dart';
import 'package:demo_app/view/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController conformPasswordController =
      TextEditingController();
  bool isLogin = true;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    conformPasswordController.dispose();
  }

  //function for creating an account
  void createAccount() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String conformPassword = conformPasswordController.text.trim();

    if (email == "" || password == "" || conformPassword == "") {
      showSnackBar(context, "Please Fill All The detail");
    } else if (password != conformPassword) {
      showSnackBar(context, "Password and conform password not match");
    } else {
      try {
        //to create new account
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        if (userCredential.user != null) {
          showSnackBar(context, "Register Success");
          setState(() {
            isLogin = true;
          });
        }
      } on FirebaseAuthException catch (e) {
        showSnackBar(context, e.code.toString());
      }
    }
  }

  //function for login
  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == "" || password == "") {
      showSnackBar(context, "Please Fill All The detail");
    } else {
      try {
        //to create new account
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        if (userCredential.user != null) {
          setState(() {
            isLoading = false;
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => EmployeeScreen(),
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        showSnackBar(context, e.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (isLogin == true)
              Column(
                children: [
                  const SizedBox(height: 30),
                  CustomTextField(
                    controller: emailController,
                    hintText: "Enter Email",
                    textInputType: TextInputType.emailAddress,
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: passwordController,
                    hintText: "Enter Password",
                    textInputType: TextInputType.text,
                    isObscure: true,
                    icon: Icons.lock,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                      });
                      hideKeyboard();
                      login();
                    },
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text("Login"),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text("Go to "),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isLogin = !isLogin;
                            });
                            hideKeyboard();
                          },
                          child: const Text(
                            "Register",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            if (isLogin == false)
              Column(
                children: [
                  const SizedBox(height: 30),
                  CustomTextField(
                    controller: emailController,
                    hintText: "Enter Email",
                    textInputType: TextInputType.emailAddress,
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: passwordController,
                    hintText: "Enter Password",
                    textInputType: TextInputType.text,
                    isObscure: true,
                    icon: Icons.lock,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: conformPasswordController,
                    hintText: "Enter Conform Password",
                    textInputType: TextInputType.text,
                    isObscure: true,
                    icon: Icons.lock,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      hideKeyboard();
                      createAccount();
                    },
                    child: const Text("Register"),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text("Go to "),
                        InkWell(
                          onTap: () {
                            hideKeyboard();
                            setState(() {
                              isLogin = !isLogin;
                            });
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }
}
