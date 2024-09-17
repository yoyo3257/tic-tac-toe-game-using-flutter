import 'package:flutter/material.dart';
import 'package:tic_tac_game/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  bool oTurn = true;
  List<String> displayXO = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];
  List<int> winnerIndex = [];
  String result = '';
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;
  bool winnerFound = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColors().mintGreen,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Player🔻',
                            style: GoogleFonts.indieFlower(
                                color: MainColors().whitePage,
                                fontSize: 38,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            oScore.toString(),
                            style: GoogleFonts.indieFlower(
                                color: Colors.black,
                                fontSize: 50,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Text(
                            'Player 🍉',
                            style: GoogleFonts.indieFlower(
                                color: MainColors().whitePage,
                                fontSize: 38,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            xScore.toString(),
                            style: GoogleFonts.indieFlower(
                                color: Colors.black,
                                fontSize: 50,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        _pressed(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                width: 5, color: MainColors().mintGreen),
                            color: winnerIndex.contains(index)
                                ? MainColors().red
                                : MainColors().whiteRed),
                        child: Center(
                          child: Text(
                            displayXO[index],
                            style: GoogleFonts.indieFlower(
                              color: MainColors().red,
                              fontSize: 70,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      result,
                      style: GoogleFonts.indieFlower(
                          color: MainColors().whitePage,
                          fontSize: 50,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            _clear();
                          },
                          icon: Icon(
                             Icons.refresh_sharp,
                            color: MainColors().whitePage,
                            size: 80,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        IconButton(
                          onPressed: () {
                            _clearAll();
                          },
                          icon: Icon(
                            Icons.play_arrow,
                            color: MainColors().whitePage,
                            size: 80,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pressed(int index) {
    setState(() {
      if (oTurn && displayXO[index] == '') {
        displayXO[index] = '🔻';
        filledBoxes++;
      } else if (!oTurn && displayXO[index] == '') {
        displayXO[index] = '🍉';
        filledBoxes++;
      }
      oTurn = !oTurn;
      checkWinner();
    });
  }

  void checkWinner() {
    // 1st row
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != '') {
      setState(() {
        result = 'Player ${displayXO[0]} Win';
      });
      _updateScore(displayXO[0]);
      winnerIndex.addAll([0, 1, 2]);
    }
    // 2nd row
    if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != '') {
      setState(() {
        result = 'Player ${displayXO[3]} Win';
      });
      _updateScore(displayXO[3]);
      winnerIndex.addAll([3, 4, 5]);
    }
    // 3rd row
    if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != '') {
      setState(() {
        result = 'Player ${displayXO[6]} Win';
      });
      _updateScore(displayXO[6]);
      winnerIndex.addAll([6, 7, 8]);
    }
    // 1st column
    if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != '') {
      setState(() {
        result = 'Player ${displayXO[0]} Win';
      });
      _updateScore(displayXO[0]);
      winnerIndex.addAll([0, 3, 6]);
    }
    // 2nd column
    if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != '') {
      setState(() {
        result = 'Player ${displayXO[1]} Win';
      });
      _updateScore(displayXO[1]);
      winnerIndex.addAll([1, 4, 7]);
    }
    // 3rd column
    if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != '') {
      setState(() {
        result = 'Player ${displayXO[2]} Win';
      });
      _updateScore(displayXO[2]);
      winnerIndex.addAll([5, 8, 2]);
    }
    // 1st diagonal
    if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != '') {
      setState(() {
        result = 'Player ${displayXO[0]} Win';
      });
      _updateScore(displayXO[0]);
      winnerIndex.addAll([0, 4, 8]);
    }
    // 2nd diagonal
    if (displayXO[6] == displayXO[4] &&
        displayXO[6] == displayXO[2] &&
        displayXO[6] != '') {
      setState(() {
        result = 'Player ${displayXO[6]} Win';
      });
      _updateScore(displayXO[6]);
      winnerIndex.addAll([4, 6, 2]);
    }
    if (!winnerFound && filledBoxes == 9) {
      setState(() {
        result = 'Nobody wins';
      });
    }
  }

  void _updateScore(String winner) {
    if (winner == '🔻') {
      oScore++;
    } else if (winner == '🍉') {
      xScore++;
    }
    winnerFound = true;
  }

  void _clear() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayXO[i] = '';
      }
      result = '';
    });
    filledBoxes = 0;
    winnerIndex = [];
  }

  void _clearAll() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayXO[i] = '';
      }
      result = '';
    });
    filledBoxes = 0;
    winnerIndex = [];
    oScore = 0;
    xScore = 0;
  }
}
