import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverok/usermodel.dart';

//! Combination of StateNotifier and StateNotifierProvider is used for Complex data
//! on production level StateNotifier and StateNotifierProvider is used as all the business logic lies in just one class
//! here it is on line 63 usermodel.dart file
//! it also helps in maintaining logic part and Ui of app seprately 
//! helps in testing of app 
//! because of other many reasons these both are preffered more than Providers

//^ In user model we used StateNotifier to change the changes made by user
//^  to call it and use it StateNotifierProvider is used
final userProvider = StateNotifierProvider<UserNotifier2, User>(
    (ref) => UserNotifier2(const User(name: "", age: 0)));


//! always call function outside to change any parameter and also it is better way to keep logic and UI part separately 
void setText(WidgetRef ref, String value) {
  ref.read(userProvider.notifier).updateName(value);
}

void main() {
  runApp(const MyApp());
}

// TextEditingController getText = TextEditingController();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(
      child: MaterialApp(
        home: Screen1(),
      ),
    );
  }
}

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  @override
  Widget build(BuildContext context) {
    // final String name = ref.read(nameProvider);
    return SafeArea(
      child: Scaffold(
        body: Consumer(
          builder: (context, ref, child) {
            final user = ref.watch(userProvider);

            return Column(
              children: [
                TextField(
                  // controller: getText,
                  onSubmitted: (value) => setText(ref, value),
                ),
                Text(
                  "${user.name} ${user.age}",
                  style: const TextStyle(color: Colors.black),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

// class _Screen1State extends State<Screen1> {
//   @override
//   Widget build(BuildContext context,WidgetRef ref) {

//     return const SafeArea(child: Scaffold(
//       body: Column(
//         children: [
//           Text()
//         ],
//       ),
//     ));
//   }
// }
