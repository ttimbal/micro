import 'package:cloud_firestore/cloud_firestore.dart';

final docLines = FirebaseFirestore.instance.collection("Lineas");
final docTours = FirebaseFirestore.instance.collection("Recorridos");

class FireFirestore{

  static final FireFirestore _singleton = FireFirestore._internal();
  factory FireFirestore() {
    return _singleton;
  }
  FireFirestore._internal();

  List<dynamic> lines=[];
  List<dynamic> tours=[];



  List getLines() {
    if(lines.isNotEmpty){
      String s=lines.first.toString();
      print(s);
      return lines;
    }

    docLines.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        lines.add(doc.data());
      });
    });
    return lines;
  }

  List getTours(String lineName) {
/*    if(tours.isNotEmpty){
      return tours;
    }*/
  tours.clear();

    docTours.where('linea', isEqualTo: lineName).get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        tours.add(doc.data());
        print(tours);
      });
    });
    return tours;
  }


}


