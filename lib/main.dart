import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello, World!',
      home: MyHomePage(),
    );
  }
}

class Person {
  String _name;
  String? _surname;

  Person({required String name, String? surname})
      : _name = name,
        _surname = surname;

  Person.sofiia() : this(name: 'Sofiia', surname: 'Hrychukh');

  set name(String name) {
    _name = name;
  }

  set surname(String surname) {
    _surname = surname;
  }

  String get name => _name;

  String get surname => _surname ?? '';

  String getFullName() {
    return '$name $surname';
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage();

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _buttonClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _buttonClicked = true;
                  });
                },
                label: Text(_buttonClicked ? 'Not me :)' : 'Click me'),
                icon: Icon(Icons.arrow_downward),
              ),
              NameCard(Person.sofiia()),
              NameCard(Person(name: 'for')),
              NameCard(Person(name: 'Empat', surname: 'School')),
            ],
          ),
        ));
  }
}

class NameCard extends StatefulWidget {
  final Person _person;

  NameCard(this._person);

  @override
  State<NameCard> createState() => _NameCardState();
}

class _NameCardState extends State<NameCard> {
  Color? _color;

  Color getColor() {
    return _color ?? Colors.indigo;
  }

  void setColor(Color color) {
    setState(() {
      _color = color;
    });
  }

  void setRandomColor() {
    setColor(getRandomColor());
  }

  Color getRandomColor() {
    return Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.displayMedium!.copyWith(
      color: ColorScheme.fromSeed(seedColor: getColor()).onPrimary,
    );

    return Card(
        color: getColor(),
        child: InkWell(
          onTap: () {
            setRandomColor();
          },
          splashColor: theme.buttonTheme.colorScheme?.onPrimary,
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                widget._person.getFullName(),
                style: style,
              )),
        ));
  }
}
