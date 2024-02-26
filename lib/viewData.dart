import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/enterdata.dart';
import 'package:flutter/material.dart';

import 'package:get/route_manager.dart';

class ViewData extends StatefulWidget {
  const ViewData({super.key});

  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  List data = [];
  getData() async {
    QuerySnapshot users =
        await FirebaseFirestore.instance.collection('colletion').get();
    data.addAll(users.docs);

    setState(() {
      data;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => EnterData());
        },
        child: Icon(Icons.add),
      ),
      body: Center(
        child: data.length == 0
            ? Text("No Data")
            : GridView.builder(
                itemCount: data.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
                  return Center(
                    child: Container(
                      margin: EdgeInsets.all(5),
                      width: 120,
                      // height: 50,
                      decoration: BoxDecoration(
                        color: Colors.purple[900],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        onLongPress: () async {
                          await FirebaseFirestore.instance
                              .collection('colletion')
                              .doc(data[index].id)
                              .delete();
                          setState(
                            () {
                              data.removeAt(index);
                            },
                          );

                          Get.snackbar(
                            "Deleted",
                            "Data Deleted",
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        },
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                data[index]['full_name'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                data[index]['notecontent'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
