import 'package:flutter/material.dart';

class QuizTile extends StatefulWidget {
  const QuizTile({super.key});

  @override
  State<QuizTile> createState() => _QuizTileState();
}

class _QuizTileState extends State<QuizTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: 157,
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
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ],
              ),
              const SizedBox(width: 6),
              Expanded(
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'titre',
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
                              'description',
                              maxLines: 3,
                              softWrap: false,
                              style: const TextStyle(fontSize: 13,overflow: TextOverflow.ellipsis),
                            )
                          ],
                        ),
                      ),
                      CircleAvatar(
                        child: Icon(Icons.check,color: Colors.green),
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
      ),
    );
  }
}
