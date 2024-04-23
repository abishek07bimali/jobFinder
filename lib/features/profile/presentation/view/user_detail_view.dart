import 'package:flutter/material.dart';
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:job_finder/config/routes/app_routes.dart';
import 'package:job_finder/config/themes/theme_colors.dart';

class UserDetailInputView extends StatefulWidget {
  const UserDetailInputView({super.key});

  @override
  State<UserDetailInputView> createState() => _UserDetailInputViewState();
}

class _UserDetailInputViewState extends State<UserDetailInputView> {
  final dobController = TextEditingController();
  final ageController = TextEditingController();
  final ethnicityController = TextEditingController();
  final bioController = TextEditingController();

  final _moreUserDetail = GlobalKey<FormState>();

  final _genderController = DropdownEditingController(value: "Select Gender");
  var cities = ["Male", "Female", "Other"];

  DateTime? selectedDate;

  String calculateAge(DateTime? dob) {
    if (dob != null) {
      final DateTime currentDate = DateTime.now();
      final int age = currentDate.year - dob.year;
      return age.toString();
    } else {
      return 'N/A';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appCOlor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: appwhite,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "",
          style: appTitleStyle.copyWith(
              fontWeight: FontWeight.bold, color: appwhite),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _moreUserDetail,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.0),
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                  SizedBox(height: 15.0),
                  Container(
                    alignment: Alignment.center,
                    child: RichText(
                      text: const TextSpan(
                        text: "Input your ",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 81, 79, 79),
                        ),
                        children: [
                          TextSpan(
                            text: "Personal Information ",
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          TextSpan(
                            text: "For Further Use",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: dobController,
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
                          dobController.text = value;
                          ageController.text =
                              age.toString(); // Set text for ageController
                        });
                      }
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: ageController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.calendar_month_sharp,
                        color: Colors.green,
                      ),
                      labelText: 'Age',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                    readOnly: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextDropdownFormField(
                    options: cities,
                    controller: _genderController,
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
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      labelText: "Select the gender",
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: ethnicityController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.hiking,
                        color: Colors.green,
                      ),
                      labelText: 'Ethnicity',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Ethnicity';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: bioController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.description,
                        color: Colors.green,
                      ),
                      labelText: 'Bio',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your bio';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_moreUserDetail.currentState!.validate()) {
                          Navigator.pushNamed(context, AppRoute.multiStepForm);
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                      ),
                      child: Text('Save and continue'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
        dobController.text = "${picked.toLocal()}".split(' ')[0];
        ageController.text = calculateAge(picked);
      });
    }
  }
}
