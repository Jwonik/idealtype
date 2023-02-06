import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'question_page.dart';
import 'package:idealtype/question_page.dart';

class LandingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final args= ModalRoute.of(context)!.settings.arguments;
    return  Material(
      color: Colors.green[400],
      child:  InkWell(
        onTap: () {
          Get.off(()=>QuestionPage(),arguments: args.toString());
        },
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  <Widget>[
            Text(
              args.toString()+" 월드컵",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              "시작",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
