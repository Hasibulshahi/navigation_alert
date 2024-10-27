import 'package:flutter/material.dart';
import 'views/loginPage.dart';

void main()
{
  runApp(const NavigationAlert());
}

class NavigationAlert extends StatelessWidget {
  const NavigationAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Alert',
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: const Login(),
    );
  }
}
