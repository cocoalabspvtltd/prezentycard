import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

import '../util/app_helper.dart';
import '../util/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
          SizedBox(
          height: screenHeight * 0.3,
          child: Stack(clipBehavior: Clip.none, children: [
            Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.elliptical(20, 20),
                        bottomRight: Radius.elliptical(20, 20),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.topLeft,
                        colors:[Colors.yellow,Colors.indigo.shade900, ],
                      ),
                    ),
                    padding: EdgeInsets.only(top: 10, left: 15, right: 15),
                    width: screenWidth,
                    height: screenHeight * 0.1,
                    child: Column(
                      children: [
                        // Padding(
                        //     padding: const EdgeInsets.only(
                        //         top: 0,right: 290, bottom: 10),
                        //     child: Text("Hello,",
                        //     textAlign: TextAlign.start,
                        //         style: TextStyle(
                        //           color: Colors.grey,
                        //           fontSize: 16,
                        //         )),
                        //   ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 25, top: 10, left: 65),
                              child: Text('USERNAME',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                            ),
                            // if (data.userDetails!.userVerified == "Yes")
                            //   Padding(
                            //     padding: const EdgeInsets.only(
                            //         left: 12.0, bottom: 25, top: 5),
                            //     child: CachedNetworkImage(
                            //         width: 33,
                            //         imageUrl:
                            //         'https://prezenty.in/prezentycards-live/public/app-assets/image/verified.png'),
                            //   ),
                          ],
                        ),
                      ],
                    )),
              ],
            ),
            Positioned(
              top: 65,
              left: 15,
              right: 15,
              bottom: 25,

              // bottom: -screenHeight * 0.05,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                    )
                  ],
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                width: screenWidth,
                // height: screenHeight * 0.25,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "My Wallet",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          InkWell(
                              onTap: () async {
                                // Get.to(() => ApplyPrepaidCardListScreen(
                                //     isUpgrade: false));
                              },
                              borderRadius:
                              BorderRadius.all(Radius.circular(40)),
                              child: Container(
                                width: 100,
                                height: 50,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Colors.indigo.shade900, Colors.yellow],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius:
                                    BorderRadius.circular(40.0)),
                                child: OutlinedButton(
                                  onPressed: () async {
                                    // Get.to(() => ApplyPrepaidCardListScreen(
                                    //     isUpgrade: false));
                                  },
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40))),
                                  ),
                                  child: Text(
                                    "Get your card",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      )

                    ],
                  ),
                ),
              ),
            ),
          ]),
        )
          ],
        )

      ),

    );}
}

