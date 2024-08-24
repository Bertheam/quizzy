import 'package:flutter/material.dart';
import 'package:quizzy/pages/quiz/answer_quiz.dart';

class IndexQuiz extends StatefulWidget {
  const IndexQuiz({super.key});

  @override
  State<IndexQuiz> createState() => _IndexQuizState();
}

class _IndexQuizState extends State<IndexQuiz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: 10,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => AnswerQuiz()));
              },
                child: QuizTile()
            );
          },
        ),
      ),
    );
  }

  Widget QuizTile(){
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {},
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
                        ],
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
