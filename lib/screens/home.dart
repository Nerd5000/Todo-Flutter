import 'package:flutter/material.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/screens/add.dart';
import 'package:todoapp/services/database_helper.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DatabaseHelper dbHelper = DatabaseHelper();
  List<Todo> _listOfTodos = List<Todo>();
  bool showProgress = true;
  void initDatabase() async {
    setState(() {
      showProgress = true;
    });
    await dbHelper.openDatabaseCU();
    List _list = await dbHelper.read();
    _listOfTodos.removeRange(0, _listOfTodos.length);
    for (var item in _list) {
      _listOfTodos.add(Todo(
        todo: item['todo'],
        day: item['day'],
      ));
    }
    setState(() {
      showProgress = false;
    });
  }

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text('Todo App'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              initDatabase();
            },
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Add()));
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: showProgress
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _listOfTodos.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    title: Text(_listOfTodos[index].todo ?? ''),
                    subtitle: Text(_listOfTodos[index].day ?? ''),
                    leading: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        dbHelper.delete(_listOfTodos[index]);
                        initDatabase();
                      },
                    ),
                  ),
                );
              }),
    );
  }
}
