import 'package:firebase_auth/firebase_auth.dart';

enum AuthResultStatus {
  successful,
  emailAlreadyExists,
  wrongPassword,
  invalidEmail,
  userNotFound,
  userDisabled,
  operationNotAllowed,
  tooManyRequests,
  undefined,
}

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChaanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String> signIn({String email, String password}) async {
    try {
      final authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return 'Signed in';
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      String errorMessage;
      switch (e) {
        case AuthResultStatus.invalidEmail:
          errorMessage = "Your email address appears to be malformed.";
          break;
        case AuthResultStatus.wrongPassword:
          errorMessage = "Your password is wrong.";
          break;
        case AuthResultStatus.userNotFound:
          errorMessage = "User with this email doesn't exist.";
          break;
        case AuthResultStatus.userDisabled:
          errorMessage = "User with this email has been disabled.";
          break;
        case AuthResultStatus.tooManyRequests:
          errorMessage = "Too many requests. Try again later.";
          break;
        case AuthResultStatus.operationNotAllowed:
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        case AuthResultStatus.emailAlreadyExists:
          errorMessage =
              "The email has already been registered. Please login or reset your password.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }

      return errorMessage;
    }
  }

  Future<String> signUp({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return 'Signed Up';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
