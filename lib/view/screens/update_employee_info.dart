import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../widgets/form_field_text.dart';
import '../widgets/reusable_date_picker.dart';

class UpdateEmployeeInfo extends StatefulWidget {
  final String employeeId;

  const UpdateEmployeeInfo({Key? key, required this.employeeId})
      : super(key: key);

  @override
  State<UpdateEmployeeInfo> createState() => _UpdateEmployeeInfoState();
}

class _UpdateEmployeeInfoState extends State<UpdateEmployeeInfo> {
  DateTime dateOfBirth = DateTime.now();
  DateTime dateOfJoining = DateTime.now();
  String dob = "";
  String doj = "";

  CollectionReference data =
      FirebaseFirestore.instance.collection(collectionName);

  // Updating Employee Data
  Future<void> updateEmployeeData(
    employeeCode,
    employeeName,
    address,
    salary,
    mobileNo,
    remark,
    dateOfJoining,
    dateOfBirth,
  ) {
    return data
        .doc(widget.employeeId)
        .update({
          "employeeCode": employeeCode,
          "employeeName": employeeName,
          "address": address,
          "salary": salary,
          "mobileNo": mobileNo,
          "remark": remark,
          "dateOfJoining": dateOfJoining,
          "dateOfBirth": dateOfBirth,
        })
        .then((value) => showSnackBar(context, "Employee Data Updated"))
        .catchError(
          (error) => showSnackBar(context, "Failed to update user: $error"),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Employee"),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance
            .collection(collectionName)
            .doc(widget.employeeId)
            .get(),
        builder: (_, snapshot) {
          if (snapshot.hasError) {
            showSnackBar(context, 'Something Went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var data = snapshot.data!.data();
          var employeeCode = data!['employeeCode'];
          var employeeName = data['employeeName'];
          var address = data['address'];
          var mobileNo = data['mobileNo'];
          var dob = data['dateOfBirth'];
          var doj = data['dateOfJoining'];
          var salary = data['salary'];
          var remark = data['remark'];

          return Padding(
            padding: const EdgeInsets.all(20.00),
            child: ListView(
              children: [
                FormFieldText(
                  dataChange: (value) => employeeCode=value,
                  initialValue: employeeCode,
                  title: "Employee Code",
                  inputType: TextInputType.number,
                ),
                FormFieldText(
                  dataChange: (value) => employeeName=value,
                  initialValue: employeeName,
                  title: "Employee Name",
                ),
                FormFieldText(
                  dataChange: (value) => address=value,
                  initialValue: address,
                  title: "Address",
                ),
                FormFieldText(
                  dataChange: (value) => mobileNo=value,
                  initialValue: mobileNo,
                  title: "Mobile NO.",
                  inputType: TextInputType.phone,
                ),
                ReusableDatePicker(
                  title: "Date Of Birth",
                  onPressed: () async {
                    DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: dob,
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
                      initialDate: doj,
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
                  dataChange: (value) => salary=value,
                  initialValue: salary,
                  title: "Salary",
                  inputType: TextInputType.number,
                ),
                FormFieldText(
                  dataChange: (value) => remark=value,
                  initialValue: remark,
                  title: "Remark",
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        updateEmployeeData(
                          employeeCode,
                          employeeName,
                          address,
                          salary,
                          mobileNo,
                          remark,
                          doj,
                          dob,
                        );
                        Navigator.pop(context);
                      },
                      child: const Text("Update"),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
