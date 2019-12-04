import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseCalls {
  final CollectionReference testCollection =
      Firestore.instance.collection("test");

  void createUser(String uid) async {
    return await testCollection.document(uid).setData({
      "test": "test",
      "preferences": {
        "colorScheme": "default",
        "speechToText": false,
        "taskAssistant": false
      },
      "categories": {"general": []}
    });
  }

  void addTask() {
    print("this function is being called!!");
    // try {
    //   testCollection.document("IKuYvSCBu6UPthSKyOVYcNZQRhs1").updateData({
    //     "categories": {
    //       "general": ["what a success"]
    //     }
    //   });
    // }

    try {
      var list = List<String>();
      list.add("fwaazzy");

      testCollection.document("QjLA8qgVujPL69Ko7z6rWLmxnbe2").updateData({
        "categories.general": FieldValue.arrayUnion(["foozy"])
      });
    } catch (err) {
      print(err);
    }
  }
}

// testCollection
//           .document("QjLA8qgVujPL69Ko7z6rWLmxnbe2")
//           .updateData({"test": FieldValue.arrayUnion(list)});
