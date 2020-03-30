import 'package:flutter/material.dart';

class WidgetsList with ChangeNotifier {
  List<Widget> _list = List<Widget>();
  List<Widget> get list => _list;

  bool get isEmpty => _list.isEmpty;

  void addToWidget(String title, String day) {
    _list.add(
      Card(
        color: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
          title: Text(title ?? ''),
          subtitle: Text(day ?? ''),
          leading: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {},
          ),
        ),
      ),
    );
    notifyListeners();
  }
}
