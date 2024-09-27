import 'package:flutter/material.dart';

class QuizTile extends StatefulWidget {
  String title;
  String description;
  String? theme;
  QuizTile({super.key, required this.title, required this.description, this.theme});

  @override
  State<QuizTile> createState() => _QuizTileState();
}

class _QuizTileState extends State<QuizTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border:  Border.all(color: Colors.grey.shade300)),
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                    ),
                  ]),
                  child: Image.asset('assets/images/graduation-cap.jpg'),
                ),
              ],
            ),
            const SizedBox(width: 6),
            Expanded(
              child: SizedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          maxLines: 2,
                          softWrap: false,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            children: [
                              Text(
                                widget.description,
                                maxLines: 3,
                                softWrap: false,
                                style: const TextStyle(fontSize: 13,overflow: TextOverflow.ellipsis),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      child: Text(widget.theme ?? ''),
                      backgroundColor: Colors.white60,
                      radius: 30,
                    ),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
