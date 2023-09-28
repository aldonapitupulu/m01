import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class contoh2 extends StatefulWidget {
  const contoh2({super.key});

  @override
  State<contoh2> createState() => _contoh2State();
}

class _contoh2State extends State<contoh2> {
  bool isReset = false;
  bool isPlay = false;
  bool isPaused = false;
  bool isSubscribed = false;
  String desc = "";
  int percent = 100;
  int getSteam = 0;
  double circular = 1;
  late StreamSubscription _sub;
  final Stream _myStream =
      Stream.periodic(const Duration(seconds: 1), (int count) {
    return count;
  });

  String isFull(inp) {
    if (inp == 100) {
      desc = "\nFull";
    } else if (inp == 0) {
      desc = "\nEmpty";
    } else {
      desc = "";
    }
    return desc;
  }

  @override
  void dispose() {
    _sub.cancel(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stream"),
      ),
      body: Center(
        child: LayoutBuilder(builder: (context, constraints) {
          final double avaWidth = constraints.maxWidth;
          final double avaHeight = constraints.maxHeight;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: CircularPercentIndicator(
                  header: Text(isFull(percent)),
                  radius: avaHeight / 5,
                  lineWidth: 8,
                  percent: circular,
                  center: Text("$percent%"),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        percent = 100;
                        circular = percent / 100;
                        isPaused = true;
                        print(isPaused);
                      });
                    },
                    child: Icon(Icons.restore_rounded),
                  ),
                  SizedBox(width: 16), // Spasi antara tombol "reset" dan "play"
                  FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        isPlay = !isPlay;
                        print(isPaused);
                      });

                      if (isPlay) {
                        if (!isSubscribed) {
                          isSubscribed = true;
                          _sub = _myStream.listen((event) {
                            getSteam = int.parse(event.toString());
                            setState(() {
                              if (percent - getSteam <= 0) {
                                isSubscribed = false;
                                percent = 0;
                                circular = 0;
                              } else {
                                percent = percent - getSteam;
                                circular = percent / 100;
                              }
                            });
                          });
                        } else {
                          isPaused = true;
                          _sub.resume();
                        }
                      } else {
                        isPaused = false;
                        _sub.pause();
                      }
                    },
                    child: !isPlay ? Icon(Icons.play_arrow) : Icon(Icons.pause),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}