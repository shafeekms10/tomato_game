import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TomatoGamePage extends StatefulWidget {
  final int score;
  final Function(int) onScoreUpdated;

  const TomatoGamePage({super.key, required this.score, required this.onScoreUpdated});

  @override
  _TomatoGamePageState createState() => _TomatoGamePageState();
}

class _TomatoGamePageState extends State<TomatoGamePage> {
  String questionImageUrl = '';
  int solution = 0;
  String answer = '';
  int chancesLeft = 3;

  Future<void> fetchTomatoGame() async {
    final baseUrl = Uri.parse('http://marcconrad.com/uob/tomato/api.php');
    final response = await http.get(Uri.parse('$baseUrl?out=json&base64=no'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        questionImageUrl = jsonData['question'];
        solution = jsonData['solution'];
      });
    } else {
      throw Exception('Failed to load tomato game');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchTomatoGame();
  }

  void checkAnswer() {
    if (int.parse(answer) == solution) {
      // Update score if the answer is correct
      widget.onScoreUpdated(widget.score + 1);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Correct!'),
            content: const Text('You have solved the puzzle!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  fetchTomatoGame();
                },
                child: const Text('Next Puzzle'),
              ),
            ],
          );
        },
      );
    } else {
      // Decrease chances left and show lifeline buttons
      setState(() {
        chancesLeft--;
      });
      if (chancesLeft == 0) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Game Over!'),
              content: const Text('You have used all your chances.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context); // Close the TomatoGamePage
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tomato Mystery Challenge', style: TextStyle(fontSize: 20)),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 30), // Add some spacing (20 pixels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Score: ${widget.score}', style: const TextStyle(fontSize: 20)),
              Row(
                children: [
                  const Text('Chances Left:', style: TextStyle(fontSize: 20)),
                  const SizedBox(width: 10),
                  Row(
                    children: List.generate(
                      chancesLeft,
                      (index) => const Icon(Icons.favorite, color: Colors.red),
                    ),
                  ),
                ],
              ),
              // Display the number of chances left as heart icons [❤️
            ]
          ),
          const SizedBox(height: 30),
          questionImageUrl.isNotEmpty
              ? Image.network(
            questionImageUrl,
            width: debugCheckHasMediaQuery(context)
                ? MediaQuery
                .of(context)
                .size
                .width * 0.9
                : 200,
            height: debugCheckHasMediaQuery(context)
                ? MediaQuery
                .of(context)
                .size
                .height * 0.3
                : 200,
          )
              : const CircularProgressIndicator(),
          const SizedBox(height: 20), // Add a label 'Solution:
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Enter the Solution:',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 80,
                  child: TextField(
                    style: const TextStyle(fontSize: 20),
                    onChanged: (value) {
                      setState(() {
                        answer = value;
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          if (answer.isNotEmpty)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(239, 118, 73, 1),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                checkAnswer();
              },
              child: const Text('Submit'),
            ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}