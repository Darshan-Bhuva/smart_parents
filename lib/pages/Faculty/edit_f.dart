import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:smart_parents/pages/Student/profile_screen_s.dart';
// import 'package:smart_parents/widgest/textfieldwidgetform.dart';

class EditF extends StatefulWidget {
  final String id;
  const EditF({Key? key, required this.id}) : super(key: key);
  @override
  _EditFState createState() => _EditFState();
}

class _EditFState extends State<EditF> {
  final _formKey = GlobalKey<FormState>();

  // Updaing Student
  CollectionReference students =
      FirebaseFirestore.instance.collection('faculty');

  Future<void> updateUser(id, name, email, mono, branch, dob) {
    return students
        .doc(id)
        .update(({
          'name': name,
          'email': email,
          'mono': mono,
          // 'year': year,
          'branch': branch,
          'dob': dob,
          // 'batch': batch
        }))
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  final _dobController = TextEditingController();
  DateTime? _selectedDate;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate ?? DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dobController.text = DateFormat('dd-MM-yyyy').format(_selectedDate!);
        // _dobController.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // Retrieve the date of birth value from Firestore
    FirebaseFirestore.instance
        .collection('faculty')
        .doc(widget.id)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        // Convert the value to a DateTime object
        DateTime dob = snapshot.get('dob').toDate();

        setState(() {
          // Store the value in the _selectedDate field and display it in the TextField
          _selectedDate = dob;
          _dobController.text = DateFormat('dd-MM-yyyy').format(_selectedDate!);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Color.fromARGB(255, 37, 86, 116),
          leading: BackButton(),
          title: Text('FACULTY DETAILS')),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          // Getting Specific Data by ID
          child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection('faculty')
                .doc(widget.id)
                .get(),
            builder: (_, snapshot) {
              if (snapshot.hasError) {
                print('Something Went Wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              var data = snapshot.data!.data();
              //var number = data!['number'];
              var name = data!['name'];
              var email = data['email'];
              var mono = data['mono'];
              //var year = data['year'];
              var branch = data['branch'];
              // var dob = data['dob'];
              //var batch = data['batch'];
              return Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'EDIT',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Text(
                          "Name",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: TextFormField(
                          // readOnly: true,
                          initialValue: name,
                          autofocus: false,
                          onChanged: (value) => name = value,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 2, horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  // TextFieldWidgetForm(
                  //   initialValue: name,
                  //   label: "Name",
                  //   onChanged: (value) => name = value,
                  //   text: "$name",
                  //   // controller: name,
                  // ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Text(
                          "Email",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: TextFormField(
                          // readOnly: true,
                          initialValue: email,
                          autofocus: false,
                          onChanged: (value) => email = value,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 2, horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  //       child: Text(
                  //         "Enrollment Number",
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.bold, fontSize: 18.0),
                  //       ),
                  //     ),
                  //     const SizedBox(
                  //       height: 5,
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  //       child: TextFormField(
                  //         readOnly: true,
                  //         initialValue: number,
                  //         autofocus: false,
                  //         onChanged: (value) => number = value,
                  //         style: TextStyle(fontSize: 20),
                  //         decoration: InputDecoration(
                  //           contentPadding: EdgeInsets.symmetric(
                  //               vertical: 2, horizontal: 10),
                  //           border: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(12),
                  //           ),
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Text(
                          "Mobile Number",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: TextFormField(
                          // readOnly: true,
                          initialValue: mono,
                          autofocus: false,
                          onChanged: (value) => mono = value,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 2, horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: <Widget>[
                  // Flexible(child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Text(
                          "DOB",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: TextFormField(
                          // readOnly: true,
                          // initialValue: dob,
                          autofocus: false,
                          keyboardType: TextInputType.datetime,
                          style: const TextStyle(fontSize: 20),
                          controller: _dobController,
                          onTap: () => _selectDate(context),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your date of birth';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.calendar_today),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 2, horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      // Row(
                      //   // crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      // TextFormField(
                      //   // readOnly: true,
                      //   initialValue: dob,
                      //   readOnly: true,
                      //   autofocus: false,
                      //   onChanged: (value) => dob = value,
                      //   style: TextStyle(fontSize: 20),
                      //   decoration: InputDecoration(
                      //     contentPadding:
                      //         EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(12),
                      //     ),
                      //   ),
                      // ),
                      // IconButton(
                      //   icon: Icon(
                      //     Icons.edit,
                      //     color: Colors.grey[700],
                      //   ),
                      //   onPressed: () {
                      //     DatePicker.showDatePicker(
                      //       context,
                      //       theme: DatePickerTheme(
                      //         containerHeight: 350,
                      //         backgroundColor: Colors.white,
                      //       ),
                      //       showTitleActions: true,
                      //       onConfirm: (dt) {
                      //         setState(() {
                      //           dob = dt.toString().substring(0, 10);
                      //         });
                      //       },
                      //     );
                      //   },
                      // )
                      //   ],
                      // ),
                    ],
                  ),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  // Flexible( child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Text(
                          "Branch",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: TextFormField(
                          // readOnly: true,
                          initialValue: branch,
                          autofocus: false,
                          onChanged: (value) => branch = value,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 2, horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  // ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 15,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: <Widget>[
                  //     Flexible(
                  //       child: Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  //       child: Text(
                  //         "Semester",
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.bold, fontSize: 18.0),
                  //       ),
                  //     ),
                  //     const SizedBox(
                  //       height: 5,
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  //       child: TextFormField(
                  //         // readOnly: true,
                  //         initialValue: sem,
                  //         autofocus: false,
                  //         onChanged: (value) => sem = value,
                  //         style: TextStyle(fontSize: 20),
                  //         decoration: InputDecoration(
                  //           contentPadding: EdgeInsets.symmetric(
                  //               vertical: 2, horizontal: 10),
                  //           border: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(12),
                  //           ),
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // ),
                  //     ),
                  //     Flexible(
                  //       child: Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  //       child: Text(
                  //         "Batch",
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.bold, fontSize: 18.0),
                  //       ),
                  //     ),
                  //     const SizedBox(
                  //       height: 5,
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  //       child: TextFormField(
                  //         // readOnly: true,
                  //         initialValue: batch,
                  //         autofocus: false,
                  //         onChanged: (value) => batch = value,
                  //         style: TextStyle(fontSize: 20),
                  //         decoration: InputDecoration(
                  //           contentPadding: EdgeInsets.symmetric(
                  //               vertical: 2, horizontal: 10),
                  //           border: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(12),
                  //           ),
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: ElevatedButton(
                        onPressed: () => {
                              if (_formKey.currentState!.validate())
                                {
                                  updateUser(widget.id, name, email, mono,
                                      branch, _selectedDate),
                                  Navigator.pop(context)
                                }
                            },
                        child: Text(
                          "Confirm",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 37, 86, 116),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0)),
                          fixedSize: Size(300, 60),
                        )),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}