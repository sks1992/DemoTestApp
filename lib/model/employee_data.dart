/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../app_route.dart';
import '../../../../../core/controllers/appraisal_controllers/rental_income_controller.dart';
import '../../../../../core/models/test.dart';
import '../../../../widgets/form_field_text.dart';
import '../../../../widgets/subtitle_text.dart';

class IncomeDetailPage extends StatelessWidget {
  IncomeDetailPage({Key? key}) : super(key: key);

  final RentalIncomeController controller = Get.put(RentalIncomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormFieldText(
                        controller: controller.descriptionOfProperty,
                        title: "Description Of Property",
                        enabled: true,
                      ),
                      FormFieldText(
                        controller: controller.portionsOrShops,
                        title: "Portions Or Shops",
                      ),
                      FormFieldText(
                        controller: controller.noOfPortionsFilledUp,
                        title: "No Of Portions Filled Up",
                      ),
                      FormFieldText(
                        controller: controller.monthlyRent,
                        title: "Monthly Rent",
                      ),
                      const SizedBox(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            child: const Text('Add'),
                            onPressed: () {
                              if (controller.descriptionOfProperty.text
                                      .isNotEmpty &&
                                  controller
                                      .portionsOrShops.text.isNotEmpty &&
                                  controller
                                      .noOfPortionsFilledUp.text.isNotEmpty &&
                                  controller.monthlyRent.text.isNotEmpty) {
                                controller.demoList.add(IncomeDetail(
                                    descriptionOfProperty:
                                        controller.descriptionOfProperty.text,
                                    portionsOrShops:
                                        controller.portionsOrShops.text,
                                    noOfPortionsFilledUp:
                                        controller.noOfPortionsFilledUp.text,
                                    monthlyRent:
                                        controller.monthlyRent.text));

                                controller.descriptionOfProperty.text = "";
                                controller.portionsOrShops.text = "";
                                controller.noOfPortionsFilledUp.text = "";
                                controller.monthlyRent.text = "";
                              }
                            },
                          ),
                          SizedBox(
                            width: Get.width * 0.3,
                            child: ElevatedButton(
                              child: const Text("Submit"),
                              onPressed: () {
                                Get.toNamed(RouteNames.appraisalMainPage);

                                // if (controller.dailyWeeklySalesValidation() == true) {
                                //   Get.toNamed(RouteNames.appraisalMainPage);
                                // } else {
                                //   Helpers.helpers
                                //       .showSnackBar1("Error", controller.saveMessage.value);
                                // }
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 16),
                height: Get.height * 0.35,
                child: Card(
                  child: ListView.builder(
                      itemCount: controller.demoList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          // color: Colors.grey,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SubtitleText(
                                        text: "Income Detail ${index + 1}"),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        controller.demoList.removeAt(index);
                                      },
                                    )
                                  ],
                                ),
                                const Divider(
                                  color: Colors.red,
                                ),
                                /*const SizedBox(
                                  height: 12,
                                ),*/
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SubtitleText(
                                      text: "Description Of Property - ",
                                    ),
                                    Text(
                                      controller.demoList[index]
                                          .descriptionOfProperty,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SubtitleText(
                                      text: "Portions Or Shops - ",
                                    ),
                                    Text(
                                      controller
                                          .demoList[index].portionsOrShops,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SubtitleText(
                                      text: "No Of Portions Filled Up - ",
                                    ),
                                    Text(
                                      controller.demoList[index]
                                          .noOfPortionsFilledUp,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/controllers/transport_controller.dart';
import '../../core/models/transport_model.dart';
import '../widgets/app_bar.dart';
import '../widgets/dot_progress_indicator.dart';
import '../widgets/message_view.dart';

class TransportView extends StatelessWidget {
  const TransportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarView(
          title: "Transport",
        ),
      ),
      body: SafeArea(
        child: GetBuilder<TransportViewController>(
          init: Get.put(TransportViewController()),
          builder: (_controller) {
            return _controller.obx(
              (_transportData) => _transportData == null ||
                      !_transportData.isSuccess
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: MessageView(
                          success: false,
                          message: _transportData?.message ?? "No data found."),
                    )
                  : ListView(
                      padding: const EdgeInsets.all(16.0),
                      children: [_getTransportDataWidgets(_transportData)],
                    ),
              onLoading: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(child: const DotProgressIndicator()),
              ),
              onError: (err) => Center(
                  child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: MessageView(success: false, message: err ?? ""),
              )),
            );
          },
        ),
      ),
    );
  }
}

_getTransportDataWidgets(TransportModel transportModel) {
  var myColumns = [
    DataColumn(label: Text('Onward Route')),
    DataColumn(label: Text('')),
  ];

  var myRows = [

    DataRow(cells: [
      DataCell(Text(' Route Name')),
      DataCell(
        Text(
          '${transportModel.onwardRoute!.routeName}',
          style: TextStyle(overflow: TextOverflow.ellipsis),
        ),
      ),
    ]),

    DataRow(cells: [
      DataCell(Text('Point Name')),
      DataCell(
        Text(
          '${transportModel.onwardRoute!.pointName}',
          style: TextStyle(overflow: TextOverflow.ellipsis),
        ),
      ),
    ]),

    DataRow(cells: [
      DataCell(Text('Vehicle')),
      DataCell(
        Text(
          '${transportModel.onwardRoute!.vehicle}',
          style: TextStyle(overflow: TextOverflow.ellipsis),
        ),
      ),
    ]),
    DataRow(cells: [
      DataCell(Text('Vehicle Type')),
      DataCell(
        Text(
          '${transportModel.onwardRoute!.vehicleType}',
          style: TextStyle(overflow: TextOverflow.ellipsis),
        ),
      ),
    ]),
    DataRow(cells: [
      DataCell(Text('Registration No')),
      DataCell(Text('${transportModel.onwardRoute!.registrationNo}')),
    ])
  ];

  var myColumns2 = [
    DataColumn(label: Text('Return Route')),
    DataColumn(label: Text('')),
  ];

  var myRows2 = [
    DataRow(cells: [
      DataCell(Text(' Route Name')),
      DataCell(
        Text(
          '${transportModel.returnRoute!.routeName}',
          style: TextStyle(overflow: TextOverflow.ellipsis),
        ),
      ),
    ]),
    DataRow(cells: [
      DataCell(Text('Point Name')),
      DataCell(
        Text(
          '${transportModel.returnRoute!.pointName}',
          style: TextStyle(overflow: TextOverflow.ellipsis),
        ),
      ),
    ]),
    DataRow(cells: [
      DataCell(Text('Vehicle')),
      DataCell(
        Text(
          '${transportModel.returnRoute!.vehicle}',
          style: TextStyle(overflow: TextOverflow.ellipsis),
        ),
      ),
    ]),
    DataRow(cells: [
      DataCell(Text('Vehicle Type')),
      DataCell(
        Text(
          '${transportModel.returnRoute!.vehicleType}',
          style: TextStyle(overflow: TextOverflow.ellipsis),
        ),
      ),
    ]),
    DataRow(cells: [
      DataCell(Text('Registration No')),
      DataCell(Text('${transportModel.returnRoute!.registrationNo}')),
    ])
  ];

  return Container(
    width: Get.width,
    padding: const EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: Get.width,
          child: Card(
            child: DataTable(
              columns: myColumns,
              rows: myRows,
              sortColumnIndex: 0,
              sortAscending: true,
            ),
          ),
        ),
        Container(
          width: Get.width,
          child: Card(
            child: DataTable(
              columns: myColumns2,
              rows: myRows2,
              sortColumnIndex: 0,
              sortAscending: true,
            ),
          ),
        ),
        Container(
          width: Get.width,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Table(
                    children: [
                      TableRow(children: [
                        Text("Due"),
                        Text("${transportModel.due!.toString()}")
                      ]),
                    ],
                  ),
                  Divider(),
                  Table(
                    children: [
                      TableRow(children: [
                        Text("Discount"),
                        Text("${transportModel.discount!.toString()}")
                      ]),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

 */
