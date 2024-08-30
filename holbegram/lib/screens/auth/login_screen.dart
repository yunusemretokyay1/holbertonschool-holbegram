import 'package:flutter/material.dart';
import '../../widgets/text_field.dart';
import 'signup_screen.dart';
import '../home.dart';
// firebase stuff
import  '../../methods/auth_methods.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<StatefulWidget> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Text(
              'Holbegram',
              style: TextStyle(
                fontFamily: 'Billabong',
                fontSize: 50
              ),
            ),
            Image.asset(
              'assets/images/logo.webp',
              width: 80,
              height: 60
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20
              ),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 28),
                  TextFieldInput(
                    controller: emailController,
                    isPassword: false,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    filled: true,
                  ),
                  const SizedBox(height: 24),
                  TextFieldInput(
                    controller: passwordController,
                    isPassword: !_passwordVisible,
                    hintText: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: IconButton(
                      alignment: Alignment.bottomLeft,
                      color: const Color.fromARGB(218, 226, 37, 24),
                      icon: Icon(
                        _passwordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () => setState(() { _passwordVisible = !_passwordVisible; }),
                    ),
                    filled: true,
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: Builder(
                      builder: (BuildContext context) {
                        return ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              const Color.fromARGB(218, 226, 37, 24),
                            ),
                          ),
                          onPressed: () {
                            AuthMethods().login(email: emailController.text, password: passwordController.text)
                              .then((result) {
                                print('result: $result');

                                if (result == 'success') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Log In')),
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) => const Home(),
                                    ),
                                  );
                                }
                              });
                          },
                          child: const Text(
                            'Log in',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Forgot your login details?'),
                      Text('Get help logging in', style: TextStyle(fontWeight: FontWeight.bold)), // should be a button?
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Divider(thickness: 2),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => const Signup(),
                            ),
                          ),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(218, 226, 37, 24),
                            ),
                          ),
                        ),
                      ],
                    )
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: <Widget>[
                      Flexible(child: Divider(thickness: 2)), // just use expand?
                      Text('OR'),
                      Flexible(child: Divider(thickness: 2)), // just use expand?
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min, // necessary?
                    children: <Widget>[
                      Image.network(
                        'https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-webinar-optimizing-for-success-google-business-webinar-13.png',
                        width: 40,
                        height: 40,
                      ),
                      const Text('Sign in with Google'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
