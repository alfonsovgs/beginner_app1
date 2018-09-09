import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => new _State();
}

enum Answers { YES, NO, MAYBE }

class _State extends State<MyApp> {
  String _value = 'Hello World';
  int _valueInt = 0;
  bool _value1 = false;
  bool _value2 = false;
  int _valueR1 = 0;
  int _valueR2 = 0;
  bool _valueS1 = false;
  bool _valueS2 = false;
  double _valueSlider = 0.0;
  String _valueDate = '';
  List<BottomNavigationBarItem> _items;
  int _index = 0;
  TextEditingController _user = new TextEditingController();
  TextEditingController _pass = new TextEditingController();
  Map _countries = new Map();

  void _getData() async {
    var url ='http://country.io/names.json';
    var response = await http.get(url);

    if(response.statusCode == 200) {
      setState(() {
        _countries = JSON.decode(response.body);
        print('Loaded ${_countries.length} countries');
      });
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();

  void _onPressed(String value) {
    setState(() {
      //_value = value;
      _value = new DateTime.now().toString();
    });
  }

  void _onChange(String value) {
    setState(() {
      _value = 'Change: $value';
    });
  }

  void _onSubmit(String value) {
    setState(() {
      _value = 'Submit: $value';
    });
  }

  void _add() {
    setState(() {
      _valueInt++;
    });
  }

  void _substract() {
    setState(() {
      _valueInt--;
    });
  }

  void _value1Change(bool value) {
    setState(() {
      _value1 = value;
    });
  }

  void _value2Change(bool value) {
    setState(() {
      _value2 = value;
    });
  }

  void _setValueR1(int value) => setState(() => _valueR1 = value);
  void _setValueR2(int value) => setState(() => _valueR2 = value);
  void _onChangeS1(bool value) => setState(() => _valueS1 = value);
  void _onChangeS2(bool value) => setState(() => _valueS2 = value);
  void _setValueSlider(double value) => setState(() => _valueSlider = value);

  Future _selectDate() async {
    var picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2019));

    if (picked != null)
      setState(() {
        _valueDate = picked.toString();
      });
  }

  Widget makeRadios() {
    List list = new List<Widget>();

    for (int i = 0; i < 3; i++) {
      list.add(
          new Radio(value: i, groupValue: _valueR1, onChanged: _setValueR1));
    }

    Column column = new Column(
      children: list,
    );

    return column;
  }

  Widget makeRadiosTiles() {
    List list = new List<Widget>();

    for (int i = 0; i < 3; i++) {
      list.add(new RadioListTile(
        value: i,
        groupValue: _valueR2,
        onChanged: _setValueR2,
        activeColor: Colors.green,
        controlAffinity: ListTileControlAffinity.trailing,
        title: new Text('Item $i'),
        subtitle: new Text('Subtitle $i'),
      ));
    }

    Column column = new Column(
      children: list,
    );

    return column;
  }

  void _showBottom() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return new Container(
            padding: new EdgeInsets.all(15.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  'Some info',
                  style: new TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold),
                ),
                new RaisedButton(
                  onPressed: () => Navigator.pop(context),
                  child: new Text('Close'),
                )
              ],
            ),
          );
        });
  }

  void _showBar() {
    _scaffoldState.currentState.showSnackBar(new SnackBar(
      content: new Text('Hello World'),
    ));
  }

  Future _showAlert(BuildContext context, String message) async {
    return showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text(message),
          actions: <Widget>[
            new FlatButton(
                onPressed: () => Navigator.pop(context), child: new Text('Ok'))
          ],
        ));
  }

  void _setValueEnum(String value) => setState(() => _value = value);

  Future _askUser() async {
    var dialog = await showDialog(
        context: context,
        child: new SimpleDialog(
          title: new Text('Do yo like Flutter?'),
          children: <Widget>[
            new SimpleDialogOption(
                child: new Text('Yes :)'),
                onPressed: () => Navigator.pop(context, Answers.YES)),
            new SimpleDialogOption(
                child: new Text('No :('),
                onPressed: () => Navigator.pop(context, Answers.NO)),
            new SimpleDialogOption(
                child: new Text('Maybe :|'),
                onPressed: () => Navigator.pop(context, Answers.MAYBE)),
          ],
        ));

    switch (dialog) {
      case Answers.YES:
        _setValueEnum('Yes');
        break;
      case Answers.NO:
        _setValueEnum('No');
        break;
      case Answers.MAYBE:
        _setValueEnum('Maybe');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldState,
      appBar: new AppBar(
        title: new Text('Name here'),
        backgroundColor: Colors.red,
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.add), onPressed: _add),
          new IconButton(icon: new Icon(Icons.remove), onPressed: _substract)
        ],
      ),
      drawer: new Drawer(
        child: new Container(
          padding: new EdgeInsets.all(32.0),
          child: new Column(
            children: <Widget>[
              new Text('Hello drawer'),
              new RaisedButton(
                onPressed: () => Navigator.pop(context),
                child: new Text('close'),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _selectDate,
        backgroundColor: Colors.red,
        child: new Icon(Icons.date_range),
        mini: false,
      ),
      persistentFooterButtons: <Widget>[
        new IconButton(
            icon: new Icon(Icons.timer), onPressed: () => _onChange('timer')),
        new IconButton(
            icon: new Icon(Icons.favorite),
            onPressed: () => _onChange("favorito")),
        new IconButton(
            icon: new Icon(Icons.people), onPressed: () => _onChange("people")),
      ],
      body: new Container(
          padding: new EdgeInsets.all(30.0),
          child: new SingleChildScrollView(
            child: new Center(
              child: new Column(
                children: <Widget>[
                  new Text(
                    "ValueInt = $_valueInt",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 37.0),
                  ),
                  new Text(_value),
                  new TextField(
                    decoration: new InputDecoration(
                      labelText: 'Hello',
                      hintText: 'Hint',
                      icon: new Icon(Icons.people),
                    ),
                    autocorrect: true,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    onChanged: _onChange,
                    onSubmitted: _onSubmit,
                  ),
                  makeRadios(),
                  makeRadiosTiles(),
                  new Checkbox(value: _value1, onChanged: _value1Change),
                  new CheckboxListTile(
                    title: new Text("Yes"),
                    value: _value2,
                    onChanged: _value2Change,
                    controlAffinity: ListTileControlAffinity.leading,
                    subtitle: new Text("my subtitle"),
                    secondary: new Icon(Icons.archive),
                    activeColor: Colors.red,
                  ),
                  new Switch(value: _valueS1, onChanged: _onChangeS1),
                  new SwitchListTile(
                    value: _valueS2,
                    onChanged: _onChangeS2,
                    title: new Text('Hello Switch',
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red)),
                  ),
                  new Text('Value Slider: ${(_valueSlider*100).round()}'),
                  new Slider(value: _valueSlider, onChanged: _setValueSlider),
                  new Text("Date is: $_valueDate"),
                  new RaisedButton(
                    onPressed: _selectDate,
                    child: new Text('Select Date'),
                  ),
                  new RaisedButton(
                    onPressed: () =>
                        _onPressed('Hello my name is Alfonso Vargas'),
                    child: new Text('Click me'),
                  ),
                  new FlatButton(
                      onPressed: () => _onPressed('aa'),
                      child: new Text('Click me')),
                  new IconButton(
                    icon: new Icon(Icons.add),
                    onPressed: _add,
                  ),
                  new IconButton(
                      icon: new Icon(Icons.remove), onPressed: _substract),
                  new RaisedButton(
                    onPressed: _showBottom,
                    child: new Text('Click Me'),
                  ),
                  new RaisedButton(
                      onPressed: _showBar, child: new Text('Show Bar')),
                  new RaisedButton(
                    onPressed: () =>
                        _showAlert(context, 'Do you like flutter, I do!'),
                    child: new Text("Show Alert"),
                  ),
                  new RaisedButton(
                    onPressed: _askUser,
                    child: new Text('Ask User'),
                  ),
                  new Text('Please Login'),
                  new Row(
                    children: <Widget>[
                      new Text('Username: '),
                      new Expanded(child: new TextField(controller: _user,))
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Text('Password: '),
                      new Expanded(child: new TextField(controller: _pass, obscureText: true,))
                    ],
                  ),
                  new Padding(
                      padding: EdgeInsets.all(12.0),
                      child: new RaisedButton(onPressed: () => print('Login ${_user.text}'), child: new Text('Click me')),
                  ),
                  new Card(
                    child: new Container(
                      padding: new EdgeInsets.all(32.0),
                      child: new Column(
                       children: <Widget>[
                         new Text('Helo World'),
                         new Text('How Are yo?')
                       ],
                      ),
                    ),
                  ),

                  new Card(
                    child: new Container(
                      padding: new EdgeInsets.all(32.0),
                      child: new Column(
                        children: <Widget>[
                          new Text('Helo World'),
                          new Text('How Are yo?')
                        ],
                      ),
                    ),
                  ),

                  new Card(
                    child: new Container(
                      padding: new EdgeInsets.all(32.0),
                      child: new Column(
                        children: <Widget>[
                          new Text('Helo World'),
                          new Text('How Are yo?')
                        ],
                      ),
                    ),
                  ),
                  new Text('Image Demo'),
                  new Image.asset('images/flutter.jpg'),
                  new Image.network('http://voidrealms.com/images/smile.jpg'),
                  new Text('Countries', style: new TextStyle(fontWeight: FontWeight.bold),),
                  /*new ListView.builder(
                    itemCount: _countries.length,
                    itemBuilder: (BuildContext context, int index) {
                      String key = _countries.keys.elementAt(index);
                      return new Row(
                        children: <Widget>[
                          new Text('$key : '),
                          new Text(_countries[key])
                        ],
                      );
                    },
                  )*/
                ],
              ),
            ),
          )),
      bottomNavigationBar: new BottomNavigationBar(
        items: _items,
        fixedColor: Colors.green,
        currentIndex: _index,
        onTap: (int item) {
          setState(() {
            _index = item;
            _value = 'Current value is: $_index';
          });
        },
      ),
    );
  }

  @override
  void initState() {
    _getData();

    _items = new List();
    _items.add(new BottomNavigationBarItem(
        icon: new Icon(Icons.people), title: new Text('People')));
    _items.add(new BottomNavigationBarItem(
        icon: new Icon(Icons.weekend), title: new Text('Weekend')));
    _items.add(new BottomNavigationBarItem(
        icon: new Icon(Icons.message), title: new Text('Message')));
  }
}
