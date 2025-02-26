import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class PlanificationRepasPage extends StatefulWidget {
  @override
  _PlanificationRepasPageState createState() => _PlanificationRepasPageState();
}

class _PlanificationRepasPageState extends State<PlanificationRepasPage> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  // Fonction pour normaliser une date (ignorer l'heure)
  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  // Exemple de repas planifiés (les clés doivent être normalisées)
  Map<DateTime, String> repasPlanifies = {
    DateTime(2025, 2, 25): "Poulet rôti avec légumes",
    DateTime(2025, 2, 26): "Riz au curry",
    DateTime(2025, 2, 27): "Spaghetti bolognaise",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Planification des repas"),
        backgroundColor: Colors.purple.shade400,
      ),
      body: Column(
        children: [
          // Calendrier
          Padding(
            padding: const EdgeInsets.all(16),
            child: TableCalendar(
              locale: 'fr_FR',
              focusedDay: _focusedDay,
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = _normalizeDate(selectedDay); // Normaliser la sélection
                  _focusedDay = focusedDay;
                });
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.purple.shade200,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.purple,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),

          // Affichage du repas sélectionné
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0), // Espacement sur les côtés
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "REPAS DU JOUR",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Image du repas
                      Container(
                        height: 60,
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            repasPlanifies[_normalizeDate(_selectedDay)] != null &&
                                    repasPlanifies[_normalizeDate(_selectedDay)] != "Aucun repas planifié"
                                ? "plat.png"
                                : "empty.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),

                      // Texte du repas
                      Expanded(
                        child: Text(
                          repasPlanifies[_normalizeDate(_selectedDay)] ?? "Aucun repas planifié",
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      // Boutons d'action
                      buildActionButtons(repasPlanifies[_normalizeDate(_selectedDay)]),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Fonction pour gérer l'affichage des boutons
  Widget buildActionButtons(String? repas) {
    if (repas != null && repas != "Aucun repas planifié") {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Espacement entre les boutons
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.remove_red_eye_outlined, color: Colors.purple.shade300),
          ),
          SizedBox(width: 5), // Espacement réduit entre les boutons
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit, color: Colors.purple.shade300),
          ),
        ],
      );
    } else {
      return IconButton(
        onPressed: () {},
        icon: Icon(Icons.edit, color: Colors.purple.shade300),
      );
    }
  }
}
