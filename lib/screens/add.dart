import 'package:flutter/material.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/services/database_helper.dart';

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  DatabaseHelper dbHelper = DatabaseHelper();
  String _day = 'Sunday';
  String _todo;
  void initDatabase() async {
    await dbHelper.openDatabaseCU();
  }

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  @override
  Widget build(BuildContext context) {
    bool showSpinner = false;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Center(
        child: showSpinner
            ? CircularProgressIndicator(
                backgroundColor: Colors.white,
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        height: 40.0,
                      ),
                      TextField(
                        textAlign: TextAlign.center,
                        onChanged: (String value) {
                          setState(() => _todo = value);
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(Icons.text_fields),
                          counterText: '',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                            gapPadding: 4.0,
                          ),
                          labelText: 'Todo',
                          hintText: 'Todo',
                        ),
                        autofocus: false,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      DropdownButton<String>(
                        value: _day,
                        elevation: 16,
                        onChanged: (String newValue) {
                          setState(() {
                            _day = newValue;
                          });
                        },
                        items: <String>[
                          'Sunday',
                          'Monday',
                          'Tuesday',
                          'Wednesday',
                          'Thursday',
                          'Friday',
                          'Saturday',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 40.0,
                            vertical: 10.0,
                          ),
                          child: Text('Add'),
                          color: Colors.deepOrange,
                          onPressed: () async {
                            if (_day != '' || _todo != '') {
                              dbHelper.insertDataCU(Todo(
                                todo: _todo,
                                day: _day,
                              ));
                              Navigator.pop(context);
                            }
                          }),
                      SizedBox(
                        height: 40.0,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
