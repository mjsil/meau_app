import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import '../../models/user/index.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  User? _userFromFirebase(auth.User? user) {
    if(user == null) {
      return null;
    }
    
    return User(user.uid, user.email);
  }

  Stream<User?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email, 
      password: password,
    );

    return _userFromFirebase(credential.user);
  }

  Future<User?> createUserWithEmailAndPassword(
    String email,
    String password,
    String name,
    String age,
    String state,
    String city,
    String address,
    String phone,
    String username,
  ) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email, 
      password: password,
    );
    final user = _userFromFirebase(credential.user);
    
    await db.collection('people')
    .doc(user?.uid)
    .set({
      'name': name,
      'age': age,
      'state': state,
      'city': city,
      'address': address,
      'phone': phone,
      'username': username,
    });

    return user;
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}