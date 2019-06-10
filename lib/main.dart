import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:aeyrium_sensor/aeyrium_sensor.dart';

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

  int lastValue = 0;
  bool change = false;

  StreamSubscription<dynamic> _streamSubscriptions;

  @override
  void initState() {
    _streamSubscriptions = AeyriumSensor.sensorEvents.listen((event) {
      int value = ((event.pitch + event.roll) * 100).round();

      if (lastValue == value && change) {
        changeAnswerBall();
        change = false;

        print('lastValue == value && $change');
      }

      if ((lastValue - value).abs() > 50) {
        lastValue = value;
        change = true;

        print('(lastValue - value).abs() > 50 && $change');
      }
    });

    super.initState();
  }

  void changeAnswerBall() {
    setState(() {
      ballAnswer = '${ballMap[Random().nextInt(5)]}\n';
    });
  }

  @override
  void dispose() {
    if (_streamSubscriptions != null) {
      _streamSubscriptions.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
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
    );
  }
}
