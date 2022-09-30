import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeeData {
  final String employeeCode;
  final String employeeName;
  final String address;
  final String salary;
  final String mobileNo;
  final String remark;
  final String dateOfJoining;
  final String dateOfBirth;

  const EmployeeData({
    required this.employeeCode,
    required this.employeeName,
    required this.address,
    required this.salary,
    required this.mobileNo,
    required this.remark,
    required this.dateOfJoining,
    required this.dateOfBirth,
  });

  Map<String, dynamic> toJson() => {
        "employeeCode": employeeCode,
        "employeeName": employeeName,
        "address": address,
        "salary": salary,
        "mobileNo": mobileNo,
        "remark": remark,
        "dateOfJoining": dateOfJoining,
        "dateOfBirth": dateOfBirth,
      };

  static EmployeeData fromSnap(DocumentSnapshot snap) {
    var snapShot = snap.data() as Map<String, dynamic>;

    return EmployeeData(
      employeeCode: snapShot['employeeCode'],
      employeeName: snapShot['employeeName'],
      address: snapShot['address'],
      salary: snapShot['salary'],
      mobileNo: snapShot['mobileNo'],
      remark: snapShot['remark'],
      dateOfJoining: snapShot['dateOfJoining'],
      dateOfBirth: snapShot['dateOfBirth'],
    );
  }
}
