import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_exam_project/pages/login_page.dart';
import 'package:final_exam_project/shared/theme.dart';
import 'package:final_exam_project/widgets/customized_button.dart';
import 'package:final_exam_project/widgets/subject_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EnrolledPage extends StatefulWidget {
  const EnrolledPage({super.key});

  @override
  State<EnrolledPage> createState() => _EnrolledPageState();
}

class _EnrolledPageState extends State<EnrolledPage> {
  List<String> subjectNames = [];
  List<int> subjectCredit = [];

  void logOutUser(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      print("User logged out successfully");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    } catch (e) {
      print("Error logging out: $e");
    }
  }

  String? getUserId() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      print("No user!");
      return null;
    }
  }

  Future<void> _fetchSubject() async {
    subjectNames = [];
    subjectCredit = [];
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(getUserId())
          .get();

      if (userDoc.exists) {
        List<dynamic> subjectCreditList =
            userDoc['subjectEnrolled']['subjectCredit'];
        List<dynamic> subjectNameList =
            userDoc['subjectEnrolled']['subjectName'];

        // Ensure both lists have the same length
        int length = subjectNameList.length < subjectCreditList.length
            ? subjectNameList.length
            : subjectCreditList.length;

        setState(() {
          subjectNames = List<String>.from(subjectNameList.take(length));
          subjectCredit = List<int>.from(subjectCreditList
              .take(length)
              .map((item) => item is int ? item : 0));
        });

        print('Subject Names: $subjectNames');
        print('Subject Credits: $subjectCredit');
      } else {
        print('User document does not exist!');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchSubject();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 32,
              left: defaultMargin,
              right: defaultMargin,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'You have enrolled to : ',
                  style: blackTextStyle.copyWith(
                    fontSize: 32,
                    fontWeight: regular,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      ...List.generate(
                        subjectNames.length,
                        (index) {
                          return Column(
                            children: [
                              SubjectCard(
                                subjectCredit: subjectCredit[index],
                                subjectName: subjectNames[index],
                                isChosen: true,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                CustomizedButton(
                  height: 60,
                  onTap: () {
                    logOutUser(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
