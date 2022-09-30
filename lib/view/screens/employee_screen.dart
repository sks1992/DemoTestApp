import 'package:demo_app/utils/firestore_methods.dart';
import 'package:demo_app/utils/utils.dart';
import 'package:demo_app/view/screens/login_screen.dart';
import 'package:demo_app/view/screens/show_employee_list_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/form_field_text.dart';
import '../widgets/reusable_date_picker.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  final TextEditingController employeeCodeController = TextEditingController();
  final TextEditingController employeeNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController remarkController = TextEditingController();

  DateTime dateOfBirth = DateTime.now();
  DateTime dateOfJoining = DateTime.now();
  String dob = "";
  String doj = "";
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    employeeCodeController.dispose();
    employeeNameController.dispose();
    addressController.dispose();
    mobileNoController.dispose();
    salaryController.dispose();
    remarkController.dispose();
  }

  void clearAllEmployeeData() {
    employeeCodeController.text = "";
    employeeNameController.text = "";
    addressController.text = "";
    salaryController.text = "";
    remarkController.text = "";
    mobileNoController.text = "";
    dateOfBirth = DateTime.now();
    dateOfJoining = DateTime.now();
  }

  void postEmployeeData() async {
    setState(() {
      isLoading = true;
    });
    try {
      String message = await FirestoreMethods().uploadEmployeeData(
        employeeCodeController.text,
        employeeNameController.text,
        addressController.text,
        salaryController.text.toString(),
        doj,
        dob,
        remarkController.text,
        mobileNoController.text,
      );

      if (message == "success") {
        setState(() {
          isLoading = false;
        });
        showSnackBar(context, "Emplayee Data Successfully Saved");
      } else {
        setState(() {
          isLoading = false;
        });
        showSnackBar(context, message);
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee data"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut().then(
                    (value) => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    ),
                  );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              FormFieldText(
                controller: employeeCodeController,
                title: "Employee Code",
                inputType: TextInputType.number,
              ),
              FormFieldText(
                controller: employeeNameController,
                title: "Employee Name",
              ),
              FormFieldText(
                controller: addressController,
                title: "Address",
              ),
              FormFieldText(
                controller: mobileNoController,
                title: "Mobile NO.",
                inputType: TextInputType.phone,
              ),
              ReusableDatePicker(
                title: "Date Of Birth",
                onPressed: () async {
                  DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: dateOfBirth,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  //if we press "CANCEL"
                  if (newDate == null) return;
                  //if we press "OK"
                  setState(() {
                    dateOfBirth = newDate;
                    dob = getFormattedDate(newDate.toString());
                  });
                },
                dateFormat: dateOfBirth,
              ),
              ReusableDatePicker(
                title: "Date Of Joining",
                onPressed: () async {
                  DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: dateOfJoining,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  //if we press "CANCEL"
                  if (newDate == null) return;
                  //if we press "OK"
                  setState(() {
                    dateOfJoining = newDate;
                    doj = getFormattedDate(newDate.toString());
                  });
                },
                dateFormat: dateOfJoining,
              ),
              FormFieldText(
                controller: salaryController,
                title: "Salary",
                inputType: TextInputType.number,
              ),
              FormFieldText(
                controller: remarkController,
                title: "Remark",
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () {
                      hideKeyboard();
                      if (employeeNameController.text.isNotEmpty &&
                          employeeCodeController.text.isNotEmpty &&
                          addressController.text.isNotEmpty &&
                          salaryController.text.isNotEmpty &&
                          remarkController.text.isNotEmpty &&
                          mobileNoController.text.isNotEmpty) {
                        postEmployeeData();
                        clearAllEmployeeData();
                      } else {
                        showSnackBar(context, "Please Fill All Fields");
                      }
                    },
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.blue,
                          )
                        : const Text(
                            "Save",
                            style: TextStyle(color: Colors.black),
                          ),
                  ),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () {},
                    child: const Text(
                      "Delete All",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () {},
                    child: const Text(
                      "Reset",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              const Divider(thickness: 2),
              const ShowEmployeeListData(),
            ],
          ),
        ),
      ),
    );
  }
}
