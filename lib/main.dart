import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "riverpod/usermodel.dart" as model;
// import 'package:riverprac/riverpod/usermodel.dart';   because package also has same class and same name

void main() {
  runApp(MyApp());
}

final userData = StateNotifierProvider<model.Notifier, model.User>(
    (ref) => model.Notifier(model.User(" ", 0)));


void changeName(WidgetRef ref,String name){
  ref.read(userData.notifier).updateName(name);
}

void changeAge(WidgetRef ref,int age){
  ref.read(userData.notifier).updateAge(age);
}

class MyApp extends StatelessWidget {
  const  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: ProviderScope(
            child: Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final user = ref.watch(userData);
                return Column(
                  children: [
                    TextField(
                      onSubmitted: (value)=>changeName(ref, value),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      onSubmitted: (value) =>changeAge(ref, int.parse(value) ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(user.name),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("${user.age}"),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
