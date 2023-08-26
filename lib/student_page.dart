import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_app/buttons.dart';
import 'package:crud_app/helper.dart';
import 'package:crud_app/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({
    super.key,
  });

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  final nameController = TextEditingController();
  final SidController = TextEditingController();
  final SPController = TextEditingController();
  final CGPAController = TextEditingController();
  var sname, sid, sprogram, scgpa;
  bool isShow = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    SidController.dispose();
    SPController.dispose();
    CGPAController.dispose();
  }

  getName(name) {
    this.sname = name;
  }

  getID(ID) {
    this.sid = ID;
  }

  getProgram(studentProgram) {
    this.sprogram = studentProgram;
  }

  getCGPA(CGPA) {
    this.scgpa = CGPA;
  }

  createData() async {
    DocumentReference documentReference =
        await FirebaseFirestore.instance.collection("Student").doc(sname);

    Map<String, dynamic> sdata = {
      "Name": sname,
      "Student ID": sid,
      "Student Program": sprogram,
      "CGPA": scgpa,
    };
    documentReference
        .set(sdata)
        .whenComplete(() => {print("Creted Sucessfully")});
  }

  readData() async {
    DocumentReference documentReference =
        await FirebaseFirestore.instance.collection("Student").doc(sname);

    documentReference.get().whenComplete(() => {print("Readed Sucessfully")});
  }

  updateData() async {
    DocumentReference documentReference =
        await FirebaseFirestore.instance.collection("Student").doc(sname);

    Map<String, dynamic> sdata = {
      "Name": sname,
      "Student ID": sid,
      "Student Program": sprogram,
      "CGPA": scgpa,
    };

    documentReference
        .update(sdata)
        .whenComplete(() => {print("Updated Sucessfully")});
  }

  deleteData() async {
    DocumentReference documentReference =
        await FirebaseFirestore.instance.collection("Student").doc(sname);

    documentReference
        .delete()
        .whenComplete(() => {print("Deleted Sucessfully")});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 0,
          backgroundColor: Colors.yellow,
          title: Text(
            "Student App",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 120, vertical: 10),
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/graduated.png"),
                  radius: 80,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextBox(
                FiledType: "Name",
                icon: "student.png",
                controllar: nameController,
                change: (name) {
                  getName(name);
                },
              ),
              TextBox(
                FiledType: "Student ID",
                icon: "id-card (1).png",
                controllar: SidController,
                change: (ID) {
                  getID(ID);
                },
              ),
              TextBox(
                FiledType: "Student Program",
                icon: "program.png",
                controllar: SPController,
                change: (Program) {
                  getProgram(Program);
                },
              ),
              TextBox(
                FiledType: "CGPA",
                icon: "best.png",
                controllar: CGPAController,
                change: (cgpa) {
                  getCGPA(cgpa);
                },
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Buttons(
                    Btntext: "Create",
                    color: Colors.purple,
                    onclick: () {
                      createData();
                    },
                  ),
                  Buttons(
                    Btntext: "Read",
                    color: Colors.green,
                    onclick: () {
                      setState(() {
                        isShow = true;
                      });
                    },
                  ),
                  Buttons(
                    Btntext: "update",
                    color: Colors.blue,
                    onclick: () {
                      updateData();
                    },
                  ),
                  Buttons(
                    Btntext: "delete",
                    color: Colors.red,
                    onclick: () {
                      deleteData();
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  ShowData(
                    type: "Name",
                    isHeading: true,
                  ),
                  ShowData(
                    type: "Student ID",
                    isHeading: true,
                  ),
                  ShowData(
                    type: "Student Program",
                    isHeading: true,
                  ),
                  ShowData(
                    type: "CGPA",
                    isHeading: true,
                  ),
                ],
              ),
              isShow
                  ? StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("Student")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          if (snapshot.hasData && snapshot.data != null) {
                            return Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  Map<String, dynamic> usermap =
                                      snapshot.data!.docs[index].data()
                                          as Map<String, dynamic>;
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      children: [
                                        ShowData(type: usermap["Name"]),
                                        ShowData(type: usermap["Student ID"]),
                                        ShowData(
                                            type: usermap["Student Program"]),
                                        ShowData(type: usermap["CGPA"]),
                                      ],
                                    ),
                                  );
                                  // return ListTile(
                                  //     title: Text(usermap["Name"]),
                                  //     subtitle: Text(usermap["Student ID"] +
                                  //         " " +
                                  //         usermap["Student Program"]),
                                  //     trailing: Text(usermap["CGPA"]));
                                },
                              ),
                            );
                          } else {
                            return Text("No data");
                          }
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    )
                  : Center(
                      child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        "Click read to Display Data",
                        style: TextStyle(fontSize: 20),
                      ),
                    )),
            ]),
          ),
        ),
      ),
    );
  }
}
