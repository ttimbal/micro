import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseProvider {
  final docLineas = FirebaseFirestore.instance.collection("Lineas");
  List _lineas = [];
  List get lineas => _lineas;
  FirebaseProvider();


  Future<void> getLines() async {
    _lineas = [];
    docLineas.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        _lineas.add(doc.data());
      });
    });
  }
}
