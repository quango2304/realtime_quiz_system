import 'package:flutter/material.dart';

class WaitingScreen extends StatelessWidget {
  final List<String> playerList;
  const WaitingScreen({
    super.key, required this.playerList,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Waiting for quiz to start...',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent),
            ),
            const SizedBox(height: 20),
            if (playerList.isNotEmpty) ...[
              const Text(
                'Players joined:',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              const SizedBox(height: 10),
              ...playerList.map((player) => Card(
                margin: const EdgeInsets.symmetric(
                    vertical: 8, horizontal: 16),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.person,
                              color: Colors.blueAccent),
                          const SizedBox(width: 10),
                          Text(
                            player,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const Icon(Icons.check_circle,
                          color: Colors.green),
                      // Optional: Indicates the player is active
                    ],
                  ),
                ),
              )),
            ],
          ],
        ));
  }
}
