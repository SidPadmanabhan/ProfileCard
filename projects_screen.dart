import 'package:flutter/material.dart';
import 'package:my_profile_card/add_projects_form.dart';

class ProjectScreen extends StatefulWidget {
  final List<Map<String, dynamic>> projects;

  const ProjectScreen({super.key, required this.projects});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  late List<Map<String, dynamic>> _projects;

  @override
  void initState() {
    super.initState();

    _projects = widget.projects
        .map((project) => Map<String, dynamic>.from(project))
        .toList();
    sortProjectsList();
  }

  void _addProject() async {
    final newProject = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddProjectForm()),
    );

    if (newProject != null) {
      setState(() {
        _projects.add({
          'title': newProject['title'] ?? 'No Title',
          'description': newProject['description'] ?? 'No Description',
          'isPinned': newProject['isPinned'] ?? false,
        });
        sortProjectsList();
      });
    }
  }

  void _editProject(int index) async {
    final editedProject = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddProjectForm(
          initialTitle: _projects[index]['title'],
          initialDescription: _projects[index]['description'],
        ),
      ),
    );

    if (editedProject != null) {
      setState(() {
        _projects[index] = {
          'title': editedProject['title'] ?? 'No Title',
          'description': editedProject['description'] ?? 'No Description',
          'isPinned': _projects[index]['isPinned'],
        };
        sortProjectsList();
      });
    }
  }

  void _deleteProject(int index) {
    setState(() {
      _projects.removeAt(index);
    });
  }

  void _togglePinProject(int index) {
    setState(() {
      _projects[index]['isPinned'] = !(_projects[index]['isPinned'] ?? false);
      sortProjectsList();
    });
  }

  void sortProjectsList() {
    _projects.sort(
        (a, b) => b['isPinned'].toString().compareTo(a['isPinned'].toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
      ),
      body: ListView.builder(
        itemCount: _projects.length,
        itemBuilder: (context, index) {
          final project = _projects[index];
          return ListTile(
            title: Text(
              project['title'] ?? 'No Title',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              project['description'] ?? 'No Description',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    project['isPinned'] == true
                        ? Icons.push_pin
                        : Icons.push_pin_outlined,
                  ),
                  onPressed: () => _togglePinProject(index),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _editProject(index),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteProject(index),
                ),
              ],
            ),
            onTap: () => _editProject(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProject,
        child: const Icon(Icons.add),
      ),
    );
  }
}
