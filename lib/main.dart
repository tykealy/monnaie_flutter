import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monnaie',
      debugShowCheckedModeBanner: false, // Add this line
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        scaffoldBackgroundColor: const Color(0xFFebdedc),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: "tk's monnaie app"),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFebdedc),
          title: Text(title),
        ),
        body: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Overall()],
        ));
  }
}

class Overall extends StatelessWidget {
  const Overall({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xFFf3ebea),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFc7bab8),
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 15, left: 15, right: 15, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Total Spent"),
                        const Text(
                          "0\$",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 15),
                              child: const OverallButton(action: "Swap"),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 15),
                              child: const OverallButton(action: "Transfer"),
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class OverallButton extends StatefulWidget {
  final String action;

  const OverallButton({Key? key, required this.action}) : super(key: key);

  @override
  OverallButtonState createState() => OverallButtonState();
}

class OverallButtonState extends State<OverallButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130, // Set the width you want here
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFfdbf1e),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.black),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              offset: Offset(3, 4), // Position of shadow
              blurRadius: 0, // Blur level
              spreadRadius: 1, // Spread level
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            // Handle button press
          },
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              backgroundColor: MaterialStateProperty.all(
                const Color(0xFFfdbf1e),
              ), // Make the button background transparent
              elevation: MaterialStateProperty.all(0)),
          child: Text(
            widget.action,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
