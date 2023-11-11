import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insta/utilities/colors.dart';
import 'package:insta/widgets/text_field_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Container(),
              ),
              // LOGO
              SvgPicture.asset(
                'assets/Instagram Logo.svg',
                // ignore: deprecated_member_use
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(height: 56),
              // IMAGE INPUT
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage(
                        'data:image/jpeg;base64,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'),
                  ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add_a_photo,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // USERNAME
              TextFieldInput(
                hintText: "Username",
                textEditingController: _usernameController,
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 20),
              // EMAIL
              TextFieldInput(
                hintText: "Email",
                textEditingController: _emailController,
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              // PASSWORD
              TextFieldInput(
                hintText: "Password",
                textEditingController: _passwordController,
                textInputType: TextInputType.text,
                isPass: true,
              ),
              const SizedBox(height: 20),
              // BIO
              TextFieldInput(
                hintText: "Bio",
                textEditingController: _bioController,
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 20),
              // Button
              InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: const ShapeDecoration(
                    color: blueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                  ),
                  child: const Text("Log In"),
                ),
              ),
              const SizedBox(height: 12),
              Flexible(
                flex: 2,
                child: Container(),
              ),
              // OTHERS
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    child: const Text("Don`t have an account?"),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
