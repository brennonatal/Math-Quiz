// import 'package:flutter/material.dart';

// class MyLoginPage extends StatefulWidget {
//   const MyLoginPage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   State<MyLoginPage> createState() => _MyLoginPageState();
// }

// class _MyLoginPageState extends State<MyLoginPage> {
//   final controller = TextEditingController();

//   @override
//   void dispose() {
//     // Clean up the controller when the widget is disposed.
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Home Page"),
//       ),
//       body: Center(
//         child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: <Widget>[
//                   TextField(
//                     controller: controller,
//                     keyboardType: TextInputType.number,
//                     textInputAction: TextInputAction.done,
//                     maxLength: 4,
//                     style: const TextStyle(
//                       fontSize: 20,
//                     ),
//                     decoration: const InputDecoration(
//                       counterText: "",
//                       border: OutlineInputBorder(),
//                       labelText: '',
//                     ),
//                   ),
//                 ],
//               ),
//             ]),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => MyHomePage(username: 'fulano')));
//         },
//         tooltip: 'Send Answer',
//         child: const Icon(Icons.check),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
