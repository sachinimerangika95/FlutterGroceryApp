import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDetails {
  final String name;
  // other properties...

  UserDetails({required this.name});
}

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  User? get currentUser => _firebaseAuth.currentUser;
  UserDetails? _userDetails;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  get userDetails => _userDetails;

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    await getUserDetails();
  }

  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> createUser({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> getUserDetails() async {
    User? user = _firebaseAuth.currentUser;

    if (user != null) {
      DocumentSnapshot docSnapshot =
          await _db.collection('users').doc(user.uid).get();
      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        _userDetails = UserDetails(name: data['name']);
      }
    }
  }
}
