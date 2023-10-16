import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'game_btn.dart';
import 'custom_dilogue.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<GameBtn> buttonlist;
  var player1;
  var player2;
  var activePlayer;

  void resetGame() {
    setState(() {
      buttonlist = doInit();
      player1.clear();
      player2.clear();
      activePlayer = 1;
    });
  }

  List<GameBtn> doInit(){
    player1 = [];
    player2 = [];

    var gameButtons = <GameBtn>[
      GameBtn(id: 1),
      GameBtn(id: 2),
      GameBtn(id: 3),
      GameBtn(id: 4),
      GameBtn(id: 5),
      GameBtn(id: 6),
      GameBtn(id: 7),
      GameBtn(id: 8),
      GameBtn(id: 9),
    ];
    return gameButtons;
  }
  // things that will happen after pressing btn
  void playGame(GameBtn gb){
    print("Playing game for button ${gb.id}");
    setState(() {
      if(activePlayer == 1){
        gb.text = "X";
        gb.bg = Colors.blue;
        activePlayer = 2;
        player1.add(gb.id);
      }
      else{
        gb.text = "O";
        gb.bg = Colors.black;
        activePlayer = 1;
        player2.add(gb.id);
      }
      gb.enabled = false;

      void resetGame() {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
          setState(() {
            buttonlist = doInit();
          });
        }
      }

      int checkWinner(){
        var winner = -1;

        // for row
        for(int row = 0; row < 3 ; row++){

          if(player1.contains(row * 3 + 1) && player1.contains(row * 3 + 2) && player1.contains(row * 3 + 3)){
            winner = 1;
          }
          if(player2.contains(row * 3 + 1) && player2.contains(row * 3 + 2) && player2.contains(row * 3 + 3)){
            winner = 1;
          }
        }

        // for columns
        for(int col = 0; col < 3 ; col++){

          if(player1.contains(col + 1) && player1.contains(col + 4) && player1.contains(col + 7)){
            winner = 1;
          }
          if(player2.contains(col + 1) && player2.contains(col + 4) && player2.contains(col + 7)){
            winner = 1;
          }
        }

      //  for diagonals
        if (player1.contains(1) && player1.contains(5) && player1.contains(9)) {
          // Player 1 wins
          winner = 1;
        }
        if (player2.contains(1) && player2.contains(5) && player2.contains(9)) {
          // Player 2 wins
          winner = 1;
        }

        // Check secondary diagonal (top-right to bottom-left)
        if (player1.contains(3) && player1.contains(5) && player1.contains(7)) {
          // Player 1 wins
          winner = 1;
        }
        if (player2.contains(3) && player2.contains(5) && player2.contains(7)) {
          // Player 2 wins
          winner = 1;
        }


        if (winner != -1){
          if(winner == 1){
              showDialog(context: context, builder: (_)=>CustomDilogue("Player 1 won","Please press the reset button to start",resetGame));
          }
          else{
            showDialog(context: context, builder: (_)=>CustomDilogue("Player 2 won","Please press the reset button to start",resetGame));
          }
        }
        return winner;
      }
      var winner = checkWinner();

      if(winner == -1){
        if(buttonlist.every((p) => p.text != "")){
          showDialog(context: context, builder: (_)=>CustomDilogue("Tie Game","Please press the reset button to start",resetGame));
        }
      }

    });
  }

  @override
  void initState() {
    super.initState();
    activePlayer = 1;
    buttonlist = doInit();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tic Tac Toe",
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin:Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.pinkAccent,Colors.tealAccent],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 120),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                crossAxisSpacing: 6,
                mainAxisSpacing: 9,
              ),
              itemCount: buttonlist.length,
              itemBuilder: (context,index)=> SizedBox(
                width: 100,
                height: 100,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: ElevatedButton(
                    child: Text(
                      buttonlist[index].text,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonlist[index].bg,
                      disabledBackgroundColor: buttonlist[index].bg,
                    ),
                    onPressed: buttonlist[index].enabled?() => playGame(
                        buttonlist[index]
                    ):null,
                  ),
                ),
              ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: resetGame,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
