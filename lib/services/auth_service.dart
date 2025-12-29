import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Stream of auth changes
  Stream<User?> get user => _auth.authStateChanges();

  // Sign Up
  Future<UserCredential> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      // Create auth user
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create firestore user document
      if (result.user != null) {
        await _firestore.collection('users').doc(result.user!.uid).set({
          'id': result.user!.uid,
          'name': name,
          'email': email,
          'profileImage': 'https://randomuser.me/api/portraits/lego/1.jpg', // Default image
          'friendsCount': 0,
          'mutualFriends': [],
          'createdAt': FieldValue.serverTimestamp(),
        });

        // Update display name
        await result.user!.updateDisplayName(name);
      }

      return result;
    } catch (e) {
      rethrow;
    }
  }

  // Sign In
  Future<UserCredential> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  // Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
