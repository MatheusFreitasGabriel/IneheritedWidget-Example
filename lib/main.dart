import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InheritedWidgetExample extends InheritedWidget {
  final int age;

  InheritedWidgetExample({required this.age, required Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidgetExample oldWidget) {
    return oldWidget.age != age;
  }

  static InheritedWidgetExample of(BuildContext context) {
    final InheritedWidgetExample? result = context.dependOnInheritedWidgetOfExactType<InheritedWidgetExample>();
    return result!;
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _age = 20;

  void _incrementAge() {
    setState(() {
      _age++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InheritedWidgetExample(
      age: _age,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(title: Text('InheritedWidget Example')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UserAgeDisplay(),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _incrementAge,
                  child: Text("Increase Age"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserAgeDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int userAge = InheritedWidgetExample.of(context).age;
    return Text(
      'User age: $userAge',
      style: TextStyle(fontSize: 24),
    );
  }
}
