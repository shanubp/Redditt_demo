

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:redditt_demo/core/constants/constants.dart';
import 'package:redditt_demo/core/providers/firebase_providers.dart';
import 'package:redditt_demo/models/user_model.dart';

import '../../../core/constants/firebase_constants.dart';
import '../../../core/failure.dart';
import '../../../core/type_defs.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
    firestore: ref.read(firestoreProvider),
    auth: ref.read(authProvider),
    googleSignIn: ref.read(googleSignInProvider)));

class AuthRepository{
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn
}) : _firestore = firestore,
     _auth = auth,
     _googleSignIn = googleSignIn;
  
  CollectionReference get _users => _firestore.collection(FirebaseConstants.usersCollection);

     FutureEither <UserModel> signInWithGoogle() async {
    try{
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      final googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);

       late UserModel userModel;
      if(userCredential.additionalUserInfo!.isNewUser) {
        userModel = UserModel(
            name: userCredential.user!.displayName ?? "No Name",
            profilePic: userCredential.user!.photoURL ?? Constants.avatarPath,
            banner: Constants.bannerPath,
            uid: userCredential.user!.uid,
            isAuthenticated: true,
            karma: 0,
            awards: []
        );
        await _users.doc(userCredential.user!.uid).set(userModel.toMap());
      }
      return right(userModel);
      // print(userCredential.user?.email);
    }
    on FirebaseException catch(e) {
      throw e.message!;
      // print(e);
    }
    catch (e){
      return left(Failure(e.toString()));
    }
  }
}