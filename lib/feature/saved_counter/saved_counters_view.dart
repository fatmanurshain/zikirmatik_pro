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
        title: const Row(
          children: [
            Text('Zikirlerim'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: dbHelper.getAllZikirs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Hata: ${snapshot.error}'));
            } else {
              List<Map<String, dynamic>> counters = snapshot.data ?? [];
              print(counters);

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: counters.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('İsim: ${counters[index]['title']}'),
                              Text('Tarih: ${counters[index]['date']}'),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // dbHelper.deleteZikir(counters[index]['id']);
                                },
                                child: Text('Sil'),
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: Text(
                                  '${counters[index]['count']}',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              PopupMenuButton<String>(
                                itemBuilder: (context) {
                                  return [
                                    const PopupMenuItem<String>(
                                      value: 'devam_et',
                                      child: Text('Devam Et'),
                                    ),
                                    const PopupMenuItem<String>(
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
      ),
    );
  }
}
