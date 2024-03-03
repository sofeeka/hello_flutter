import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  Person(this._name, [this._surname]);

  Person.sofiia() : this('Sofiia', 'Hrychukh');

  void setName(String name) {
    _name = name;
  }

  void setSurname(String surname) {
    _surname = surname;
  }

  String getName() {
    return _name;
  }

  String getSurname() {
    return _surname ?? '';
  }

  String getFullName() {
    // string interpolation
    return '${getName()} ${getSurname()}';
  }
}

class MyHomePage extends StatefulWidget {
  // compile-time constant
  const MyHomePage();

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              NameCard(Person('Sofiia')),
              NameCard(Person.sofiia()),
              NameCard(Person('Empat', 'School')),
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
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            widget._person.getFullName(),
            style: style,
          )),
    );
  }
}
