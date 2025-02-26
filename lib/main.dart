import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';
import 'pages/ajout_recette.dart';
import 'pages/dessert_page.dart';
import 'pages/entree_page.dart';
import 'pages/plat_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('fr_FR', null);
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.purple),
      home: HomePage()));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  final pages = [EntreePage(), PlatPage(), DessertPage(), AjoutRecettePage()];

  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: pageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            pageIndex = index;
          });
        },
        backgroundColor: Colors.purple.shade100,
        destinations: [
          NavigationDestination(icon: Icon(Icons.coffee), label: "Entrée"),
          NavigationDestination(icon: Icon(Icons.fireplace), label: "Plat"),
          NavigationDestination(icon: Icon(Icons.cake), label: "Dessert"),
          NavigationDestination(icon: Icon(Icons.add), label: "Ajouter")
        ],
      ),
    );
  }
}
