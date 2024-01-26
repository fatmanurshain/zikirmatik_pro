import 'package:flutter/material.dart';
import 'package:zikirmatik/product/models/counter_database_helper.dart';

class SavedCountersView extends StatelessWidget {
  SavedCountersView({super.key});

  final CounterDatabaseHelper dbHelper = CounterDatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            Text('Zikirlerim'),
          ],
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: dbHelper.getAllZikirs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else {
            List<Map<String, dynamic>> counters = snapshot.data ?? [];
            return ListView.builder(
              itemCount: counters.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('İsim: ${counters[index]['name']}'),
                            Text('Tarih: ${counters[index]['date']}'),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Burada silme işlemini gerçekleştirin
                                // dbHelper.deleteZikir(counters[index]['id']);
                              },
                              child: Text('Sil'),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: Text(
                                '${counters[index]['counter']}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            PopupMenuButton<String>(
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem<String>(
                                    value: 'devam_et',
                                    child: Text('Devam Et'),
                                  ),
                                  PopupMenuItem<String>(
                                    value: 'sil',
                                    child: Text('Sil'),
                                  ),
                                ];
                              },
                              onSelected: (value) {
                                if (value == 'devam_et') {
                                  // Devam et işlemi
                                } else if (value == 'sil') {
                                  // Silme işlemi
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
