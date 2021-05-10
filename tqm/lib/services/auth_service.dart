//import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:tqm/utils/network_utils/custom_http_client.dart';
import 'package:tqm/utils/network_utils/endpoints.dart';

final CustomHttpClient _customHttpClient = CustomHttpClient();
final FirebaseAuth auth = FirebaseAuth.instance;

////////////////////////////////////////
///
///
///
///

class AuthService {

Future signUpWithEmail({
     String email,
     String password,
  }) async {
    try {
      var authResult = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }


Future<UserCredential> loginWithEmail(String email, String password,) async {
    try {
      
      UserCredential  user = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user;

    } catch (e) {
      return e.message;
    }
  }

  final GoogleSignIn _googlSignIn = new GoogleSignIn();


  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    //final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    try {
      final GoogleSignInAccount googleUser =
          await _googlSignIn.signIn().catchError((onError) {
      String  returnResult = onError.toString();
        return null;
      });

       final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await auth.signInWithCredential(credential);
    }
      catch(e)
      {

      }


    // Obtain the auth details from the request
   
  }
/*
  Future<UserCredential> signInWithApple() async {

    final AuthorizationResult result = await AppleSignIn.performRequests([
      AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    ]);
    AppleIdCredential appleIdCredential = result.credential;
    print(appleIdCredential.toString());
    OAuthProvider oAuthProvider = OAuthProvider('apple.com');
    OAuthCredential credential = oAuthProvider.credential(
      idToken: String.fromCharCodes(appleIdCredential.identityToken),
      accessToken: String.fromCharCodes(appleIdCredential.authorizationCode),
    );

    return await auth.signInWithCredential(credential);
  }*/

  Future<Response> sendTokenToBackend({String token}) async {
    return await _customHttpClient
        .postRequest(route: loginPath, body: {'token': token});
  }
}
///////////////////////////
///