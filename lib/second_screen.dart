import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_provider/user_list.dart';

class Second extends StatefulWidget {
  const Second({super.key});

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  @override
  void initState() {
    super.initState();
    // Load data from local storage when the screen is first opened
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final userDataProvider =
          Provider.of<UserDataProvider>(context, listen: false);
      await userDataProvider.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserDataProvider>(
      builder: (context, userDataProvider, child) => Scaffold(
        appBar: AppBar(
          title: const Text(
            "Saved Users",
            textAlign: TextAlign.center,
          ),
        ),
        body: userDataProvider.userList.isEmpty
            ? const Center(
                child: Text("No User Added yet."),
              )
            : ListView.builder(
                itemCount: userDataProvider.userList.length,
                itemBuilder: (context, index) {
                  final user = userDataProvider.userList[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        user['name']![0].toUpperCase(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    title: Text(
                      user['name'] ?? '',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(user['size1'] ?? ''),
                    trailing: IconButton(
                        onPressed: () async {
                          await userDataProvider.deleteUser(index);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Color.fromARGB(255, 255, 103, 93),
                        )),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserDetailScreen(
                            user: user,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}

class UserDetailScreen extends StatelessWidget {
  final Map<String, String> user;
  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    // Map of custom labels for keys
    final Map<String, String> keyLabels = {
      'name': 'Name',
      'size1': 'Hight',
      'size2': 'Tero',
      'size3': 'Arm',
      'size4': 'Neck',
      'size5': 'Width',
      'size6': 'Kuf',
      'size7': 'Salwar',
      'size8': 'Pacho',
    };
    return Scaffold(
      appBar: AppBar(title: const Text("User Measurments")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: user.entries.map((entry) {
            final label = keyLabels[entry.key] ?? entry.key;
            return ListTile(
              title: Text("$label: ${entry.value}"),
            );
          }).toList(),
        ),
      ),
    );
  }
}
