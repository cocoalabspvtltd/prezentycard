import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import 'package:http/http.dart' as http;
import 'package:prezentycardmodule/screens/profile/profile_screen.dart';

import '../util/app_helper.dart';
import '../util/commondrawer.dart';
import '../util/ommonnavigation.dart';
import '../util/string_constants.dart';
import '../util/user.dart';
import 'homescreen.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  bool isLoadingMore = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  int _currentTab = 0;
  DateTime? currentBackPressTime;
  String accountId = UserModule.userId;
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        DateTime now = DateTime.now();
        if (currentBackPressTime == null ||
            now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
          currentBackPressTime = now;
          Fluttertoast.showToast(msg: StringConstants.doubleBackExit);
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Scaffold(
          key: _scaffoldKey,
          appBar: _currentTab == 0
              ? AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.yellow, Color(0xffad9c00)],
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
                icon: Icon(
                  CupertinoIcons.text_alignleft,
                  color: Colors.white,
                  size: 30,
                ),
                splashRadius: 24,
                onPressed: () {
                  _scaffoldKey.currentState!.openDrawer();
                }),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20,top: 5,bottom: 5),
                child: badges.Badge(
                  position: badges.BadgePosition.topEnd( top:0,end:3),
                  badgeContent: Text(
                    '1',
                    style:TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                    ),
                  ),
                  showBadge: true,
                  child: IconButton(
                    icon: Icon(
                      Icons.notifications_none_rounded,size: 35,
                    ),
                    onPressed: () {
                //      Get.to(() => NotificationScreen());
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20,top: 10,bottom: 5),
                child: InkWell(
                  onTap: (){
                 //   Get.to(() => ProfileDetailsScreen());
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.black87,
                    radius: 25,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl:'${UserModule.userImageUrl}',
                      // '${userData?.baseUrl}${userData?.userDetails?.imageUrl}',
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black12,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Center(
                        child: Image(
                          image: AssetImage(
                            'assets/images/ic_avatar.png',
                          ),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
            // actions: [
            //   FutureBuilder<String>(
            //       future:_getTouchPoints(),
            //       builder:
            //           (BuildContext context, AsyncSnapshot<String> snapshot) {
            //         String version = '';
            //         if (snapshot.connectionState == ConnectionState.done &&
            //             snapshot.hasData && snapshot.data != null) {
            //           return Center(
            //             child: Container(
            //               decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(100),
            //                 color: secondaryColor,
            //               ),
            //               margin: const EdgeInsets.only(right: 8),
            //               padding: const EdgeInsets.all(12),
            //               child: Row(
            //                 children: [
            //                   Image.asset(
            //                     'assets/images/ic_coins.png',
            //                     height: 12,
            //                   ),
            //                   Text(
            //                     '${snapshot.data}',
            //                     style: TextStyle(
            //                         fontSize: 16, fontWeight: FontWeight.w600),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           );
            //         }
            //         return SizedBox();
            //       }),

            // ],
          )
              : AppBar(
            elevation: 0,
            leading: IconButton(
                icon: Icon(
                  CupertinoIcons.text_alignleft,
                  color: Colors.white,
                  size: 30,
                ),
                splashRadius: 24,
                onPressed: () {
                  _scaffoldKey.currentState!.openDrawer();
                }),
          ),
          drawer: CommonDrawerWidget(),
          bottomNavigationBar: _currentTab == 0 ? CommonBottomNavigationWidget()
              :BottomNavigationBar(
            currentIndex: _currentTab,
            items: [
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/ic_home.png',
                    height: 20,
                  ),
                  activeIcon: Image.asset(
                    'assets/images/ic_home_selected.png',
                    height: 20,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/ic_profile.png',
                    height: 20,
                  ),
                  activeIcon: Image.asset(
                    'assets/images/ic_profile_selected.png',
                    height: 20,
                  ),
                  label: 'Profile'),
            ],
            onTap: (index) {
              if (_currentTab != index) {
                setState(() {
                  _currentTab = index;
                });
              }
            },
          ),
          body:_currentTab == 0 ?
          // widget.fromSignUp?
          // SignUpCompletedScreen()
                HomeScreen()
              : ProfileScreen()),
    );
  }
}
