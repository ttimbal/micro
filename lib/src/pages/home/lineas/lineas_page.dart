import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../shared/constants.dart';

class LineasPage extends StatelessWidget {
  const LineasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> lineasStream = FirebaseFirestore.instance
        .collection("Lineas")
        .orderBy('id')
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Text("Lineas"),
        backgroundColor: Colors.indigoAccent,
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: lineasStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                  Text("Error")
                  ],
                ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                  ],
                )
            );
          }
          /* return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            children: snapshot.data!.docs.map((document) {
              Map<String, dynamic> lineas =
                  document.data()! as Map<String, dynamic>;
              return Card(
                child: ListTile(
                  title: Text('${lineas['name']}'),
                  trailing:
                      const Icon(Icons.directions_transit, color: Colors.green),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      'ruta',
                      arguments: lineas,
                    );
                  },
                ),
              );
            }).toList(),
          );*/
          return GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (BuildContext context, int index) {
              var data = snapshot.data!.docs[index];
              return InkWell(
                child: Card(
                  child: ListView(
                    padding: const EdgeInsets.all(4),
                    children: [
                      Text(data["name"]),
                      Image.network(images[data["name"]] ?? '', fit: BoxFit.cover),
                    ],

                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    'ruta',
                    arguments: data,
                  );
                },
              );
            },
            itemCount: snapshot.data!.docs.length,
          );
        },
      ),
    );
  }
}
