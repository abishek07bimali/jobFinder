// // job_details_tab.dart

// import 'package:flutter/material.dart';

// class JobDetailsTab extends StatelessWidget {
//   final String? jobDescription;
//   final String? jobResponsibilities;
//   final String? companyName;
//   final String? jobType;
//   final String? workType;
//   final String? experienceLevel;
//   final String? educationLevel;
//   final String? contact;
//   final String? location;

//   const JobDetailsTab({
//     Key? key,
//     this.jobDescription,
//     this.jobResponsibilities,
//     this.companyName,
//     this.jobType,
//     this.workType,
//     this.experienceLevel,
//     this.educationLevel,
//     this.contact,
//     this.location,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (jobDescription != null) ...[
//             Text(
//               'Job Description',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(jobDescription!),
//             SizedBox(height: 16),
//             Text(
//               'Responsibilities',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(jobResponsibilities!),
//           ],
//           if (companyName != null) ...[
//             Text(
//               'Company Name: $companyName',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text('Job Type: $jobType'),
//             Text('Work Type: $workType'),
//             Text('Experience Level: $experienceLevel'),
//             Text('Education Level: $educationLevel'),
//             Text('Contact: $contact'),
//             Text('Location: $location'),
//           ],
//         ],
//       ),
//     );
//   }
// }
