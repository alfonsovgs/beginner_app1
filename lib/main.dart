import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => new _State();
}

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
        lastDate: new DateTime(2019)
    );

    if(picked != null) setState (() {
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Name here'),
        ),
        body: new Container(
            padding: new EdgeInsets.all(30.0),
            child: new SingleChildScrollView(
              child: new Center(
                child: new Column(
                  children: <Widget>[
                    new Text("ValueInt = $_valueInt"),
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
                    new Checkbox(
                        value: _value1,
                        onChanged: _value1Change
                    ),
                    new CheckboxListTile(
                      title: new Text("Yes"),
                      value: _value2,
                      onChanged: _value2Change,
                      controlAffinity: ListTileControlAffinity.leading,
                      subtitle: new Text("my subtitle"),
                      secondary: new Icon(Icons.archive),
                      activeColor: Colors.red,
                    ),
                    new Switch(
                        value: _valueS1,
                        onChanged: _onChangeS1
                    ),
                    new SwitchListTile(
                        value: _valueS2,
                        onChanged: _onChangeS2,
                        title: new Text('Hello Switch', style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                    ),
                    new Text('Value Slider: ${(_valueSlider*100).round()}'),
                    new Slider(
                        value: _valueSlider,
                        onChanged: _setValueSlider
                    ),
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
                        icon: new Icon(Icons.remove), onPressed: _substract)
                  ],
                ),
              ),
            )
        )
    );
  }
}
