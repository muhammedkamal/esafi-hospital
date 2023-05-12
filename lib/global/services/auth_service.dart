import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../data/models/admin.dart';
import '../utlis/helpers/firestore_helper.dart';
import '../utlis/helpers/storage_helper.dart';

class AuthService {
  String? userId;
  UserCredential? _userCredential;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Admin? user;
  // final FirebaseFirestore db = FirebaseFirestore.instance;
  // final usersCollection = FirebaseFirestore.instance.collection('admins');
  AuthService();
  Future<bool> registerUsingEmailAndPassword(Map<String, dynamic> userData,
      {String collection = 'hospitals_empolyees'}) async {
    try {
      _userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: userData['email'], password: userData['password']);
      userData.remove('password');
      userData['hospitalId'] = user!.hospitalId;
      // userData.remove('photo');
      // userData['name'] ??= 'blank';
      // userData['photoUrl'] ??= 'blank';
      print(userData);
      final String newUserId = _userCredential!.user!.uid;
      await FirestoreHelper.addDocumentWithId(collection, newUserId, userData);
      return true;
    } on FirebaseAuthException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
      return false;
    }
  }

  Future<bool> loginUsingEmailAndPassword(String email, String password) async {
    String tag = "loginUsingEmailAndPassword";
    try {
      _userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      userId = _userCredential!.user!.uid;
      return true;
    } on FirebaseAuthException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  // Returns true if email address is in use.
  Future<bool> checkIfEmailInUse(String emailAddress) async {
    String tag = "checkIfEmailInUse";
    try {
      // Fetch sign-in methods for the email address
      final list =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(emailAddress);

      // In case list is not empty
      if (list.isNotEmpty) {
        debugPrint("true");
        // Return true because there is an existing
        // user using the email address
        return true;
      } else {
        debugPrint("false");
        // Return false because email adress is not in use
        return false;
      }
    } catch (e) {
      return true;
    }
  }

  Future<void> logOut() async {
    String tag = "logOut";
    try {
      _firebaseAuth.signOut();
    } on FirebaseAuthException catch (exception) {
      rethrow;
    }
  }

  static bool get isAuth {
    return FirebaseAuth.instance.currentUser != null;
  }

  Future<Admin?> get currentUser async {
    userId = _firebaseAuth.currentUser?.uid;
    if (userId == null) return null;
    final documetSnapShot = await FirestoreHelper.getDocumentByIdFuture(
        'hospitals_empolyees', userId!);
    documetSnapShot.id;
    user = Admin.fromSnapshot(documetSnapShot);
    return user;
  }

  String handleException(FirebaseAuthException exception) {
    if (exception.code == "account-exists-with-different-credential") {
      return "multiple provider";
    } else if (exception.code == "email-already-exists" ||
        exception.code == "email-already-in-use") {
      return "email already exists";
    } else if (exception.code == "invalid-email") {
      return "invalid-email";
    } else if (exception.code == "invalid-password") {
      return "invalid-password";
    } else if (exception.code == "phone-number-already-exists") {
      return "dublicate number";
    } else if (exception.code == "user-not-found") {
      return "user not found";
    } else if (exception.code == "wrong-password") {
      return "wrong pass";
    } else if (exception.code == "invalid-verification-code") {
      return "wrong sms code";
    } else if (exception.code == "weak-password") {
      return "weak password";
    } else if (exception.code == "invalid-phone-number") {
      return "invalid-phone-number";
    } else if (exception.code == "session-expired") {
      return "too many attempts";
    } else if (exception.code == "too-many-requests") {
      return "too many attempts";
    } else if (exception.code == "user-disabled") {
      return "user-disabled";
    }
    return "unexpected error";
  }

// This function updates the user's location in the Firestore database
// The new user location is passed as a position parameter to the function.
// Firestore Firestore save long and lat only
  // Future<void> updateUserLocation(Position position) async {
  //   await FirestoreHelper.updateDocument('admins', userId!,
  //       {'location': GeoPoint(position.latitude, position.longitude)},
  //       merge: true);
  //   user!.location = GeoPoint(position.latitude, position.longitude);
  //   print('location updated');
  // }

  Future<void> setFcmToken(String value) async {
    await FirestoreHelper.updateDocument('admins', userId!, {'fcmToken': value},
        merge: true);
    // user!.fcmToken = value;
    print('fcmToken updated');
  }

  Future<void> updateUserProfile(Map<String, dynamic> userData) async {
    await FirestoreHelper.updateDocument('admins', userId!, userData,
        merge: true);
    // user!.firstName = firstName;
    // user!.email = email;
    // user!.phoneNumber = phoneNumber;

    print('User profile updated');
  }

  Future<void> ChangePassword(String old, String newP) async {
    try {
      //check current password if correct
      final AuthCredential credential = EmailAuthProvider.credential(
        email: _firebaseAuth.currentUser!.email!,
        password: old,
      );
      await _firebaseAuth.currentUser!.reauthenticateWithCredential(credential);

      await _firebaseAuth.currentUser!.updatePassword(newP);
    } on FirebaseAuthException catch (e) {
      rethrow;
    }
  }
}
