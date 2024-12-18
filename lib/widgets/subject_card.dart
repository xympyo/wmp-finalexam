import 'package:final_exam_project/shared/theme.dart';
import 'package:flutter/material.dart';

class SubjectCard extends StatelessWidget {
  final String subjectName;
  final int subjectCredit;
  final bool isChosen;
  const SubjectCard({
    super.key,
    required this.subjectCredit,
    required this.subjectName,
    required this.isChosen,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          color: isChosen ? kPurpleColor : Colors.grey.shade400,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: IntrinsicHeight(
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    subjectName,
                    style: whiteTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: regular,
                    ),
                    overflow: TextOverflow.visible,
                    maxLines: null,
                  ),
                ),
                Text(
                  subjectCredit.toString(),
                  style: whiteTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: regular,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
