import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../widgets/custom_table_cell.dart';

class SearchData extends StatefulWidget {
  const SearchData({Key? key}) : super(key: key);

  @override
  State<SearchData> createState() => _SearchDataState();
}

class _SearchDataState extends State<SearchData> {
  final searchText = TextEditingController();
  var searchData = [];

  @override
  void dispose() {
    super.dispose();
    searchText.dispose();
  }

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

  void searchDataForEmployeeCode(String searchQuery, List employeeData) {
    setState(() {
      searchData = employeeData
          .where((p) => p["employeeCode"].contains(searchQuery))
          .map((p) => p)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Data"),
        centerTitle: true,
      ),
      body: StreamBuilder(
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

          return Column(
            children: [
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.00),
                ),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: searchText,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(0.0),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 20,
                    ),
                    prefixIconConstraints: BoxConstraints(
                      maxHeight: 20,
                      minWidth: 25,
                    ),
                    border: InputBorder.none,
                    hintText: "Enter EmployeeCode",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      searchDataForEmployeeCode(searchText.text, employeeData);
                    },
                    child: const Text("Search"),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Container(
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
                        ],
                      ),
                      for (var i = 0; i < searchData.length; i++) ...[
                        TableRow(
                          children: [
                            CustomTableCell(
                                text: searchData[i]['employeeCode']),
                            CustomTableCell(
                                text: searchData[i]['employeeName']),
                            CustomTableCell(text: searchData[i]['address']),
                            CustomTableCell(text: searchData[i]['mobileNo']),
                            CustomTableCell(
                                text: searchData[i]['dateOfJoining']),
                            CustomTableCell(text: searchData[i]['dateOfBirth']),
                            CustomTableCell(text: searchData[i]['salary']),
                            CustomTableCell(text: searchData[i]['remark']),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
