import 'package:final_exam_project/shared/theme.dart';
import 'package:final_exam_project/widgets/customized_button.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget nameInput() {
      return TextField(
        decoration: InputDecoration(
          labelText: "First name",
          labelStyle: blackTextStyle.copyWith(
            fontSize: 20,
            fontWeight: light,
          ),
          hintText: "Your first name here",
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

    Widget emailInput() {
      return TextField(
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
                  image: AssetImage(
                    'assets/logo_pu.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Register to PUIS",
              style: blackTextStyle.copyWith(
                fontSize: 28,
                fontWeight: medium,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Please register to continue',
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
                  nameInput(),
                  const SizedBox(
                    height: 28,
                  ),
                  emailInput(),
                  const SizedBox(
                    height: 28,
                  ),
                  passwordInput(),
                ],
              ),
            ),
            const Spacer(),
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
                      Navigator.pushNamed(context, '/register-page');
                    },
                    text: "Sign Up",
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 32,
            ),
          ],
        ),
      ),
    );
  }
}
