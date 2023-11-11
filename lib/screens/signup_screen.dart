import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta/resources/auth_methods.dart';
import 'package:insta/utilities/colors.dart';
import 'package:insta/utilities/utils.dart';
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
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    // ignore: unused_local_variable
    String res = await AuthMethods().signUpUser(
      username: _usernameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      bio: _bioController.text,
      file: _image!,
    );
    setState(() {
      _isLoading = false;
    });
    if (res != 'success') {
      // ignore: use_build_context_synchronously
      showSnackBar(res, context);
    }
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
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: (MemoryImage(_image!)),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAHoAAAB6CAMAAABHh7fWAAAAJFBMVEX////d3d3c3Nzx8fH8/Pz4+Pjg4ODq6uru7u7l5eX09PTZ2dkx2nHeAAAEy0lEQVRogcVb2ZasIAxs2Zf//98LqO3SYCoIc+tp+oxSZiEkAT4fPpQO0lnrC6x1MmjVMQyXNTi/iAoW78JEfu1Mpl2qyP8wTk/htabFeuY3djC7ciaSvBt7NG6c5pWl5b3KbseQa48KfBbdv9e76iDeyN9JzlX1hfyV2uXSTVzIF9krsn9FXMj7tK77dX3iFoHPbON74oxomcQDlL2DqXT9zr9u3AtjjocRZj5x4wYPQ4kLOcgdBjnYGRHinsGMcc9hRrjH23kHZW89jTlxP84xZWZSL0+xZVwMq3L7NrOb5GI7omsaejJz4m6YW80mzqib20419ApRXULnzegLd212m79gXhZT8W5mli/Wqq9dhLXe/PFyxRhAxMW6VNiqj1JaupSpc9jF3dNgH6vVVJqTrt89DRVaiEZFIw0cFG5ig0I/lVIOjf9XsRX0yUQ1oVCjxbPY0EvCUFmtxLgvYrNfaAkOJtHHG0hS1F51LtyQwU/JErBMY8wg97FwAzML0fbODYj9nV90DH3KL+5A0rtvNKV19BP8ngCsBmJbROgUQfC6A4i5V1kk5d8cdRdZ6AkTV2FI/35OoCugI9QmDfgYR2xS6jWqaJKa330DAkUelAq8fKGRCVY8lzLMb0YDgIwrJUZRyok9rS/S0YoukWfYAAqZ9BSlb27fqwAIU7RHMCPZDtrYmiw6WhUaATpOBXJudXkZ4meSpu5ippevRE09I/qoyQwxhYv/SE0Gs1nUlqSeZmuAepaH09Q9OwgfZF5b2s16Fi4gJUY8vG/5oBdsR7siWeTVQBd+KaSQjaOuIE5nSMmHSNX0rJpA9ZNWLrrg6tA4UGjngoZ8KvJXbKDkE9BjlS7bM5DGYx4U8Aiu2IjQec4ibUKetZGWSolUgHZ4YQXqwZX4jBRIrECO7WIURbI6EDSwXYzVdaGmGezlWO9si1PQ3pYAuck+wTbcGp2hng/QK8RlPiIk5hfC0OsI2iX9ThlwB1VQWQN+yuDbLsQ0nt94PHYQ8FMGh/HgrxXtFVQztkNPIYqxrZfIayYP+CbAcs0+OBtNQpjrWT4lPXPb5zxR0TnxZV+Mt05K6awvP3mvX1ZC3rsr/X6gkY+LrXgbbO9wn6N/SX1zUbISYIAY6ScwPTi5EFH41a1I5FO14nGn8XcdaiYrQnjuyVTtfJO8lnXUQ5roPBWqGpt91VyrliiJRXYfTVT1k4nV8X7iytujqJXzmK28+qZy1hG1Ou5H5tqp7eW52FVY3+Evy0q7J3RewdDtPArnBPWpXj4CS18f482Yu7nHMR/cVA2zco9k3rnJ6qnsxPa139vIiSqQTKscOccyZ10+HzY7uLuaRk9DGoh53fUfepdAEwfsztym64BzC0Fw1OjJSgOHY/pOWu4H+ZqPXK91cYjBk5n5EVmntOj19LYpVerqcybBX3lbWLrNFnJ06c9Schzp/vScZnRmKi9e3ZBK154RCjHQhXiGzNk/78aOLpVn73WTC7mJjJtS5f5VNCOIM/LlpsxOyq4z75BrTQeUzWOKxYbmqDrYbJuhN8n2ofMNulzUGyu1VmojSH9oLa0p1/rG35/7ssvSQxAx5i/YseTfOdn3chLvTl+7LpmvSs6lPZCUHNaqNuje+6H/ABEJMCZy2l1CAAAAAElFTkSuQmCC'),
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
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
                onTap: signUpUser,
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
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : const Text("Log In"),
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
