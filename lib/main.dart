import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(
      MaterialApp(
        home: BallPage(),
      ),
    );

class BallPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text('Ask Me Anything'),
      ),
      body: Ball(),
    );
  }
}

class Ball extends StatefulWidget {
  @override
  _BallState createState() => _BallState();
}

class _BallState extends State<Ball> {
  List<String> ballMap = [
    'YES',
    'NO',
    'ASK\nAGAIN\nLATER',
    'THE\nANSWER\nIS YES',
    'I HAVE\nNO IDEA'
  ];

  String ballAnswer = '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlatButton(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Image.asset('images/ball.png'),
            Text(
              ballAnswer,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Fresca',
                fontSize: 16.0,
                color: Colors.blue.shade200,
                letterSpacing: 2.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        onPressed: () {
          getTextFromBall();
        },
      ),
    );
  }

  void getTextFromBall() {
    setState(() {
      ballAnswer = '${ballMap[Random().nextInt(5)]}\n';
    });
  }
}
