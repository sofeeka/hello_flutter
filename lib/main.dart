import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  workWithCollections();
  runApp(MyApp());
}

void workWithCollections() {
  // arrays
  var list1 = [3, 4];
  var mergedWithList = [1, 2, ...list1, 5, 6];
  print('mergedWithList: $mergedWithList');

  var list2;
  var mergedWithNull = [1, 2, ...?list2, 3, 4];
  print('mergedWithNull: $mergedWithNull');

  var list3 = [5, 6];
  mergedWithNull.addAll(list3);
  print('addAll: $mergedWithNull');

  var odds = mergedWithList.where((element) => element % 2 == 1).toList();
  print('odds: $odds');

  var sum = mergedWithList.reduce((value, element) => value + element);
  print('sum: $sum');

  // map
  Map<int, String> map = {
    1: 'one',
    2: 'two',
  };
  map.addAll({3: 'three', 4: 'four'});
  map[5] = 'five';
  map[6] = 'six';
  print('map: $map');

  map.remove(6);
  print('remove 6: $map');

  map.removeWhere((key, value) => value.length > 3);
  print('removeWhere: $map');

  // set
  var set = <int>{1, 2, 3, 4, 5};
  print('set: $set');

  set.addAll({3, 4, 5, 6});
  print('unique: $set');

  set.union(mergedWithList.toSet());
  print('still unique: $set');

  set.removeWhere((element) => element % 2 == 1);
  print('evens: $set');
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

  Person({required String name, String? surname })
      : _name = name,
        _surname = surname {
    assert(name.isNotEmpty);
  }

  factory Person.studentFactory(
          {required bool flag, String? name, String? surname}) =>
      flag
          ? Student.sofiia()
          : Teacher(
              name: name ?? 'Empat',
              teacherID: 1,
              surname: surname ?? 'School');

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

mixin Teachable {
  int? teacherID;
}

mixin Studyable {
  int? sNumber;
  String? group;
}

class Teacher extends Person with Teachable {
  Teacher({required super.name, super.surname, int? teacherID = 0}) {
    this.teacherID = teacherID;
  }

  int get teacherID => teacherID;
}

class Student extends Person with Studyable {
  Student({required super.name, super.surname});

  Student.sofiia() : super(name: 'Sofiia', surname: 'Hrychukh');

  int getSNumber() {
    return sNumber ?? 0;
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
              NameCard(person: Person.studentFactory(flag: true)),
              NameCard(person: Person(name: 'for')),
              NameCard(person: Person.studentFactory(flag: false)),
            ],
          ),
        ));
  }
}

class NameCard extends StatefulWidget {
  final Person person;

  NameCard({required this.person});

  @override
  State<NameCard> createState() => _NameCardState();
}

class _NameCardState extends State<NameCard> {
  Color? _color;

  Color get color => _color ?? Colors.indigo;

  set color(Color color) => {
        setState(() {
          _color = color;
        })
      };

  void setRandomColor() {
    Color? _priorColor;

    Color getRandomColor() {
      var newColor;

      do {
        newColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];
      } while (newColor == _priorColor);

      _priorColor = newColor;
      return newColor!;
    }

    Function f = getRandomColor;

    color = f();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.displayMedium!.copyWith(
      color: ColorScheme.fromSeed(seedColor: color).onPrimary,
    );

    return Card(
        color: color,
        child: InkWell(
          onTap: () {
            setRandomColor();
          },
          splashColor: theme.buttonTheme.colorScheme?.onPrimary,
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                widget.person.getFullName(),
                style: style,
              )),
        ));
  }
}
