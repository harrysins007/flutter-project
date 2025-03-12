import 'package:flutter/material.dart';
import 'chat_room_page.dart';
import 'resolution_page.dart';

class DisplayBoardPage extends StatelessWidget {
  const DisplayBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Two tabs: Chat Requests and Status
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Display Board'),
          backgroundColor: Colors.blue,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Chat Requests'),
              Tab(text: 'Status'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Chat Requests Tab
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  ChatRequestCard(
                    title: '#93042 - Panel scheduled a meeting for 10 PM',
                  ),
                  ChatRequestCard(
                    title: '#93042 - Panel scheduled a meeting for 9 PM',
                  ),
                  ChatRequestCard(
                    title: '#93042 - Panel scheduled a meeting for 6 PM',
                  ),
                ],
              ),
            ),
            // Status Tab
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  StatusCard(
                    status: 'Resolved',
                    title: '#93042 - Resolved',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResolutionPage(),
                        ),
                      );
                    },
                  ),
                  StatusCard(
                    status: 'Pending',
                    title: '#93042 - Pending',
                  ),
                  StatusCard(
                    status: 'Resolved',
                    title: '#93042 - Resolved',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResolutionPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            // Implement the File Complaint functionality
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class ChatRequestCard extends StatelessWidget {
  final String title;

  const ChatRequestCard({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 4,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(Icons.arrow_forward, color: Colors.blue),
        onTap: () {
          _showTokenDialog(context);
        },
      ),
    );
  }

  void _showTokenDialog(BuildContext context) {
    final TextEditingController tokenController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter Token Number'),
          content: TextField(
            controller: tokenController,
            decoration: const InputDecoration(hintText: 'Enter token number'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (tokenController.text == '#0000') {
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatRoomPage(),
                    ),
                  );
                } else {
                  Navigator.of(context).pop(); // Close the dialog
                  _showInvalidTokenMessage(context);
                }
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void _showInvalidTokenMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Invalid token number'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }
}

class StatusCard extends StatelessWidget {
  final String status;
  final String title;
  final VoidCallback? onTap;

  const StatusCard({Key? key, required this.status, required this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 4,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        trailing: Chip(
          label: Text(
            status,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: status == 'Resolved' ? Colors.green : Colors.orange,
        ),
        onTap: onTap,
      ),
    );
  }
}
