import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/config/themes/theme_colors.dart';
import 'package:job_finder/core/common/common_textfield.dart';
import 'package:job_finder/features/profile/domain/entity/userDetail_entity.dart';
import 'package:job_finder/features/profile/presentation/viewmodel/userDetails_View_model.dart';

class MultiStepForm extends ConsumerStatefulWidget {
  const MultiStepForm({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MultiStepFormState();
}

class _MultiStepFormState extends ConsumerState<MultiStepForm> {
  int _activeStepIndex = 0;

  TextEditingController ageController = TextEditingController();
  TextEditingController fatherController = TextEditingController();
  TextEditingController motherController = TextEditingController();
  TextEditingController grandFatherController = TextEditingController();
  TextEditingController grandMotherController = TextEditingController();
  TextEditingController educationLevelController = TextEditingController();
  TextEditingController courseTypeController = TextEditingController();
  TextEditingController courseNameController = TextEditingController();
  TextEditingController schoolNameController = TextEditingController();
  TextEditingController educationBackgroundController = TextEditingController();
  TextEditingController recentJobTitleController = TextEditingController();
  TextEditingController jobTypeController = TextEditingController();
  TextEditingController employmentDurationController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController otherjobsDetailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final courseNameDropController =
      DropdownEditingController(value: "Select Course");
  DateTime? selectedDate;

  // var courseType = ["Male", "Female", "Other"];
  var courseType = [
    "Software",
    "Management",
    "Engineering",
    "Healthcare",
    "Education",
    "Finance",
    "Marketing",
    "Design",
    "Sales",
    "Customer Service",
    "Human Resources",
    "Consulting",
    "Science",
    "Arts",
    "Commerce",
    "Engineering",
    "Medicine",
    "Law",
    "Computer Science",
    "Business Administration",
    "Education",
    "Architecture",
    "Psychology",
    "Nursing",
    "Pharmacy",
    "Social Work",
    "Journalism",
    "Graphic Design",
    "Environmental Science",
    "Finance",
    "Marketing"
  ];

  List<Step> stepList() => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text('Personal'),
          content: Container(
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.calendar_today,
                      color: Colors.green,
                    ),
                    labelText: 'DOB',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.calendar_today,
                        color: Colors.green,
                      ),
                      onPressed: () => _selectDate(context),
                    ),
                  ),
                  onTap: () => _selectDate(context),
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your DOB';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if (value.length == 10) {
                      final DateTime enteredDate = DateTime.parse(value);
                      final DateTime currentDate = DateTime.now();
                      final int age = currentDate.year - enteredDate.year;
                      setState(() {
                        ageController.text = value;
                        ageController.text =
                            age.toString(); // Set text for ageController
                      });
                    }
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                commonTextFormField(
                  controller: fatherController,
                  prefixIcon: const Icon(
                    Icons.person,
                    color: appCOlor,
                  ),
                  label: 'Enter your Father Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Father Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                commonTextFormField(
                  controller: motherController,
                  prefixIcon: const Icon(
                    Icons.girl_outlined,
                    color: appCOlor,
                  ),
                  label: 'Enter your Mother Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Mother Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                commonTextFormField(
                  controller: grandFatherController,
                  prefixIcon: const Icon(
                    Icons.person_3,
                    color: appCOlor,
                  ),
                  label: 'Enter your GrandFather Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your GrandFather Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                commonTextFormField(
                  controller: grandMotherController,
                  prefixIcon: const Icon(
                    Icons.woman,
                    color: appCOlor,
                  ),
                  label: 'Enter your GrandMother Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your GrandMother Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
        Step(
          state: _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 1,
          title: const Text('Education'),
          content: Container(
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                commonTextFormField(
                  controller: educationLevelController,
                  prefixIcon: const Icon(
                    Icons.cast_for_education,
                    color: appCOlor,
                  ),
                  label: 'Enter your EducationLevel',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your EducationLevel';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextDropdownFormField(
                  options: courseType,
                  controller: courseNameDropController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.green,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: appCOlor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: appCOlor),
                    ),
                    suffixIcon: Icon(Icons.arrow_drop_down),
                    labelText: "Select course",
                  ),
                ),

                // commonTextFormField(
                //   controller: courseTypeController,
                //   prefixIcon: const Icon(
                //     Icons.bookmark,
                //     color: appCOlor,
                //   ),
                //   label: 'Enter your Course Type',
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter your Course Type';
                //     }
                //     return null;
                //   },
                // ),
                const SizedBox(
                  height: 8,
                ),
                commonTextFormField(
                  controller: courseNameController,
                  prefixIcon: const Icon(
                    Icons.book,
                    color: appCOlor,
                  ),
                  label: 'Enter your Course Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Course Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                commonTextFormField(
                  controller: schoolNameController,
                  prefixIcon: const Icon(
                    Icons.home,
                    color: appCOlor,
                  ),
                  label: 'Enter your School Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your School Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                commonTextFormField(
                  controller: educationBackgroundController,
                  maxLines: 3,
                  prefixIcon: const Icon(
                    Icons.cast_for_education_outlined,
                    color: appCOlor,
                  ),
                  label: 'Enter your Educational Background',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Educational Background';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        Step(
          state: _activeStepIndex <= 2 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 2,
          title: const Text('Employment'),
          content: Container(
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                commonTextFormField(
                  controller: recentJobTitleController,
                  prefixIcon: const Icon(
                    Icons.work_history,
                    color: appCOlor,
                  ),
                  label: 'Enter your Recent Job Title',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Recent Job Title';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                commonTextFormField(
                  controller: jobTypeController,
                  prefixIcon: const Icon(
                    Icons.work,
                    color: appCOlor,
                  ),
                  label: 'Enter your Job Type',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Job Type';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                commonTextFormField(
                  controller: employmentDurationController,
                  prefixIcon: const Icon(
                    Icons.time_to_leave,
                    color: appCOlor,
                  ),
                  label: 'Enter your Employment Duration',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Employment Duration';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                commonTextFormField(
                  controller: companyNameController,
                  prefixIcon: const Icon(
                    Icons.home_max,
                    color: appCOlor,
                  ),
                  label: 'Enter your Company Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Company Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                commonTextFormField(
                  controller: otherjobsDetailController,
                  maxLines: 3,
                  prefixIcon: const Icon(
                    Icons.more,
                    color: appCOlor,
                  ),
                  label: 'Enter your Otherjob Detail',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Otherjob Details';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        Step(
          state: StepState.complete,
          isActive: _activeStepIndex >= 3,
          title: const Text('Confirm'),
          content: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('dob: ${ageController.text}'),
                Text('Fathername: ${fatherController.text}'),
                Text('Mothername: ${motherController.text}'),
                Text('GrandFather  : ${grandFatherController.text}'),
                Text('GrandMother : ${grandMotherController.text}'),
                Text('Education Level : ${educationLevelController.text}'),
                Text('Course type : ${courseNameDropController.value}'),
                Text('Course Name : ${courseNameController.text}'),
                Text('School Name : ${schoolNameController.text}'),
                Text(
                    'Education Background : ${educationBackgroundController.text}'),
                Text('Recent Job : ${recentJobTitleController.text}'),
                Text('JobType : ${jobTypeController.text}'),
                Text(
                    'Employment Duration : ${employmentDurationController.text}'),
                Text('Company Nepal : ${companyNameController.text}'),
                Text('Other Info : ${otherjobsDetailController.text}'),
              ],
            ),
          ),
        )
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Stepper'),
      ),
      body: Form(
        key: _formKey,
        child: Stepper(
          type: StepperType.vertical,
          currentStep: _activeStepIndex,
          steps: stepList(),
          onStepContinue: () {
            // if (_formKey.currentState!.validate()) {
            if (_activeStepIndex < stepList().length - 1) {
              setState(() {
                _activeStepIndex += 1;
              });
            } else {
              submitForm();
            }
            // }
          },
          onStepCancel: () {
            if (_activeStepIndex == 0) {
              return;
            }

            setState(() {
              _activeStepIndex -= 1;
            });
          },
          onStepTapped: (int index) {
            setState(() {
              _activeStepIndex = index;
            });
          },
          controlsBuilder: (context, ControlsDetails details) {
            final isLastStep = _activeStepIndex == stepList().length - 1;
            return Container(
              child: Row(
                children: [
                  if (_activeStepIndex > 0)
                    Expanded(
                      child: ElevatedButton(
                        onPressed: details.onStepCancel,
                        child: const Text('Back'),
                      ),
                    ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: details.onStepContinue,
                      child: (isLastStep)
                          ? const Text('Submit')
                          : const Text('Next'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void submitForm() async {
    UserDetailEntity entity = UserDetailEntity(
        dob: ageController.text,
        fatherName: fatherController.text,
        motherName: motherController.text,
        grandfatherName: grandFatherController.text,
        grandmotherName: grandMotherController.text,
        educationBackground: educationBackgroundController.text,
        courseName: courseNameController.text,
        courseType: courseNameDropController.value,
        schoolName: schoolNameController.text,
        educationLevel: educationLevelController.text,
        recentJobTitle: recentJobTitleController.text,
        jobType: jobTypeController.text,
        employmentDuration: employmentDurationController.text,
        companyName: companyNameController.text,
        otherjobsDetail: otherjobsDetailController.text);
    ref
        .read(userDetailViewModelProvider.notifier)
        .updateUserDetails(context, entity);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.green,
            colorScheme: ColorScheme.light(
                primary: Colors.green, onPrimary: Colors.white),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        ageController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }
}
