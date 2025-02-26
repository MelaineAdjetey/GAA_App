import 'package:fab_flutter/pages/planification_repas.dart';
import 'package:flutter/material.dart';

class RecettesMasterPage extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String typeRecette;

  const RecettesMasterPage({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.typeRecette,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(title),
          actions: [
            IconButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PlanificationRepasPage()),
                  );
                  //print("clicked");
                },
                icon: Icon(Icons.calendar_month_outlined))
          ],
          backgroundColor: Colors.purple.shade400),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 colonnes
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: 60, // 20 lignes * 3 colonnes
          itemBuilder: (context, index) {
            return RecipeCard(
              title: '$typeRecette ${index + 1}',
              imageUrl: imageUrl,
            );
          },
        ),
      ),
    );
  }
}

class RecipeCard extends StatelessWidget {
  final String title;
  final String imageUrl;

  const RecipeCard({
    Key? key,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(imageUrl,
                  fit: BoxFit.cover, width: double.infinity),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
