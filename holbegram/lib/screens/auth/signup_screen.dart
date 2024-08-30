import 'package:flutter/material.dart';
import '../../widgets/text_field.dart';
import 'login_screen.dart';
import 'package:holbegram/screens/auth/upload_image_screen.dart';
// firebase stuff

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final emailController = TextEditingController();
  final fullNameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    final passwordVisibleIcons = IconButton(
      alignment: Alignment.bottomLeft,
      color: const Color.fromARGB(218, 226, 37, 24),
      onPressed: () => setState(() { passwordVisible = !passwordVisible; }),
      icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
    );

    return Scaffold(
      body: Column(
        children: <Widget>[
          const Text(
            'Holbegram',
            style: TextStyle(
              fontFamily: 'Billabong',
              fontSize: 50,
            ),
          ),
          Image.asset(
            'assets/images/logo.webp',
            width: 80,
            height: 60,
          ),
          const SizedBox(height: 24),
          const Text(
            'Sign up to see photos and videos from your friends.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 18,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 24),
                TextFieldInput(
                  controller: emailController,
                  isPassword: false,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  filled: true,
                ),
                const SizedBox(height: 24),
                TextFieldInput(
                  controller: fullNameController,
                  isPassword: false,
                  hintText: 'Full name',
                  keyboardType: TextInputType.name,
                  filled: true,
                ),
                const SizedBox(height: 24),
                TextFieldInput(
                  controller: passwordController,
                  isPassword: !passwordVisible,
                  hintText: 'Password',
                  keyboardType: TextInputType.visiblePassword,
                  suffixIcon: passwordVisibleIcons,
                  filled: true,
                ),
                const SizedBox(height: 24),
                TextFieldInput(
                  controller: passwordConfirmationController,
                  isPassword: !passwordVisible,
                  hintText: 'Confirm Password',
                  keyboardType: TextInputType.visiblePassword,
                  suffixIcon: passwordVisibleIcons,
                  filled: true,
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: Builder(
                    builder: (BuildContext context) {
                      return ElevatedButton(
                        onPressed: () {
                          String email = emailController.text;
                          String username = fullNameController.text;
                          String password = passwordController.text;
                          String passwordConfirmation = passwordConfirmationController.text;

                          if (password == passwordConfirmation) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:(BuildContext context) => AddPicture(email: email, password: password, username: username),
                              ),
                            );
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(const Color.fromARGB(218, 226, 37, 24)),
                        ),
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          const Divider(
            thickness: 2,
            height: 2,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Have an account?'),
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const LoginScreen(),
                  ),
                ),
                child: const Text(
                  'Log in',
                  style: TextStyle(color: Color.fromARGB(218, 226, 37, 24)),
                ),
              ),
            ]
          )
        ],
      ),
    );
  }
}
