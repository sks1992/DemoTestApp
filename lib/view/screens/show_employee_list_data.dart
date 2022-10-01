import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/view/screens/update_employee_info.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../widgets/custom_table_cell.dart';

class ShowEmployeeListData extends StatefulWidget {
  const ShowEmployeeListData({Key? key}) : super(key: key);

  @override
  State<ShowEmployeeListData> createState() => _ShowEmployeeListDataState();
}

class _ShowEmployeeListDataState extends State<ShowEmployeeListData> {
  final CollectionReference _data =
      FirebaseFirestore.instance.collection(collectionName);

  Future<void> deleteUser(id) {
    return _data
        .doc(id)
        .delete()
        .then((value) => showSnackBar(context, "Data Deleted Success"))
        .catchError(
          (error) => showSnackBar(context, 'Failed to Delete user: $error'),
        );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _data.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          showSnackBar(context, "Something went Wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final List employeeData = [];

        //get data from firebase docs
        snapshot.data!.docs.map((DocumentSnapshot document) {
          //save data in map format
          Map employee = document.data() as Map<String, dynamic>;
          //add data to list
          employeeData.add(employee);
          //get doc id from document.id and add in employee list
          employee['id'] = document.id;
        }).toList();

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 20.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Table(
              border: TableBorder.all(),
              columnWidths: const <int, TableColumnWidth>{
                0: FixedColumnWidth(150),
                1: FixedColumnWidth(150),
                2: FixedColumnWidth(150),
                3: FixedColumnWidth(150),
                4: FixedColumnWidth(150),
                5: FixedColumnWidth(150),
                6: FixedColumnWidth(150),
                7: FixedColumnWidth(150),
                8: FixedColumnWidth(150),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                const TableRow(
                  children: [
                    CustomTableCell(text: "EmployeeCode"),
                    CustomTableCell(text: "EmployeeName"),
                    CustomTableCell(text: "Address"),
                    CustomTableCell(text: "MobileNo."),
                    CustomTableCell(text: "DateOfJoining"),
                    CustomTableCell(text: "DateOfBirth"),
                    CustomTableCell(text: "Salary"),
                    CustomTableCell(text: "Remark"),
                    CustomTableCell(text: "Action"),
                  ],
                ),
                for (var i = 0; i < employeeData.length; i++) ...[
                  TableRow(
                    children: [
                      CustomTableCell(text: employeeData[i]['employeeCode']),
                      CustomTableCell(text: employeeData[i]['employeeName']),
                      CustomTableCell(text: employeeData[i]['address']),
                      CustomTableCell(text: employeeData[i]['mobileNo']),
                      CustomTableCell(text: employeeData[i]['dateOfJoining']),
                      CustomTableCell(text: employeeData[i]['dateOfBirth']),
                      CustomTableCell(text: employeeData[i]['salary']),
                      CustomTableCell(text: employeeData[i]['remark']),
                      TableCell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateEmployeeInfo(
                                      employeeId: employeeData[i]['id'],
                                    ),
                                  ),
                                )
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.orange,
                              ),
                            ),
                            IconButton(
                              onPressed: () =>
                                  {deleteUser(employeeData[i]['id'])},
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
