import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'planification_repas.dart';
import 'dart:io';

class AjoutRecettePage extends StatefulWidget {
  @override
  _AjoutRecettePageState createState() => _AjoutRecettePageState();
}

class _AjoutRecettePageState extends State<AjoutRecettePage> {
  final _formKey = GlobalKey<FormState>();
  String? _nomRecette, _categorie;
  double? _tempsPreparation, _tempsCuisson;
  List<String> _ingredients = [];
  List<String> _instructions = [];
  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));
    }
  }

  void _formatIngredients(String value) {
    setState(() {
      _ingredients = value.split(',').map((e) => "- " + e.trim()).toList();
    });
  }

  void _formatInstructions(String value) {
    setState(() {
      _instructions = value
          .split('.')
          .where((e) => e.trim().isNotEmpty)
          .map((e) => "Etape${_instructions.length + 1}. ${e.trim()}")
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter une Recette"),
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
        backgroundColor: Colors.purple.shade400,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 5,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: _image != null
                              ? Image.file(_image!, fit: BoxFit.cover)
                              : Icon(Icons.add_a_photo, size: 50, color: Colors.purple.shade400),
                        ),
                      ),
                      SizedBox(height: 10),
                      _buildTextField("Nom de la recette", Icons.restaurant_menu, (value) => _nomRecette = value),
                      SizedBox(height: 10),
                      _buildTextField("Ingrédients", Icons.list, _formatIngredients, maxLines: 3),
                      SizedBox(height: 10),
                      _buildTextField("Instructions", Icons.book, _formatInstructions, maxLines: 5),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField("Préparation (min)", Icons.timer, 
                              (value) => _tempsPreparation = double.tryParse(value ?? ''),
                              keyboardType: TextInputType.number),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: _buildTextField("Cuisson (min)", Icons.fireplace, 
                              (value) => _tempsCuisson = double.tryParse(value ?? ''),
                              keyboardType: TextInputType.number),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: "Catégorie",
                          prefixIcon: Icon(Icons.category, color: Colors.purple.shade400),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        items: ["Entrée", "Plat principal", "Dessert"]
                            .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                            .toList(),
                        onChanged: (value) => setState(() => _categorie = value),
                        onSaved: (value) => _categorie = value,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple.shade400,
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Recette ajoutée avec succès !")),
                            );
                          }
                        },
                        icon: Icon(Icons.add, color: Colors.white),
                        label: Text("Ajouter la Recette", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, Function(String) onChanged, 
      {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.purple.shade400),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      onChanged: onChanged,
      validator: (value) => value!.isEmpty ? "Ce champ est obligatoire" : null,
    );
  }
}
