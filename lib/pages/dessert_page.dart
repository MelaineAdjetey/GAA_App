import 'package:flutter/material.dart';
import 'package:fab_flutter/recettes_master.dart';

class DessertPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RecettesMasterPage(
      title: "Recettes des desserts",
      imageUrl: "dessert.png",
      typeRecette: "Dessert",
    );
  }
}
