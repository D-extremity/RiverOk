import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nameProvider = StateProvider<String>((ref) => 'Satyam Srivastav');
void main() {
  runApp(const MyApp());
}

// TextEditingController getText = TextEditingController();

void setText(WidgetRef ref, String value) {
  ref.read(nameProvider.notifier).update((state) => value);
}

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
            final String name = ref.watch(nameProvider);

            return Column(
              children: [
                TextField(
                  // controller: getText,
                onSubmitted:(value)=>setText(ref,value),
                ),
                Text(name)
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
