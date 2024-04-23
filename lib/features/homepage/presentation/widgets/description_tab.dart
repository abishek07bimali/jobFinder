import 'package:flutter/material.dart';
import 'package:job_finder/config/themes/theme_colors.dart';
import 'package:job_finder/core/common/common_text.dart';
import 'package:job_finder/features/homepage/domain/entity/jobs_entity.dart';
import 'package:intl/intl.dart';

class DescriptionTab extends StatelessWidget {
  final JobsEntity? company;
  DescriptionTab({this.company});
  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.shortestSide > 600;
    String? applyBeforeString = company!.applyBefore;
    DateTime? applyBeforeDateTime;

    applyBeforeDateTime = DateTime.parse(applyBeforeString);

    // ignore: unnecessary_null_comparison
    String formattedDate = applyBeforeDateTime != null
        ? DateFormat('yyyy-MM-dd').format(applyBeforeDateTime)
        : '';

    return Container(
      child: ListView(
        children: <Widget>[
          const SizedBox(height: 25.0),
          Text(
            "About the Opportunity",
            style: appTitleStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15.0),
          commonJobText(
            text: company!.jobDescription,
            fontWeight: FontWeight.w300,
            isTablet: isTablet,
          ),
          const SizedBox(height: 25.0),
          Text(
            "Job Responsbilities",
            style: appTitleStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15.0),
          commonJobText(
            text: company!.jobResponsibilities,
            fontWeight: FontWeight.w300,
            isTablet: isTablet,
          ),
          const SizedBox(height: 25.0),
          Text(
            "Work Type",
            style: appTitleStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15.0),
          commonJobText(
            text: company!.workType,
            fontWeight: FontWeight.w300,
            isTablet: isTablet,
          ),
          const SizedBox(height: 25.0),
          Text(
            "Job Location",
            style: appTitleStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15.0),
          commonJobText(
            text: company!.location,
            fontWeight: FontWeight.w300,
            isTablet: isTablet,
          ),
          const SizedBox(height: 15.0),
          Text(
            "Apply Before",
            style: appTitleStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15.0),
          commonJobText(
            text: formattedDate,
            fontWeight: FontWeight.w300,
            isTablet: isTablet,
          ),
        ],
      ),
    );
  }
}
