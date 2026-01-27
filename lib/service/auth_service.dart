
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class AuthService{
  final FirebaseAuth _auth=FirebaseAuth.instance;

  // sign up method
  Future<User?>signUp(String email,String password) async {
   final result=await  _auth.createUserWithEmailAndPassword(email: email, password: password);
   result.user!.sendEmailVerification();
   return result.user;
  }

  // login method

  Future<User?>login(String email,String password) async {
   final result=await  _auth.signInWithEmailAndPassword(email: email, password: password);
   return result.user;
  }

  // sign in google

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print('Google Sign-In Error: $e');
      return null;
    }
  }

}

