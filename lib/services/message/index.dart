import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference groupCollection =
    FirebaseFirestore.instance.collection("groups");

  getChats(String groupId) async {
    return groupCollection
      .doc(groupId)
      .collection("messages")
      .orderBy("time")
      .snapshots();
  }

  sendMessage(String groupId, Map<String, dynamic> chatMessageData) async {
    groupCollection.doc(groupId).collection("messages").add(chatMessageData);
  }
}