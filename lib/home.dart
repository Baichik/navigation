import 'package:flutter/material.dart';
import 'package:navigation/calculate/calculator.dart';
import 'package:navigation/clima/screens/loading_screen.dart';

class Home extends StatelessWidget {
  const Home({Key? key, this.myAppTitle}) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final String? myAppTitle;

  Widget buildMenuComponent(String text, IconData icon,
      {VoidCallback? onClicked}) {
    return ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        leading: Icon(
          icon,
          size: 40,
          color: const Color.fromARGB(255, 255, 255, 255),
        ),
        title: Text(
          text,
          style: const TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 20,
            letterSpacing: 1.0,
          ),
        ),
        onTap: onClicked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:
            myAppTitle == null ? const Text('Navigation') : Text(myAppTitle!),
      ),
      drawer: Drawer(
          child: Material(
        color: const Color.fromRGBO(50, 75, 205, 1),
        child: ListView(
          children: <Widget>[
            const SizedBox(
              height: 80,
            ),
            buildMenuComponent(
              'Calculator',
              Icons.calculate_outlined,
              onClicked: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Calculator()));
              },
            ),
            buildMenuComponent('Climate', Icons.wb_cloudy_rounded,
                onClicked: (() {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const LoadingScreen()));
            }))
          ],
        ),
      )),
      body: const Center(
          child: SizedBox(
        width: 200,
        child: Text(
          'Welcome to the navigation app. Here you can use slide bar and go to another page.',
          textAlign: TextAlign.justify,
          style: TextStyle(
            color: Color.fromARGB(255, 80, 80, 80),
            fontSize: 20,
            letterSpacing: 1.0,
          ),
        ),
      )),
    );
  }
}
