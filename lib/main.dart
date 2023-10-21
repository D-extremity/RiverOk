import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverok/usermodel.dart';

//! Combination of StateNotifier and StateNotifierProvider is used for Complex data
//! on production level StateNotifier and StateNotifierProvider is used as all the business logic lies in just one class
//! here it is on line 63 usermodel.dart file
//! it also helps in maintaining logic part and Ui of app seprately 
//! helps in testing of app 
//! because of other many reasons these both are preffered more than Providers

//^ In user model we used StateNotifier to update the changes made by user
//^  to call it and use it StateNotifierProvider is used
final userProvider = StateNotifierProvider<UserNotifier2, User>(
    (ref) => UserNotifier2(const User(name: "", age: 0)));


//! always call function outside to change any parameter and also it is better way to keep logic and UI part separately 
//! ref.read() is preferred to be called outside because it reads the value once (not continuous)
void setText(WidgetRef ref, String value) {
  ref.read(userProvider.notifier).updateName(value);//!if .notifier would not be there , it would have been impossible to call .update method
}
//^.notifier is used to access the notifier object associated with a state provider, and it allows you to call methods and modify the state using the provided notifier.
//^-->The state object: This represents the current value of the state.
//^-->The notifier object: This is used to modify and update the state.
/* In the code you provided, the .notifier property is used to access the notifier object associated with a Riverpod state provider. Here's an explanation of what it does:

State Provider:
It appears that userProvider is a Riverpod state provider. State providers in Riverpod typically consist of two parts:

-->The state object: This represents the current value of the state.
-->The notifier object: This is used to modify and update the state.
The .notifier property allows you to access the notifier object associated with the state provider.

ref.read(userProvider.notifier): This reads the notifier associated with the userProvider. By doing this, you can access and call methods on the notifier.

.updateName(value): This is calling the updateName method on the notifier. It appears that updateName is a method defined in the notifier object, and it is being used to update the name in the state associated with the userProvider.

So, in summary, .notifier is used to access the notifier object associated with a state provider, and it allows you to call methods and modify the state using the provided notifier. This is a common pattern in Riverpod for managing state.*/

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
