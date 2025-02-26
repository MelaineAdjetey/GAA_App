import 'package:flutter/material.dart';
import 'package:fab_flutter/recettes_master.dart';

class PlatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RecettesMasterPage(
      title: "Recettes des plats",
      imageUrl: "plat.png",
      typeRecette: "Plat principale",
    );
  }
}
