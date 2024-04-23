import 'package:flutter/material.dart';
import 'package:job_finder/config/themes/theme_colors.dart';
import 'package:job_finder/core/common/common_text.dart';
import 'package:job_finder/features/homepage/domain/entity/jobs_entity.dart';

class CompanyTab extends StatelessWidget {
  final JobsEntity? jobs;
  CompanyTab({this.jobs});
  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.shortestSide > 600;

    return Container(
      child: ListView(
        children: <Widget>[
          const SizedBox(height: 25.0),
          Text(
            "About Company",
            style: appTitleStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15.0),
          commonJobText(
            text: jobs!.companyName,
            fontWeight: FontWeight.w300,
            isTablet: isTablet,
          ),
          const SizedBox(height: 15.0),
          Text(
            "Location",
            style: appTitleStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15.0),
          commonJobText(
            text: jobs!.location,
            fontWeight: FontWeight.w300,
            isTablet: isTablet,
          ),
          const SizedBox(height: 15.0),
          Text(
            "Experiance Level",
            style: appTitleStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15.0),
          commonJobText(
            text: jobs!.experianceLevel,
            fontWeight: FontWeight.w300,
            isTablet: isTablet,
          ),
          const SizedBox(height: 15.0),
          Text(
            "Salary",
            style: appTitleStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15.0),
          commonJobText(
            text: jobs!.salary,
            fontWeight: FontWeight.w300,
            isTablet: isTablet,
          ),
          const SizedBox(height: 15.0),
          Text(
            "Contact",
            style: appTitleStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15.0),
          commonJobText(
            text: jobs!.contact,
            fontWeight: FontWeight.w300,
            isTablet: isTablet,
          ),
          const SizedBox(height: 15.0),
          Text(
            "Company Overview",
            style: appTitleStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15.0),
          commonJobText(
            text: jobs!.companyOverview,
            fontWeight: FontWeight.w300,
            isTablet: isTablet,
          ),
        ],
      ),
    );
  }
}
