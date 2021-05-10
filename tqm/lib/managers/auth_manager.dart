import 'dart:convert';

//import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:tqm/services/auth_service.dart';
import 'package:tqm/utils/local_storage.dart';
import 'package:tqm/models/user.dart' as Member;

final AuthService _authService = AuthService();
final LocalStorage _localStorage = LocalStorage();
final Logger _logger = Logger();

class AuthManager with ChangeNotifier {
  //Future<bool> get appleSignInAvailable => AppleSignIn.isAvailable();
  String _message = '';
  bool _isLoading = false;

  String get message => _message;
  bool get isLoading => _isLoading;

  setMessage(String message) {
    _message = message;
    notifyListeners();
  }

  setisLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  Future signUp({
    @required String email,
    @required String password,
  }) async {
    try {
      bool isSuccessful = false;
      setisLoading(true);

      var result = await _authService.signUpWithEmail(
        email: email,
        password: password,
      );

      setisLoading(false);

      return isSuccessful;

      /* if (result is bool) {
      if (result) {
        _navigationService.navigateTo(HomeViewRoute);
      } else {
        await _dialogService.showDialog(
          title: 'Sign Up Failure',
          description: 'General sign up failure. Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Sign Up Failure',
        description: result,
      );
    }*/
    } catch (e) {
      _logger.d('catch $e');
      return false;
    }
  }

  Future<bool> loginUserwithEmail(String email, String password) async {
    try {
      bool isSuccessful = false;
      setisLoading(true);
      await _authService
          .loginWithEmail(email, password)
          .then((UserCredential googleUserCredential) async {
        if (googleUserCredential != null) {
          String token = await googleUserCredential.user.getIdToken();

          /*  Response _response =
              await _authService.sendTokenToBackend(token: token);
          int statusCode = _response.statusCode;
          Map<String, dynamic> body = json.decode(_response.body);
          _logger.d('_response ${body['data']['auth_token']}');*/

          setisLoading(false);
          //if (statusCode == 201)
          {
            // Member.User member = Member.User.fromMap(googleUserCredential.user.);
            var member = googleUserCredential.user;

            await _localStorage.saveUserInfo(
                id: member.uid,
                name: member.displayName,
                picture: member.photoURL,
                userId: member.uid,
                email: member.email,
                signInProvider: member.tenantId,
                authToken: member.refreshToken,
                organizationId: '1',
                team: 'member.team',
                fcmToken: member.refreshToken,
                phoneNumber: member.phoneNumber);
            setMessage('body[Message]');

            isSuccessful = true;
          }
          /* else {
            isSuccessful = false;
            setMessage(body['message']);
            _logger.d('message ${body['message']}');
          }*/
        } else {
          isSuccessful = false;
          setMessage('Authentication failed. Try gain!');
        }
      }).catchError((onError) {
        isSuccessful = false;
        setMessage('$onError');
        setisLoading(false);
        _logger.d('catchError $onError');
      }).timeout(Duration(seconds: 60), onTimeout: () {
        isSuccessful = false;
        setMessage('Timeout! Check your internet connection.');
        setisLoading(false);
      });
      return isSuccessful;
    } catch (e) {
      _logger.d('catch $e');
      return false;
    }
  }

  Future<bool> loginUserwithGoogle() async {
    try {
      bool isSuccessful = false;
      setisLoading(true);
      await _authService
          .signInWithGoogle()
          .then((UserCredential googleUserCredential) async {
        if (googleUserCredential != null) {
          String token = await googleUserCredential.user.getIdToken();

          /*  Response _response =
              await _authService.sendTokenToBackend(token: token);
          int statusCode = _response.statusCode;
          Map<String, dynamic> body = json.decode(_response.body);
          _logger.d('_response ${body['data']['auth_token']}');*/

          setisLoading(false);
          //if (statusCode == 201)
          {
            // Member.User member = Member.User.fromMap(googleUserCredential.user.);
            var member = googleUserCredential.user;

            await _localStorage.saveUserInfo(
                id: member.uid,
                name: member.displayName,
                picture: member.photoURL,
                userId: member.uid,
                email: member.email,
                signInProvider: member.tenantId,
                authToken: member.refreshToken,
                organizationId: '1',
                team: 'member.team',
                fcmToken: member.refreshToken,
                phoneNumber: member.phoneNumber);
            setMessage('body[Message]');

            isSuccessful = true;
          }
          /* else {
            isSuccessful = false;
            setMessage(body['message']);
            _logger.d('message ${body['message']}');
          }*/
        } else {
          isSuccessful = false;
          setMessage('Authentication failed. Try gain!');
        }
      }).catchError((onError) {
        isSuccessful = false;
        setMessage('$onError');
        setisLoading(false);
        _logger.d('catchError $onError');
      }).timeout(Duration(seconds: 60), onTimeout: () {
        isSuccessful = false;
        setMessage('Timeout! Check your internet connection.');
        setisLoading(false);
      });
      return isSuccessful;
    } catch (e) {
      _logger.d('catch $e');
      return false;
    }
  }
/*
  Future<bool> loginUserwithApple() async {
    bool isSuccessful = false;

    if (await appleSignInAvailable) {
      final AuthorizationResult result = await AppleSignIn.performRequests([
        AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
      ]);

      switch (result.status) {
        case AuthorizationStatus.authorized:
          await _authService
              .signInWithApple()
              .then((appleUserCredential) async {
            if (appleUserCredential != null) {
              String token = await appleUserCredential.user.getIdToken();

              Response _response =
                  await _authService.sendTokenToBackend(token: token);
              int statusCode = _response.statusCode;
              Map<String, dynamic> body = json.decode(_response.body);
              Member.User member = Member.User.fromMap(body);
              setisLoading(false);
              if (statusCode == 201) {
                await _localStorage.saveUserInfo(
                    id: member.data.id.toString(),
                    name: member.data.name,
                    picture: member.data.picture,
                    userId: member.data.userId,
                    email: member.data.email,
                    signInProvider: member.data.signInProvider,
                    authToken: member.data.authToken,
                    organizationId: member.data.organizationId,
                    team: member.data.team,
                    fcmToken: member.data.fcmToken,
                    phoneNumber: member.data.phoneNumber);
                isSuccessful = true;
                setMessage(body['message']);
              } else {
                _logger.d(_response.body);
                isSuccessful = false;
                setMessage(body['message']);
              }
            } else {
              _logger.d('userCredential is null');
              isSuccessful = false;
              setMessage('Authentication failed. Try gain!');
            }
          }).catchError((onError) {
            _logger.d('userCredential $onError');
            isSuccessful = false;
            setMessage('$onError');
            setisLoading(false);
          }).timeout(Duration(seconds: 60), onTimeout: () {
            isSuccessful = false;
            setMessage('Timeout! Check your internet connection.');
            setisLoading(false);
          });
          break;
        case AuthorizationStatus.cancelled:
          isSuccessful = false;
          setMessage(result.error.localizedFailureReason);
          break;
        case AuthorizationStatus.error:
          _logger.d(result.error.localizedDescription);
          isSuccessful = false;
          setMessage(result.error.localizedDescription);
          break;
      }
    } else {
      //no apple sign in
      isSuccessful = false;
      setMessage('Apple sign in not supported!');
      setisLoading(false);
    }
    return isSuccessful;
  }*/
}

//////////////
//////////////
//////
///////
///
