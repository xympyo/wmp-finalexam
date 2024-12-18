import 'package:final_exam_project/shared/theme.dart';
import 'package:final_exam_project/widgets/customized_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    String errorMsg = "";

    final FirebaseAuth _auth = FirebaseAuth.instance;

    void submitButton() async {
      print(emailController.text);
      print(passwordController.text);
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);

        print("User signed in : ${userCredential.user?.email}");

        Navigator.pushNamed(context, '/enrollment-page');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          errorMsg = "User is not found!";
        } else if (e.code == 'wrong-password') {
          errorMsg = "Wrong password!";
          print(errorMsg);
        }
      }
    }

    Widget emailInput() {
      return TextField(
        controller: emailController,
        decoration: InputDecoration(
          labelText: "Your email",
          labelStyle: blackTextStyle.copyWith(
            fontSize: 20,
            fontWeight: light,
          ),
          hintText: "Enter your email...",
          hintStyle: blackTextStyle.copyWith(
            fontSize: 20,
            fontWeight: light,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kBlackColor,
            ),
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kPurpleColor,
            ),
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
        ),
      );
    }

    Widget passwordInput() {
      return TextField(
        obscureText: true,
        controller: passwordController,
        decoration: InputDecoration(
          labelText: "Your password",
          labelStyle: blackTextStyle.copyWith(
            fontSize: 20,
            fontWeight: light,
          ),
          hintText: "Your password here...",
          hintStyle: blackTextStyle.copyWith(
            fontSize: 20,
            fontWeight: light,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kBlackColor,
            ),
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kPurpleColor,
            ),
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 216,
                height: 216,
                margin: EdgeInsets.only(
                  top: 64,
                  left: defaultMargin,
                  right: defaultMargin,
                ),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/logo_pu.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "It's easier to enroll now.",
                style: blackTextStyle.copyWith(
                  fontSize: 28,
                  fontWeight: medium,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Please log in to continue',
                style: blackTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: light,
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              Container(
                margin: EdgeInsets.only(
                  left: defaultMargin,
                  right: defaultMargin,
                ),
                child: Column(
                  children: [
                    emailInput(),
                    const SizedBox(
                      height: 28,
                    ),
                    passwordInput(),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: EdgeInsets.only(
                  left: defaultMargin,
                  right: defaultMargin,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomizedButton(
                      height: 60,
                      onTap: () {
                        submitButton();
                        print("Button tapped!");
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          'Not a member?',
                          style: blackTextStyle.copyWith(
                            fontSize: 20,
                            fontWeight: light,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register-page');
                          },
                          child: Text(
                            'Register now',
                            style: purpleTextStyle.copyWith(
                              fontSize: 20,
                              fontWeight: light,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
