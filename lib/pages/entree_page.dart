import 'package:flutter/material.dart';
import 'package:fab_flutter/recettes_master.dart';

class EntreePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RecettesMasterPage(
      title: "Recettes d'Entrée",
      imageUrl: "entree.png",
      typeRecette: "Entrée",
    );
  }
}
