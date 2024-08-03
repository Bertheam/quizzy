import 'package:flutter/material.dart';
import 'package:quizzy/components/carousel/build_info.dart';
import 'package:quizzy/components/categorie_card.dart';
import 'package:quizzy/components/quiz_tile.dart';

class AccueilPage extends StatefulWidget {
  const AccueilPage({super.key});

  @override
  State<AccueilPage> createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  final controllerTextEditing = TextEditingController();
  List categories = [
    CategorieCard(
      color: Colors.cyan,
      icon: Icon(
        Icons.laptop_chromebook,
        color: Colors.grey[700],
        size: 30,
      ),
      libelle: "Informatique",
    ),
    CategorieCard(
        color: Colors.teal,
        icon: Icon(
          Icons.laptop_chromebook,
          color: Colors.grey[700],
          size: 30,
        ),
        libelle: "Droit"),
    CategorieCard(
        color: Colors.teal,
        icon: Icon(
          Icons.laptop_chromebook,
          color: Colors.grey[700],
          size: 30,
        ),
        libelle: "Marketing"),
    CategorieCard(
        color: Colors.teal,
        icon: Icon(
          Icons.laptop_chromebook,
          color: Colors.grey[700],
          size: 30,
        ),
        libelle: "Ressource Humaine"),
    CategorieCard(
        color: Colors.teal,
        icon: Icon(
          Icons.laptop_chromebook,
          color: Colors.grey[700],
          size: 30,
        ),
        libelle: "Administration entreprise"),
  ];
  @override
  Widget build(BuildContext context) {
    print(categories.length);

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.blue.shade800,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 18),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade600,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SizedBox(
                          child: TextField(
                        controller: controllerTextEditing,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          prefixIconColor: Colors.white,
                          contentPadding:
                              const EdgeInsets.only(left: 10, top: 10),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: 'Rechercher',
                          hintStyle: TextStyle(color: Colors.grey.shade100),
                        ),
                        // onChanged: filterNumero,
                      )),
                    ),
                  ),
                  BuildInfo(),
                ],
              ),
            ),
            SizedBox(height: 10),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.4,
                  mainAxisSpacing: 10),
              shrinkWrap: true,
              padding: EdgeInsets.all(10),
              primary: false,
              itemCount: 4,
              itemBuilder: (context, index) {
                return categories[index];
              },
            ),
            categories.length > 4
                ? GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Voir plus',
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                : SizedBox(),
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return QuizTile();
              },
              )
          ],
        )),
      ),
    );
  }
}
