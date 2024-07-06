import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addMessage(String userId, String message) async {
    await _db.collection('messages').add({
      'userId': userId,
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getMessages() {
    return _db.collection('messages').orderBy('timestamp').snapshots();
  }
}
