import 'package:flutter/material.dart';
import 'package:tomato_game/Screens/sidemenu.dart';
import 'package:tomato_game/Screens/game.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int score = 0; // Initialize user's score

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tomato Mystery Challenge', style: TextStyle(fontSize: 20)),
      ),
      drawer: const SideMenu(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromRGBO(239, 118, 73, 0.6), Color.fromRGBO(239, 118, 73, 0.4)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Scrollable box with border for game guidelines
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.all(10),
                  child: const Scrollbar(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Game Guidelines',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '❗ Objective: Find the hidden number within the tomato.',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '❗ Levels:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('🍅 There are 3 levels in the game.'),
                          Text('🍅 Each level presents increasing difficulty.'),
                          Text('🍅 Progress to the next level by correctly answering a certain number of questions:'),
                          Text('   💪🏻 Level 1: Answer 6 questions to advance.'),
                          Text('   💪🏻💪🏻 Level 2: Answer 12 questions to advance.'),
                          Text('   💪🏻💪🏻💪🏻 Level 3: Complete the game.'),
                          SizedBox(height: 10),
                          Text(
                            '❗ Time Limit:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('🍅 Level 1: 1 minute per question.'),
                          Text('🍅 Level 2: 30 seconds per question.'),
                          Text('🍅 Level 3: 15 seconds per question.'),
                          SizedBox(height: 10),
                          Text(
                            '❗ Chances:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('🍅 Each player has 3 chances throughout the game.'),
                          Text('🍅 Wrong answers decrease chances.'),
                          Text('🍅 If a player exhausts all 3 chances, the game ends.'),
                          SizedBox(height: 10),
                          Text(
                            '❗ Lifelines:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('🍅 Represented by heart icons.'),
                          Text('🍅 Decreases when the player inputs a wrong answer.'),
                          SizedBox(height: 10),
                          Text(
                            '❗ Options:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('🍅 Pause: Pause the game.'),
                          Text('🍅 Continue: Resume the game after pausing.'),
                          Text('🍅 Score History: View the history of scores.'),
                          Text('🍅 Exit: Exit the game.'),
                          SizedBox(height: 10),
                          Text(
                            '❗ Score History:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('🍅 View the history of scores achieved in previous games.'),
                          Text('🍅 Provides insights into performance and progress.'),
                          SizedBox(height: 10),
                          Text(
                            '❗ Exit Option:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('🍅 Allows players to exit the game at any time.'),
                          Text('🍅 Ensure all progress is saved before exiting.'),
                          SizedBox(height: 10),
                          Text(
                            '❗ Pause and Continue:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('🍅 Use the "Pause" option to temporarily stop the game.'),
                          Text('🍅 Use the "Continue" option to resume playing from where it was paused.'),
                          SizedBox(height: 10),
                          Text(
                            '❤️ Enjoy the Game:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('Have fun exploring each level and challenging yourself to find the hidden numbers within the tomatoes.'),
                          Text('Test your skills, improve your speed, and aim for the highest score!'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(239, 118, 73, 1),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TomatoGamePage(
                      score: score,
                      onScoreUpdated: (newScore) {
                        setState(() {
                          score = newScore;
                        });
                      },
                    )),
                  );
                },
                child: const Text('Start Game'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
