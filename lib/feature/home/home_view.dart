import 'package:flutter/material.dart';
import 'package:zikirmatik/feature/saved_counter/saved_counters_view.dart';
import 'package:zikirmatik/product/models/counter_database_helper.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int counter = 0;
  CounterDatabaseHelper _dbHelper = CounterDatabaseHelper();

  @override
  void initState() {
    super.initState();
    _dbHelper.initializeDatabase();
  }

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void decrementCounter() {
    setState(() {
      if (counter > 0) {
        counter--;
      }
    });
  }

  Future<void> saveCounter() async {
    CounterDatabaseHelper dbHelper = CounterDatabaseHelper();
    await dbHelper.initializeDatabase();
    await dbHelper.insertZikir(counter, DateTime.now().toString());

    // ignore: use_build_context_synchronously
    await Navigator.push(
      context,
      // ignore: inference_failure_on_instance_creation
      MaterialPageRoute(
        builder: (context) => SavedCountersView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Akıllı Zikirmatik'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Zikirmatik Tasarımı
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2.0),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                children: [
                  const Text(
                    'Akıllı Zikirmatik',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10.0),

                  // Led Ekran
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      '$counter',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Increment and Decrement Buttons
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: incrementCounter,
                        child: Text('+'),
                      ),
                      const SizedBox(width: 20.0),
                      ElevatedButton(
                        onPressed: decrementCounter,
                        child: const Text('-'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    TextEditingController titleController =
                        TextEditingController();
                    TextEditingController contentController =
                        TextEditingController();

                    await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Listeye Kaydet'),
                        content: Column(
                          children: [
                            TextField(
                              controller: titleController,
                              decoration: InputDecoration(labelText: 'İsim'),
                            ),
                          ],
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () async {
                              int insertedId = await _dbHelper.insertZikir(
                                counter,
                                titleController.text,
                              );
                              Navigator.pop(context);
                              print('Inserted Zikir ID: $insertedId');
                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                context,
                                // ignore: inference_failure_on_instance_creation
                                MaterialPageRoute(
                                  builder: (context) => SavedCountersView(),
                                ),
                              );
                            },
                            child: const Text('Kaydet'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text('Kaydet'),
                ),
                const SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      // ignore: inference_failure_on_instance_creation
                      MaterialPageRoute(
                        builder: (context) => SavedCountersView(),
                      ),
                    );
                  },
                  child: const Text('Zikirlerim'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
