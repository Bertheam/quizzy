import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CategorieCard extends StatefulWidget {
  Color color;
  Icon icon;
  String libelle;
  CategorieCard({super.key, required this.color, required this.icon, required this.libelle});

  @override
  State<CategorieCard> createState() => _CategorieCardState();
}

class _CategorieCardState extends State<CategorieCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      width: 150,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Column(
        children: [
          CircleAvatar(
            child: widget.icon,
            backgroundColor: Colors.white60,
            radius: 30,
          ),
          SizedBox(height: 6,),
          AutoSizeText(
            widget.libelle,
            textAlign: TextAlign.center,
            minFontSize: 8,
            maxLines: 2,
            style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),)
        ],
      ),
    );
  }
}
