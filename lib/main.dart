import 'package:flutter/material.dart';
import 'package:quizzler/quizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueGrey[700],
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> score = [];
  checkAns(bool userAnswer) {
    bool correctAnswer = quizBrain.getQuestionAnswer();
    quizBrain.isFinished();
    setState(() {
      if (quizBrain.isFinished()) {
        Alert(
                context: context,
                title: "Congratulation",
                desc: "you ended the quiz.")
            .show();
        quizBrain.reset();
        score.clear();
      } else {
        if (userAnswer == correctAnswer) {
          score.add(Icon(
            Icons.check,
            color: Colors.greenAccent,
          ));
          print('right');
        } else {
          score.add(Icon(
            Icons.close,
            color: Colors.redAccent,
          ));
          print('wrong');
        }
      }
      quizBrain.nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.red[900],
              color: Colors.greenAccent[100],
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.blueGrey[900],
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAns(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.redAccent[100],
              child: Text(
                'False',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.blueGrey[900],
                ),
              ),
              onPressed: () {
                checkAns(false);
              },
            ),
          ),
        ),
        Row(
          children: score,
        ),
      ],
    );
  }
}
