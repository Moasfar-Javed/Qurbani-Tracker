part of '../repos.dart';

class RemoteAuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  RemoteAuthRepo._privateConstructor();
  static final RemoteAuthRepo _instance = RemoteAuthRepo._privateConstructor();
  factory RemoteAuthRepo() {
    return _instance;
  }

  Future<UserCredential> signInAnonymously() async {
    return await _auth.signInAnonymously();
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      throw UserCancelledAuthEx();
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await _auth.signInWithCredential(credential);
  }

  Future<UserCredential> linkAnonymousWithGoogle() async {
    final user = _auth.currentUser;
    if (user == null || !user.isAnonymous) {
      throw UserNotAnnonymousEx();
    }

    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      throw UserCancelledAuthEx();
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final googleCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await user.linkWithCredential(googleCredential);
  }

  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await _auth.signOut();
  }

  Future<void> deleteUser() async {
    final user = _auth.currentUser;
    if (user == null) throw UserNotAuthenticatedEx();
    await user.delete();
  }
}
