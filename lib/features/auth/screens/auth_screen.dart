import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService authService = AuthService();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        context: context);
  }

  void signInUser() {
    authService.signInUser(
        email: _emailController.text,
        password: _passwordController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: GlobalVariables.greyBackgroundCOlor,
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome',
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
                  ),
                  ListTile(
                    tileColor: _auth == Auth.signup ? Colors.white : null,
                    leading: Radio(
                        activeColor: GlobalVariables.secondaryColor,
                        value: Auth.signup,
                        groupValue: _auth,
                        onChanged: (val) {
                          setState(() {
                            _auth = val!;
                          });
                        }),
                    title: const Text(
                      'Create Account',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (_auth == Auth.signup)
                    Container(
                      color: Colors.white,
                      child: Form(
                          key: _signUpFormKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 8.w, right: 8.w, bottom: 10.h),
                                child: CustomTextFormField(
                                  hint: 'Name',
                                  controller: _nameController,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 8.w, right: 8.w, bottom: 10.h),
                                child: CustomTextFormField(
                                  hint: 'Email',
                                  controller: _emailController,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 8.w, right: 8.w, bottom: 10.h),
                                child: CustomTextFormField(
                                  obscureText: true,
                                  hint: 'Password',
                                  controller: _passwordController,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 8.w, right: 8.w, bottom: 10.h),
                                child: CustomButton(
                                  text: 'Sign Up',
                                  onTap: () {
                                    if (_signUpFormKey.currentState!
                                        .validate()) {
                                      signUpUser();
                                    }
                                    // signUpUser();
                                  },
                                ),
                              ),
                            ],
                          )),
                    ),
                  ListTile(
                    tileColor: _auth == Auth.signin ? Colors.white : null,
                    leading: Radio(
                        activeColor: GlobalVariables.secondaryColor,
                        value: Auth.signin,
                        groupValue: _auth,
                        onChanged: (val) {
                          setState(() {
                            _auth = Auth.signin;
                          });
                        }),
                    title: const Text(
                      'Sign in',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (_auth == Auth.signin)
                    Container(
                      color: Colors.white,
                      child: Form(
                          key: _signInFormKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 8.w, right: 8.w, bottom: 10.h),
                                child: CustomTextFormField(
                                  hint: 'Email',
                                  controller: _emailController,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 8.w, right: 8.w, bottom: 10.h),
                                child: CustomTextFormField(
                                  hint: 'Password',
                                  controller: _passwordController,
                                  obscureText: true,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 8.w, right: 8.w, bottom: 10.h),
                                child: CustomButton(
                                  text: 'Sign In',
                                  onTap: () {
                                    if (_signInFormKey.currentState!
                                        .validate()) {
                                      signInUser();
                                    }
                                  },
                                ),
                              ),
                            ],
                          )),
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
