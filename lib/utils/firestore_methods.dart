import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/model/employee_data.dart';
import 'package:demo_app/utils/utils.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadEmployeeData(
    String employeeCode,
    String employeeName,
    String address,
    String salary,
    String dateOfJoining,
    String dateOfBirth,
    String remark,
    String mobileNo,
  ) async {
    String errorMessage = "Some Error occurred";
    try {
      EmployeeData employeeData = EmployeeData(
        employeeCode: employeeCode,
        employeeName: employeeName,
        address: address,
        salary: salary,
        mobileNo: mobileNo,
        remark: remark,
        dateOfJoining: dateOfJoining,
        dateOfBirth: dateOfBirth,
      );

      _firestore.collection(collectionName).doc(employeeCode).set(
            employeeData.toJson(),
          );
      errorMessage = "Success";
    } on FirebaseException catch (e) {
      errorMessage = e.code.toString();
    }
    return errorMessage;
  }
}
