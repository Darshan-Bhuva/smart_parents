// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_parents/components/constants.dart';
import 'package:smart_parents/widgest/dropDownWidget.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class Department {
  final String id;
  final String name;

  Department(this.id, this.name);
}

class Subject {
  final String id;
  final String name;

  Subject(this.id, this.name);
}

class AddSchedule extends StatefulWidget {
  const AddSchedule({Key? key}) : super(key: key);

  @override
  _AddScheduleState createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  DateTime start = DateTime.now();
  String _start = DateFormat('hh:mm a').format(DateTime.now());
  DateTime end = DateTime.now().add(const Duration(hours: 1));
  String _end = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(hours: 1)));
  String? Branch;
  var Sub;
  List<Subject> _subjects = [];

  @override
  void initState() {
    super.initState();
    _fetchSubjects();
  }

  Future<void> _fetchSubjects() async {
    final QuerySnapshot<Map<String, dynamic>> subjectSnapshot =
        await FirebaseFirestore.instance
            .collection('Admin/$admin/subject')
            .get();

    final List<Subject> subjects = [];

    for (final DocumentSnapshot<Map<String, dynamic>> subjectSnapshot
        in subjectSnapshot.docs) {
      final Subject subject =
          Subject(subjectSnapshot.id, subjectSnapshot.data()!['sub_name']);
      subjects.add(subject);
    }

    setState(() {
      _subjects = subjects;
      Sub = _subjects[0].name;
    });
  }

  @override
  Widget build(BuildContext context) {
    dynamic fieldTextStyle = const TextStyle(
        color: Colors.cyan, fontSize: 17, fontWeight: FontWeight.w400);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Attendence"),
      ),
      body: Center(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(children: [
                Column(
                  children: [
                    const Text(
                      "Subject",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                              color: Colors.grey,
                              style: BorderStyle.solid,
                              width: 0.80),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(
                                5.0,
                                5.0,
                              ),
                              blurRadius: 5.0,
                              spreadRadius: 1.0,
                            ),
                          ]),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        // hint: Text(hint,style: TextStyle(color: Colors.black),),
                        value: Sub,
                        // decoration: const InputDecoration(
                        //   border: InputBorder.none,
                        //   contentPadding: EdgeInsets.zero,
                        // ),
                        // hint: const Text('Select an item'),
                        icon: const Icon(Icons.keyboard_arrow_down_outlined),
                        elevation: 16,
                        dropdownColor: Colors.grey[100],
                        style: const TextStyle(color: Colors.black),
                        underline: Container(height: 0, color: Colors.black),
                        onChanged: (value) {
                          setState(() {
                            Sub = value;
                          });
                        },
                        items: _subjects.map((item) {
                          return DropdownMenuItem<String>(
                            value: item.name,
                            child: Text(item.name),
                          );
                        }).toList(),
                        // validator: (value) {
                        //   if (value == null) {
                        //     return 'Please select a subject';
                        //   }
                        //   return null; // return null if there's no error
                        // },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                dropdown(
                    DropdownValue: daysdropdownValue,
                    sTring: Days,
                    Hint: "Day"),
                const SizedBox(
                  height: 20,
                ),
                // Text(
                //       DateFormat('E, dd MMM').format(dates[_selectedIndex]),
                //       style: GoogleFonts.rubik(
                //           fontSize: 30,
                //           color: kPrimaryColor,
                //           fontWeight: FontWeight.bold),
                //     ),
                // const SizedBox(
                //   height: 20,
                // ),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.access_time,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child:
                            // _start.isEmpty
                            //     ? Text(
                            //         'Choose Start Time',
                            //         style: fieldTextStyle,
                            //       )
                            //     :
                            Text(
                      _start,
                      style: fieldTextStyle,
                    )),
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.grey[700],
                      ),
                      onPressed: () {
                        DatePicker.showTime12hPicker(
                          context,
                          theme: const DatePickerTheme(
                            containerHeight: 300,
                            backgroundColor: Colors.white,
                          ),
                          showTitleActions: true,
                          onConfirm: (time) {
                            setState(() {
                              _start = DateFormat('hh:mm a').format(time);
                              start = time;
                              _end = DateFormat('hh:mm a')
                                  .format(start.add(const Duration(hours: 1)));
                              end = time.add(const Duration(hours: 1));
                            });
                          },
                        );
                      },
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.access_time,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child:
                            // _end.isEmpty
                            //     ? Text(
                            //         'Choose Stop Time',
                            //         style: fieldTextStyle,
                            //       )
                            //     :
                            Text(
                      _end,
                      style: fieldTextStyle,
                    )),
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.grey[700],
                      ),
                      onPressed: () {
                        DatePicker.showTime12hPicker(
                          context,
                          theme: const DatePickerTheme(
                            containerHeight: 240,
                            backgroundColor: Colors.white,
                          ),
                          showTitleActions: true,
                          currentTime: end,
                          // showSecondsColumn: false,
                          onConfirm: (time) {
                            setState(() {
                              _end = DateFormat('hh:mm a').format(time);
                              end = time;
                            });
                          },
                        );
                      },
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) =>
                                //           const MyCarouselSlider(),
                                //     ));
                              },
                              child: const Text("Add Schedule")),
                        ),
                      ],
                    ))
              ]),
            ),
          ],
        ),
      ),
    );
    // },
    // ),
    // );
  }
}
