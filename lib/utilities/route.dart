import 'package:employee_crud_fontend/screen/my_home_page.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (context) => const MyHomePage(
                  title: 'Home',
                ));

      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                  appBar: AppBar(
                    title: const Text("OUPS"),
                    centerTitle: true,
                  ),
                  body: const Center(
                    child: Text("Comming Soon ..."),
                  ),
                ));
    }
  }
}
