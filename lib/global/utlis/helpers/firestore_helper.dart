import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  //create the singleton instance
  factory FirestoreHelper() => FirestoreHelper._internal();
  FirestoreHelper._internal();

  static Future<void> addDocumentWithId(
      String collection, String documentId, Map<String, dynamic> data) async {
    return await firestore.collection(collection).doc(documentId).set(data);
  }

  //auto generate document id
  static Future<DocumentReference> addDocument(
      String collection, Map<String, dynamic> data) async {
    return await firestore.collection(collection).add(data);
  }

  static Future<void> updateDocument(
      String collection, String documentId, Map<String, dynamic> data,
      {bool merge = false}) async {
    return await firestore
        .collection(collection)
        .doc(documentId)
        .set(data, SetOptions(merge: merge));
  }

  static Future<void> deleteDocument(
      String collection, String documentId) async {
    return await firestore.collection(collection).doc(documentId).delete();
  }

  //get all documents in a collection
  static Stream<QuerySnapshot> getDocuments(String collection) {
    return firestore.collection(collection).snapshots();
  }

  //get all documents as future
  static Future<QuerySnapshot> getDocumentsFuture(String collection, String s, hospitalID) async {
    return await firestore.collection(collection).get();
  }

  //get a document by id as stream
  static Stream<DocumentSnapshot> getDocumentByIdStream(
      String collection, String documentId) {
    return firestore.collection(collection).doc(documentId).snapshots();
  }

  //get a document by id as future
  static Future<DocumentSnapshot> getDocumentByIdFuture(
      String collection, String documentId) async {
    return await firestore.collection(collection).doc(documentId).get();
  }

  static Stream<QuerySnapshot> getDocumentsWithCondition(
      String collection, String field, dynamic value) {
    return firestore
        .collection(collection)
        .where(field, isEqualTo: value)
        .snapshots();
  }

  static Future<QuerySnapshot> getDocumentsWithConditionFuture(
      String collection, String field, dynamic value) async {
    return await firestore
        .collection(collection)
        .where(field, isEqualTo: value)
        .get();
  }
}
