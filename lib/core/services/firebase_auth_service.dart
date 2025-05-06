import 'package:e_commerce/core/errors/exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  Future deleteUser() async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
    } catch (e) {
      print('Error deleting user: $e');
    }
  }

  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String role,
    required String name,
  }) async {
    try {
      // Trim spaces and validate email format
      final trimmedEmail = email.trim();
      if (!EmailValidator.validate(trimmedEmail)) {
        print("Invalid email detected before Firebase call: '$trimmedEmail'");
        throw CustomException(
          'InvalidEmail',
          message: 'The email address is badly formatted.',
        );
      }

      print(
        "Attempting signup with email: '$trimmedEmail''$password''$role''$name'",
      );

      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: trimmedEmail,
            password: password,
          );

      print(
        "User signed up successfully: ${credential.user?.email}, $password, $role, $name",
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException: ${e.code} - ${e.message}"); // Debugging

      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage =
              'The email address is already in use by another account.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is badly formatted.';
          break;
        case 'weak-password':
          errorMessage = 'The password is too weak.';
          break;
        default:
          errorMessage = 'An unknown error occurred.';
      }
      throw CustomException(errorMessage, message: '$errorMessage');
    } catch (e) {
      print("Unexpected error: $e"); // Debugging
      throw CustomException(
        'UnexpectedError',
        message: 'An unexpected error occurred. Please try again.',
      );
    }
  }

  Future<User> signInWithEmailAndPassword({
    required String email,
    required String role,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      print(
        "Exception in FirebaseAuthService.signInWithEmailAndPassword: ${e.toString()}",
      ); // Debugging

      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'Wrong email or password provided ';
        case 'invalid-credential':
          errorMessage = 'Wrong email or password provided ';
          break;
        case 'user-disabled':
          errorMessage =
              'The user account has been disabled by an administrator.';
          break;
        case 'user-not-found':
          errorMessage = 'No user found for that email.';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong email or password provided ';
          break;
        case 'too-many-requests':
          errorMessage =
              'We have blocked all requests from this device due to unusual activity. Try again later.';
          break;
        default:
          errorMessage = 'An unknown error occurred.';
      }
      throw CustomException(errorMessage, message: '$errorMessage');
    } catch (e) {
      print("Unexpected error: $e"); // Debugging
      throw CustomException(
        'UnexpectedError',
        message: 'An unexpected error occurred. Please try again.',
      );
    }
  }

  Future<User> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return (await FirebaseAuth.instance.signInWithCredential(credential)).user!;
  }

  Future<User> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

    // Once signed in, return the UserCredential
    return (await FirebaseAuth.instance.signInWithCredential(
      facebookAuthCredential,
    )).user!;
  }

  bool isLoggedIn() => FirebaseAuth.instance.currentUser != null;

  //  Future<User> signInWithApple() async {
  //   // Trigger the sign-in flow
  //   final LoginResult loginResult = await FacebookAuth.instance.login();

  //   // Create a credential from the access token
  //   final OAuthCredential facebookAuthCredential =
  //       FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

  //   // Once signed in, return the UserCredential
  //   return (await FirebaseAuth.instance.signInWithCredential(
  //     facebookAuthCredential,
  //   )).user!;
  // }
}
