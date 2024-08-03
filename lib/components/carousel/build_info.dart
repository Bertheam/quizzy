import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:quizzy/models/quiz.dart';

import '../../global/variable.dart';
import 'build_indicator.dart';

class BuildInfo extends StatefulWidget {
  const BuildInfo({super.key});

  @override
  State<BuildInfo> createState() => _BuildInfoState();
}

class _BuildInfoState extends State<BuildInfo> {
  int activeIndex = 0;
  List<Quiz> quizzes = [];
  int page = 0;
  bool hasMore = true;
  bool isLoading = false;
  final Variable variable = Variable();

  Future refresh() async {
    await Future.delayed(const Duration(seconds: 5));
  }


  // Future<List<Quiz>> getQuizzes() async {
  //   try {
  //     if (isLoading) {
  //       return [];
  //     }
  //     isLoading = true;
  //
  //     const limit = 3;
  //
  //     Response res =
  //         await get(Uri.parse("${variable.apiUrl}/quiz?page=$page"));
  //
  //     if (res.statusCode == 200) {
  //       List<dynamic> body = jsonDecode(res.body);
  //
  //       List<Quiz> myQuizs = body
  //           .map(
  //             (dynamic item) => Quiz.fromJson(item),
  //           )
  //           .toList();
  //
  //       setState(() {
  //         page++;
  //         isLoading = false;
  //         quizzes.addAll(body
  //             .map(
  //               (dynamic item) => Quiz.fromJson(item),
  //             )
  //             .toList());
  //
  //         if (myQuizs.length < limit) {
  //           hasMore = false;
  //         }
  //       });
  //       return quizzes;
  //     } else {
  //       throw " ++++++++++++++++++++++++++ Unable to retrieve actualites.";
  //     }
  //   } on Exception {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   } catch (error) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  //   return [];
  // }

  @override
  void initState() {
    // getQuizzes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (quizzes.isNotEmpty) {
      return Column(
        children: [
          CarouselSlider.builder(
            itemCount: quizzes.length,
            itemBuilder: (context, index, realIndex) {
              Quiz quiz = quizzes[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 650,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 63, 160, 217),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: SizedBox(
                                    width: 250,
                                    child: Text(
                                      quiz.nom,
                                      maxLines: 3,
                                      softWrap: false,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.fade),
                                    ),
                                  ),
                                ),
                                Icon(Icons.format_quote_rounded,color: const Color.fromARGB(255, 63, 160, 217),size: 27,)
                                // CircleAvatar(
                                //   backgroundColor: const Color.fromARGB(255, 63, 160, 217),
                                //   child: Image.asset("assets/quiz-logo.png",fit: BoxFit.cover,),
                                // ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 3.0, right: 3.0, bottom: 3.0),
                            child: SizedBox(
                              width: 300,
                              child: Text(quiz.description,
                                  softWrap: false,
                                  maxLines: 4,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      overflow: TextOverflow.ellipsis)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            options: CarouselOptions(
                height: 150,
                onPageChanged: (index, reason) {
                  setState(() {
                    activeIndex = index;
                  });
                },
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800)),
          ),
          const SizedBox(height: 12),
          Center(
              child: BuildIndicator(length: quizzes.length, index: activeIndex)),
        ],
      );
    }else{
      return isLoading ? CircularProgressIndicator(
          color: const Color.fromARGB(255, 63, 160, 217),backgroundColor: Colors.grey.shade200) : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 19.0),
        child: GestureDetector(
          onTap: () {},
          child: Container(
            width: 650,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 83,158,216),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.red.shade300,
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: Text(
                          'Récent quiz',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 3.0, right: 3.0, bottom: 3.0),
                        child: SizedBox(
                          child: Column(
                            children: [
                            Text(
                            'Récent quiz',
                            maxLines: 3,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.fade)
                            ),
                            Text(
                            'Informatique • 5 quiz',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                overflow: TextOverflow.fade)
                            ),
                          ],),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(child: Image.asset('assets/images/carousel_img.jpg'),width: 100),
                )
              ],
            ),
          ),
        ),
      ) ;
    }

  }
}
