import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const TowerOfHanoiGame());
}

class TowerOfHanoiGame extends StatefulWidget {
  const TowerOfHanoiGame({super.key});

  @override
  State<TowerOfHanoiGame> createState() => _TowerOfHanoiGameState();
}

class _TowerOfHanoiGameState extends State<TowerOfHanoiGame> {
  late List<List<int>> towers;
  int moveCount = 0;
  int delayTime = 100;
  int disksNO = 3;
  int disksC = 0;

  Future<void> moveDisk(int from, int to) async {
    await Future.delayed(Duration(milliseconds: delayTime));
    setState(() {
      towers[to].add(towers[from].removeLast());
      moveCount++;
    });
  }

  Future<void> solveHanoi(int n, int from, int to, int aux) async {
    if (n == 1) {
      await moveDisk(from, to);
      return;
    }
    await solveHanoi(n - 1, from, aux, to);
    await moveDisk(from, to);
    await solveHanoi(n - 1, aux, to, from);
  }

  bool gameInProgress = false;

  void start() {
    if (gameInProgress) return;

    disksC = disksNO;

    for (int i = 0; i < 3; i++) {
      towers[i].clear();
    }

    for (int i = disksNO; i > 0; i--) {
      towers[0].add(i);
    }

    setState(() {
      moveCount = 0;
      gameInProgress = true;
    });

    solveHanoi(disksNO, 0, 2, 1).then((_) {
      setState(() {
        gameInProgress = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    towers = List.generate(3, (index) => []);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: ListView(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              const Text(
                "Tower Of Hanoi",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = 0; i < 3; i++) Tower(towers[i], disksC),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Moves: $moveCount',
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 60,
                    child: Text(
                    "Discs",
                    style: TextStyle(color: Colors.white,fontSize: 20),
                                    ),
                  ),
                  Container(
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.blue,
                          Colors.indigo, // Second color
                        ],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(
                            CupertinoIcons.plus,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            if (disksNO != 10) {
                              setState(() {
                                disksNO++;
                              });
                            }
                          },
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: SizedBox(
                                width: 40,
                                child: Text(
                                  '$disksNO',
                                  style:
                                      const TextStyle(color: Colors.white, fontSize: 20),
                                  textAlign: TextAlign.center,
                                )),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            CupertinoIcons.minus,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            if (disksNO != 0) {
                              setState(() {
                                disksNO--;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 60,)
                ],
              ),
              const SizedBox(
                height: 5,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 60,
                    child: Text(
                    "Delay",
                    style: TextStyle(color: Colors.white,fontSize: 20),
                                    ),
                  ),
                  Container(
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      //color: Colors.blue,
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.blue,
                          Colors.indigo, // Second color
                        ],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(
                            CupertinoIcons.plus,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            if (delayTime != 1000) {
                              setState(() {
                                if (delayTime < 100) {
                                  delayTime += 50;
                                } else {
                                  delayTime += 100;
                                }
                              });
                            }
                          },
                        ),
                        Container(
                            width: 50,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child: Text(
                                '$delayTime',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 17),
                                textAlign: TextAlign.center,
                              ),
                            )),
                        IconButton(
                          icon: const Icon(CupertinoIcons.minus,
                              color: Colors.white, size: 30),
                          onPressed: () {
                            if (delayTime != 0) {
                              setState(() {
                                if (delayTime <= 100) {
                                  delayTime -= 50;
                                } else {
                                  delayTime -= 100;
                                }
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    width: 60,
                    child: IconButton(onPressed: (){setState(() {
                      delayTime=0;
                    }); }, icon: const Icon(Icons.fast_forward,color: Colors.white,size: 30,)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                  gradient: gameInProgress ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.grey,Colors.blueGrey], // Example colors
                  ): const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.blue, Colors.indigo], // Example colors
                  ),
                  borderRadius: BorderRadius.circular(25), // Optional: rounded corners
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent, // This makes the button transparent
                    shadowColor: Colors.transparent, // This hides the button's shadow
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25), // Optional: rounded corners
                    ),
                  ),
                  onPressed: start,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Start',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

class Tower extends StatelessWidget {
  final List<int> discs;
  final int disksNO;

  const Tower(this.discs, this.disksNO, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 310,
      
      decoration: BoxDecoration(
        //color: Colors.blue,
        borderRadius: BorderRadius.circular(5),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue, // First color
            Colors.indigo, // Second color
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: discs.reversed.map((size) {
          return Disk(size, disksNO);
        }).toList(),
      ),
    );
  }
}

class Disk extends StatelessWidget {
  final int size;
  final int disksNO;

  const Disk(this.size, this.disksNO, {super.key});

  Color _getColor(int size) {
    switch (size) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.yellow;
      case 4:
        return Colors.green;
      case 5:
        return Colors.lightBlueAccent;
      case 6:
        return Colors.purple;
      case 7:
        return Colors.purpleAccent;
      case 8:
        return Colors.pinkAccent;
      case 9:
        return Colors.teal;
      default:
        return Colors.tealAccent;
    }
  }

  double _getSize(int size, int len) {
    return (10 + size * 20) / (len / 5);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _getSize(size, disksNO),
      height: 20,
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        color: _getColor(size),
        borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
      ),
    );
  }
}
