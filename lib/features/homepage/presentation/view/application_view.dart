import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/config/themes/theme_colors.dart';
import 'package:job_finder/core/common/common_text.dart';
import 'package:job_finder/features/homepage/presentation/viewmodel/application_View_model.dart';

class AppliedJobsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final applicationViewModel = ref.watch(applicationViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Applied Jobs'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(applicationViewModelProvider.notifier).resetState();
        },
        child: ListView.builder(
          itemCount: applicationViewModel.application.length,
          itemBuilder: (context, index) {
            final application = applicationViewModel.application[index];
            IconData iconData;
            Color iconColor;
            if (application.isVerified == true) {
              iconData = Icons.check_circle;
              iconColor = appCOlor;
            } else if (application.isVerified == false &&
                application.isRejected == true) {
              iconData = Icons.cancel;
              iconColor = appRed;
            } else {
              iconData = Icons.error;
              iconColor = Colors.yellow;
            }
            return Card(
              child: ListTile(
                leading: Image.network(
                  application.image!,
                  width: 50,
                  height: 50,
                ),
                title: Text(application.jobsTitle ?? ''),
                subtitle: Text(application.companyName ?? ''),
                trailing: Icon(
                  iconData,
                  color: iconColor,
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      String message;
                      if (application.isVerified == true) {
                        message = application.interview ??
                            "$verificationMessage ${application.interview} \n \n $contactMessage";
                      } else if (application.isRejected == true) {
                        message = 'Rejected';
                      } else {
                        message = 'Not verified';
                      }

                      return AlertDialog(
                        title:
                            commonText(text: "Interview Details", fontSize: 25),
                        content: commonText(
                          text:
                              // " $verificationMessage $message \n \n $contactMessage",
                              " $message ",
                          fontSize: 16,
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Close'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
