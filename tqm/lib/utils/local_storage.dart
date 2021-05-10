import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:tqm/models/user.dart';

class LocalStorage {
  final String _tqm = 'tqm'; //for User FireBase
  //final String _tqmOrg = 'tqmOrg';

  Future saveUserInfo(
      {@required String id,
      @required String name,
      @required String picture,
      @required String userId,
      @required String email,
      @required String signInProvider,
      @required String authToken,
      @required String organizationId,
      @required String team,
      @required String fcmToken,
      @required String phoneNumber}) async {
    final Box box = await Hive.openBox(_tqm);
    await box.put('id', id);
    await box.put('name', name);
    await box.put('picture', picture);
    await box.put('user_id', userId);
    await box.put('email', email);
    await box.put('sign_in_provider', signInProvider);
    await box.put('auth_token', authToken);
    await box.put('organizationId', organizationId);
    await box.put('team', team);
    await box.put('fcm_token', fcmToken);
    await box.put('phone_number', phoneNumber);
    await box.put('isAuth', true);
  }

  Future saveOrgNameInfo({
    @required String name,
  }) async {
    final Box box = await Hive.openBox(_tqm);

    await box.put('name', name);
  }

  Future<Data> getUserInfo() async {
    final Box box = await Hive.openBox(_tqm);
    String id = await box.get('id');
    String name = await box.get('name');
    String picture = await box.get('picture');
    String userId = await box.get('user_id');
    String email = await box.get('email');
    String signInProvider = await box.get('sign_in_provider');
    String authToken = await box.get('auth_token');
    String organizationId = await box.get('organizationId');
    String team = await box.get('team');
    String fcmToken = await box.get('fcm_token');
    String phoneNumber = await box.get('phone_number');
    return Data(
        authToken: authToken,
        team: team,
        email: email,
        fcmToken: fcmToken,
        id: id,
        name: name,
        organizationId: organizationId,
        phoneNumber: phoneNumber,
        picture: picture,
        userId: userId,
        signInProvider: signInProvider);
  }

  Future<String> getId() async {
    final Box box = await Hive.openBox(_tqm);
    return await box.get('id');
  }

  Future<String> getName() async {
    final Box box = await Hive.openBox(_tqm);
    return await box.get('name');
  }

  Future<String> getPicture() async {
    final Box box = await Hive.openBox(_tqm);
    return await box.get('picture');
  }

  Future<String> getFirebaseUserId() async {
    final Box box = await Hive.openBox(_tqm);
    return await box.get('user_id');
  }

  Future<String> getOrgId() async {
    final Box box = await Hive.openBox(_tqm);
    return await box.get('organizationId');
  }

  Future<String> authToken() async {
    final Box box = await Hive.openBox(_tqm);
    return await box.get('auth_token');
  }

  Future<int> clearStorage() async {
    final Box box = await Hive.openBox(_tqm);
    return await box.clear();
  }
}

///////////////
////////////////
//////////////////
///
///
