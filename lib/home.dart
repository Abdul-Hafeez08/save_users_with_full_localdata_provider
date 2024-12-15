import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_provider/second_screen.dart';
import 'package:state_provider/user_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _nameController = TextEditingController();

  final List<TextEditingController> _sizeControllers =
      List.generate(8, (_) => TextEditingController());
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final userDataProvider =
          Provider.of<UserDataProvider>(context, listen: false);
      await userDataProvider.loadData(); // Load data on app start
    });
  }

  @override
  void dispose() {
    _nameController.dispose();

    for (var controller in _sizeControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserDataProvider>(
      builder: (context, userDataProvider, child) => Scaffold(
        // bottomNavigationBar: Row(
        //   children: [
        //     ElevatedButton(onPressed: () {}, child: Text("data")),
        //     ElevatedButton(onPressed: () {}, child: Text("data")),
        //   ],
        // ),
        appBar: AppBar(
          title: const Text(
            "Provider",
            textAlign: TextAlign.center,
          ),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                ),

                // Adding custom hints for each size field
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _sizeControllers[0],
                    decoration: const InputDecoration(labelText: 'NIC'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _sizeControllers[1],
                    decoration: const InputDecoration(labelText: 'Gender'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _sizeControllers[2],
                    decoration: const InputDecoration(labelText: 'Age'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _sizeControllers[3],
                    decoration: const InputDecoration(labelText: 'NIC'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _sizeControllers[4],
                    decoration:
                        const InputDecoration(labelText: 'Phone Number'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _sizeControllers[5],
                    decoration:
                        const InputDecoration(labelText: 'Current Address'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _sizeControllers[6],
                    decoration:
                        const InputDecoration(labelText: 'Permanent Address'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _sizeControllers[7],
                    decoration:
                        const InputDecoration(labelText: 'Relation Status'),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (_nameController.text.isNotEmpty &&
                            _sizeControllers.every(
                                (controller) => controller.text.isNotEmpty)) {
                          await userDataProvider.addUser(
                            _nameController.text,
                            _sizeControllers[0].text,
                            _sizeControllers[1].text,
                            _sizeControllers[2].text,
                            _sizeControllers[3].text,
                            _sizeControllers[4].text,
                            _sizeControllers[5].text,
                            _sizeControllers[6].text,
                            _sizeControllers[7].text,
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Data Saved Successfully!"),
                          ));
                          _nameController.clear();
                          for (var controller in _sizeControllers) {
                            controller.clear();
                          }
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Please Fill in Both Fields!"),
                          ));
                        }
                      },
                      child: const Text("Save"),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Second()));
                        },
                        child: const Text("Saved Data")),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
