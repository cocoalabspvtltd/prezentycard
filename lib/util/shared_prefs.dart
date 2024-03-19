import 'dart:convert';

import 'package:get/get.dart';
import 'package:prezentycardmodule/util/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/usermodel.dart';



class SharedPrefs {
  static late SharedPreferences _preferences;

  static String spToken = 'spToken';

  static String spUserId = 'spUserId';

  static String spEmail = 'spEmail';
  static String spName = 'spName';
  static String spMobile = 'spMobile';
  static String spAddress = 'spAddress';
  static String spRole = 'spRole';
  static String spImageUrl = 'spImageUrl';
  static String spAutoLogin = 'spAutoLogin';
  static String spGuestUserEmail = 'spGuestUserEmail';
  static String spNotification = 'spNotification';
  static String spHappyCardId = 'spHappyCardId';
   static String spHiCardNo = 'spHiCardNo';
    static String spHiCardPin = 'spHiCardPin';
    static String spHiCardBalance = 'spHiCardBalance';
  // static String spMPin = 'spMPin';

  static init() async {
    _preferences = await SharedPreferences.getInstance();

    UserModule.set(
      getString(spToken),
      getString(spUserId),
      getString(spName),
      getString(spEmail),
      getString(spRole),
      getString(spImageUrl),
      getString(spMobile),
      getString(spAddress),
      getString(spHappyCardId),
      getString(spHiCardNo),
      getString(spHiCardPin),
      getString(spHiCardBalance),

      // getBool(spMPin),
    );
  }

  static String getString(String key) {
    return _preferences.getString(key) ?? '';
  }

  static Future<bool> setString(String key, String value) async {
    return await _preferences.setString(key, value);
  }

  static Future<bool> logIn(
      bool needRemember, UserSignUpResponse response) async {
    if (response.user == null) return false;

    String token = response.token ?? UserModule.apiToken;
    User userDetails = response.user!;

    if (needRemember) {
      await setBool(spAutoLogin, true);
      await setString(spToken, '$token');
      await setString(spUserId, '${userDetails.id ?? ''}');
      await setString(spEmail, '${userDetails.email ?? ''}');
      await setString(spName, '${userDetails.name ?? ''}');



      // await setString(spCountryCode, '${userDetails.countryCode ?? ''}');
      // await setString(spPhone, '${userDetails.phoneNumber ?? ' '}');
      // await setBool(spMPin, userDetails.hasMPin ?? false);
    } else {
      await setBool(spAutoLogin, false);
    }

   // Notifications.setUserId(userDetails.email!);

    UserModule.set(
      token,
      '${userDetails.id ?? ''}',
      '${userDetails.name ?? ''}',
      '${userDetails.email ?? ''}'
"","","","","","","","","",
      // userDetails.hasMPin ?? false,
    );
    return true;
  }

  static Future<bool> logOut() async {
    await _preferences.clear();
    UserModule.set('', '', '', '', '', '', '', '','','','','');
   // Notifications.removeUserId();
    //Freshchat.resetUser();
   // Get.offAll(() => WithoutLoginHomeScreen(), transition: Transition.fade);
     //Get.offAll(() => SplashScreen(isFromLogout: true));
    return true;
  }

  static Future<bool> setBool(String key, bool value) async {
    return await _preferences.setBool(key, value);
  }

  static bool getBool(String key) {
    return _preferences.getBool(key) ?? false;
  }

  static Future<bool> setNotificationData(Map<String, dynamic> data) async {
    return await _preferences.setString(spNotification, '${json.encode(data)}');
  }

  static Future<bool> clearNotificationData() async {
    return await _preferences.setString(spNotification, '${json.encode({})}');
  }

  static Map<String, dynamic> getNotificationData() {
    String s = getString(spNotification);
    return s.isEmpty ? {} : json.decode(s);
  }

// static setGuestUserParticipationList(
//     int eventId, int participantId, String email) async {
//   List<String> list =
//       _preferences.getStringList(spGuestUserParticipation) ?? [];
//   list.add('$eventId,$participantId,$email');
//   await _preferences.setStringList(spGuestUserParticipation, list);
// }

// static List<GuestUserParticipation> getGuestUserParticipationList() {
//   List<String> list =
//       _preferences.getStringList(spGuestUserParticipation) ?? [];
//   List<GuestUserParticipation> pList = [];
//   list.forEach((element) {
//     pList.add(GuestUserParticipation(element));
//   });
//   return pList;
// }
}

// class GuestUserParticipation {
//   int eventId = 0;
//   int participantId = 0;
//   String email = '';
//
//   GuestUserParticipation(String element) {
//     List l = element.split(',');
//     this.eventId = int.parse(l[0]);
//     this.participantId = int.parse(l[1]);
//     this.email = l[2];
//   }
// }
