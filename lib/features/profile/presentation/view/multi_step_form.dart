// import 'package:flutter/material.dart';
// import 'package:job_finder/config/routes/app_routes.dart';

// class MultiStepForm extends StatefulWidget {
//   @override
//   _MultiStepFormState createState() => _MultiStepFormState();
// }

// class _MultiStepFormState extends State<MultiStepForm> {
//   late PageController _pageController;
//   int _currentIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController();
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   void _nextTab() {
//     if (_currentIndex < 2) {
//       _pageController.nextPage(
//         duration: Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//       setState(() {
//         _currentIndex++;
//         if (_currentIndex == 2) {
//           // Check if the form is successfully submitted
//           // You can replace this condition with your own logic
//           bool isFormSubmittedSuccessfully = true;

//           if (isFormSubmittedSuccessfully) {
//             // Navigate to the user profile route
//             Navigator.pushNamed(context, AppRoute.userprofileRoute);
//           }
//         }
//       });
//     }
//   }

//   void _previousTab() {
//     if (_currentIndex > 0) {
//       _pageController.previousPage(
//         duration: Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//       setState(() {
//         _currentIndex--;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             LinearProgressIndicator(
//               value: (_currentIndex + 1) / 3,
//               valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
//               backgroundColor: Colors.grey,
//               minHeight: 4,
//             ),
//             Expanded(
//               child: PageView(
//                 controller: _pageController,
//                 physics: NeverScrollableScrollPhysics(),
//                 children: [
//                   EducationalHistoryForm(),
//                   EmploymentHistoryForm(),
//                   SummaryScreen(),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   SizedBox(
//                     width: 100,
//                     child: ElevatedButton(
//                       onPressed: _previousTab,
//                       child: Text('Previous'),
//                       style: ButtonStyle(
//                         backgroundColor:
//                             MaterialStateProperty.all<Color>(Colors.green),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 100,
//                     child: ElevatedButton(
//                       onPressed: _nextTab,
//                       child: Text(_currentIndex == 2 ? 'Submit' : 'Next'),
//                       style: ButtonStyle(
//                         backgroundColor:
//                             MaterialStateProperty.all<Color>(Colors.green),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class EducationalHistoryForm extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const Padding(
//       padding: EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text('Educational History Form', style: TextStyle(fontSize: 20.0)),
//           // Add your educational history form fields here
//         ],
//       ),
//     );
//   }
// }

// class EmploymentHistoryForm extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const Padding(
//       padding: EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text('Employment History Form', style: TextStyle(fontSize: 20.0)),
//           // Add your employment history form fields here
//         ],
//       ),
//     );
//   }
// }

// class SummaryScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const Padding(
//       padding: EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text('Summary Screen', style: TextStyle(fontSize: 20.0)),
//           // Display a summary of the entered information here
//         ],
//       ),
//     );
//   }
// }
