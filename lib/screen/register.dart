import 'package:employee_crud_fontend/model/user.dart';
import 'package:employee_crud_fontend/repository/user_repository.dart';
import 'package:employee_crud_fontend/screen/employe_list.dart';
import 'package:employee_crud_fontend/screen/login.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final registerFormkey = GlobalKey<FormState>();

  final _name = TextEditingController();

  final _email = TextEditingController();

  final _password = TextEditingController();

  final _confirmpassword = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmpassword.dispose();
    _name.dispose();
    super.dispose();
  }

  home() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute<void>(
            builder: (BuildContext context) => const EmployeList()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    register() async {
      var x = await UserRepo().register(
        User(
            name: _name.value.text,
            email: _email.value.text,
            password: _password.value.text),
      );
      if (x == 'success') {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ));
        home();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(x)));
      }
    }

    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: registerFormkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "Créer un compte.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 25),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      TextFormField(
                          controller: _name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Username',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a Username';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                          controller: _email,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a E-mail';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                          controller: _password,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your Password';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                          controller: _confirmpassword,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Confirm Password',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please confirm your Password';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (registerFormkey.currentState!.validate()) {
                            if (_confirmpassword.value.text ==
                                _password.value.text) {
                              register();
                            }
                          }
                        },
                        child: Container(
                          height: 50.0,
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.lightBlue[500],
                          ),
                          child: const Center(
                            child: Text('Sign Up'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const Login()),
                              (route) => false);
                        },
                        child: const Text(
                          "You already have an acount ? Login here .",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
