import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoggedIn = false;
  User? _loggedInUser = FirebaseAuth.instance.currentUser;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool get isLoggedIn => _isLoggedIn;
  User? get loggedInUser => _loggedInUser;

  bool getLogin() {
    if (_auth.currentUser == null) {
      return false;
    }
    return true;
  }

  Future<bool> loginOutWithGoogle() async {
    try {
      await _googleSignIn.signOut();
      _isLoggedIn = false;
      _loggedInUser = null;
      notifyListeners();
      return true;
    } catch (ex) {
      _isLoggedIn = true;
      notifyListeners();
      return false;
    }
  }

  void setLoggedInUser(User? account) {
    _loggedInUser = account;
    notifyListeners();
  }

  Future<User?> loginWithGoogle() async {
    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();
      try {
        UserCredential userCredential =
            await _auth.signInWithPopup(authProvider);
        _isLoggedIn = true;
        notifyListeners();
        return userCredential.user;
      } catch (e) {
        e;
      }
    } else {
      try {
        final GoogleSignInAccount? googleSignInAccount =
            await _googleSignIn.signIn();
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount!.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        _isLoggedIn = true;
        notifyListeners();
        return userCredential.user;
      } on FirebaseAuthException catch (e) {
        e;
      }
    }
    return null;
  }
}
