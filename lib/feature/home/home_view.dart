import 'package:flutter/material.dart';
import 'package:zikirmatik/feature/saved_counter/saved_counters_view.dart';
import 'package:zikirmatik/product/models/counter_database_helper.dart';

class HomeView extends StatefulWidget {
  @override
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

  void saveCounter() async {
    CounterDatabaseHelper dbHelper = CounterDatabaseHelper();
    await dbHelper.initializeDatabase(); // Veritabanını başlatmayı unutmayın
    await dbHelper.insertZikir(counter);

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
        title: Text('Akıllı Zikirmatik'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Zikirmatik Tasarımı
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2.0),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                children: [
                  Text(
                    'Akıllı Zikirmatik',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),

                  // Led Ekran
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      '$counter',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Increment and Decrement Buttons
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: incrementCounter,
                        child: Text('+'),
                      ),
                      SizedBox(width: 20.0),
                      ElevatedButton(
                        onPressed: decrementCounter,
                        child: Text('-'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Kaydet'),
                ),
                SizedBox(width: 20.0),
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
                  child: Text('Zikirlerim Push test'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
