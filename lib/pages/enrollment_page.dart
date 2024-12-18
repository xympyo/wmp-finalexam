import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_exam_project/shared/theme.dart';
import 'package:final_exam_project/widgets/customized_button.dart';
import 'package:final_exam_project/widgets/subject_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EnrollmentPage extends StatefulWidget {
  const EnrollmentPage({super.key});

  @override
  State<EnrollmentPage> createState() => _EnrollmentPageState();
}

class _EnrollmentPageState extends State<EnrollmentPage> {
  List<String> subjectNames = [];
  List<int> subjectCredit = [];
  bool isLoading = true;
  List<bool> arrayChosen = [];
  List<int> selectedSubject = [];
  int totalCredit = 0;
  String errorMessage = "";
  List<String> chosenSubject = [];
  List<int> chosenCredit = [];

  Future<void> assignSubjects(String userId) async {
    try {
      chosenSubject.clear();
      chosenCredit.clear();
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('users').doc(userId);

      selectedSubject.forEach((subjectIndex) {
        chosenSubject.add(subjectNames[subjectIndex]);
        chosenCredit.add(subjectCredit[subjectIndex]);
      });
      await userDocRef.update(
        {
          'subjectEnrolled.subjectName': FieldValue.arrayUnion(
            chosenSubject,
          ),
          'subjectEnrolled.subjectCredit': chosenCredit
        },
      );
    } catch (e) {
      print('Error handling subject assignment $e');
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

  bool checkCredit() {
    if (totalCredit >= 24) {
      errorMessage = "You have passed 24!, can not enroll!";
      return true;
    } else if (totalCredit == 0) {
      errorMessage = "Credit can not be empty!";
      return true;
    } else {
      return false;
    }
  }

  void addCredit(int index) {
    totalCredit += subjectCredit[index];
  }

  void removeCredit(int index) {
    totalCredit -= subjectCredit[index];
  }

  void pushSubject(int index) {
    setState(() {
      if (!selectedSubject.contains(index)) {
        selectedSubject.add(index);
        addCredit(index);
      }
    });
  }

  void removeSubject(int index) {
    setState(() {
      selectedSubject.remove(index);
      removeCredit(index);
    });
  }

  void toggleSubject(int index) {
    setState(() {
      if (selectedSubject.contains(index)) {
        selectedSubject.remove(index);
        removeCredit(index);
      } else {
        selectedSubject.add(index);
        addCredit(index);
      }
    });
  }

  void pushItem(int index) {
    setState(() {
      arrayChosen[index] = !arrayChosen[index];
    });
  }

  void popItem() {
    if (arrayChosen.isNotEmpty) {
      setState(() {
        arrayChosen.removeLast();
      });
    }
  }

  Future<void> _fetchSubject() async {
    print('Function called!');
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('subjects')
          .doc('subjectInformation')
          .get();

      if (userDoc.exists) {
        List<dynamic> subjectCreditList = userDoc['subjectCredit'];
        List<dynamic> subjectNameList = userDoc['subjectName'];

        setState(() {
          subjectNames = List<String>.from(subjectNameList);

          subjectCredit = List<int>.from(
              subjectCreditList.map((item) => item is int ? item : 0));

          arrayChosen = List<bool>.filled(subjectNames.length, false);

          isLoading = false;
        });

        print('Subject Names: $subjectNames');
        print('Subject Credits: $subjectCredit');
      } else {
        print('User document does not exist!');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isLoading = false;
      });
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
                top: 32, left: defaultMargin, right: defaultMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Subject',
                  style: blackTextStyle.copyWith(
                    fontSize: 32,
                    fontWeight: regular,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Subject Name',
                      style: blackTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: light,
                      ),
                    ),
                    Text(
                      'Subject Credit',
                      style: blackTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: light,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ...List.generate(
                  subjectNames.length,
                  (index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            toggleSubject(index);
                            pushItem(index);
                            print(selectedSubject);
                            print(totalCredit);
                            print(arrayChosen[index]);
                          },
                          child: SubjectCard(
                            subjectCredit: subjectCredit[index],
                            subjectName: subjectNames[index],
                            isChosen: arrayChosen[index],
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                checkCredit()
                    ? Text(
                        errorMessage,
                        style: blackTextStyle.copyWith(
                          fontSize: 20,
                          color: Colors.red.shade400,
                          fontWeight: regular,
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 8,
                ),
                CustomizedButton(
                  height: 60,
                  onTap: () {
                    checkCredit()
                        ? null
                        : assignSubjects(getUserId().toString());
                    Navigator.pushReplacementNamed(context, '/enrolled-page');
                  },
                  text: 'Enroll Now!',
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
