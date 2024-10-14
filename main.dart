import 'package:flutter/material.dart';
import 'package:my_profile_card/projects_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class MyAppBar extends StatelessWidget {
  // Constructor
  const MyAppBar({required this.title, super.key});

  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple[300]!, Colors.blueAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            offset: const Offset(0, 5),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        children: [
          const IconButton(
            icon: Icon(Icons.menu),
            tooltip: 'Navigation Menu',
            onPressed: null,
          ),
          Expanded(child: Center(child: title)),
          const IconButton(
            icon: Icon(Icons.account_circle),
            tooltip: 'Hello, this is my profile card!',
            onPressed: null,
          ),
        ],
      ),
    );
  }
}

class MyScaffold extends StatelessWidget {
  // Constructor
  const MyScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          MyAppBar(
            title: const Text(
              "Sid Padmanabhan",
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 55,
                backgroundImage: AssetImage('assets/images/IMG_6666.jpg'),
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 30)),
          const Center(
            child: Text(
              "About Me",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
          ),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: Colors.blue[50],
          ),
          const SizedBox(
            height: 150.0,
            width: 500.0,
            child: Card(
              child: Center(
                child: Text(
                  "Hey! My name is Sid, and I'm currently a sophomore majoring in Computer Science and minoring in Cognitive Science at Rutgers. Some of my hobbies include playing and watching basketball, reading (nonfiction/psychology), and listening to music on long drives. I'm super excited to learn more about frontend development through Flutter with everyone this semester.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 50)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 75,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    Uri url = Uri.parse(
                        'https://www.linkedin.com/in/sid-padmanabhan-84a978289');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      throw 'Could not launch url';
                    }
                  },
                  icon: const Icon(Icons.link),
                  label: const Text("LinkedIn"),
                ),
              ),
              const SizedBox(width: 60),
              SizedBox(
                width: 200,
                height: 75,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    Uri url = Uri.parse('https://github.com/SidPadmanabhan');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      throw 'Could not launch url';
                    }
                  },
                  icon: const Icon(Icons.code),
                  label: const Text("Github"),
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 120)),
          const SizedBox(height: 16),
          Center(
            child: SizedBox(
              width: 170,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProjectScreen(projects: [
                              {
                                "title": "Project Portfolio",
                                "description":
                                    "My personal Flutter portfolio, with all my Flutter Projects.",
                                "isPinned": false,
                              },
                              {
                                "title": "NBA Stat Cruncher",
                                "description":
                                    "Calculates the top 10 NBA players in the league.",
                                "isPinned": false,
                              },
                              {
                                "title": "Election Analysis",
                                "description":
                                    "Reads from CSV files to obtain real-time election results in a visual display.",
                                "isPinned": false,
                              }
                            ])),
                  );
                },
                child: const Text("Projects"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    title: "My App",
    debugShowCheckedModeBanner: false,
    home: SafeArea(child: MyScaffold()),
  ));
}
