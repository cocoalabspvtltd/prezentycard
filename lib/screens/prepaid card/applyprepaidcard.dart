import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prezentycardmodule/util/user.dart';

import '../../bloc/walletbloc/wlalet.dart';
import '../../models/getcardlistresp.dart';
import '../../network/api_response.dart';
import '../../util/CustomLoader/commomapiloader.dart';
import '../../util/app_helper.dart';
import '../../util/commonappbar.dart';
import 'package:http/http.dart' as http;

class Applyprepaidcardlist extends StatefulWidget {
  const Applyprepaidcardlist({Key? key}) : super(key: key);

  @override
  State<Applyprepaidcardlist> createState() => _ApplyprepaidcardlistState();
}

class _ApplyprepaidcardlistState extends State<Applyprepaidcardlist> {
  @override
  Future<void> cardlistr() async {
    // Define the API endpoint URL
    final String apiUrl = 'https://www.cocoalabs.in/PrepaidCardApp/api/prepaid-cards/list';

    try {
      // Make the GET request
      final response = await http.get(Uri.parse(apiUrl));

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Parse the response body as needed (e.g., JSON)
        final jsonData = response.body;
        // Process the data here...
        print('Response data: $jsonData');
      } else {
        // If the request was not successful, print the error message
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      // If an error occurs during the request, print the error message
      print('Failed to fetch data: $e');
    }
  }
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _walletBloc.getAvailableCardList();
    });

  }

  WalletBloc _walletBloc = WalletBloc();
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:CommonAppBarWidget(
        onPressedFunction: (){
          Get.back();
        },
        image: UserModule.userImageUrl,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Prepaid cards",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),

                  ],
                ),
              ),
            Expanded(
              child: StreamBuilder<ApiResponse<dynamic>>(
                  stream: _walletBloc.getAvailableCardListStream,

                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      switch (snapshot.data!.status!) {
                        case Status.LOADING:
                          return CommonApiLoader();
                        case Status.COMPLETED:
                          GetAllAvailableCardListResponse response =
                          snapshot.data!.data!;
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: response.cards!.length,
                              itemBuilder: ((context, index) {
                                return _cardItem(response.cards![index]!);
                              }));
                        case Status.ERROR:
                          return SizedBox(
                            height: 100,
                            child: Text("${snapshot.data!.message!}"),
                          );
                      }
                    }
                    return SizedBox();
                  }),
            ),
          ],
        ),
      ),
    );
  }
  String viewExpand = "More";
  Widget _cardItem(Cards cardDetailsData) {
    return Container(height: 700,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(height: 400,width: 400,
                    child: Center(
                      child: CachedNetworkImage(
                        // fit: BoxFit.fill,
                        // width: double.infinity,
                        // height: 230,
                        imageUrl: '${cardDetailsData.imageUrl ?? ""}',
                        placeholder: (context, url) => Center(
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => SizedBox(
                          child: Image.asset('assets/images/no_image.png'),
                        ),
                      ),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        cardDetailsData.title!,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      rupeeSymbol + ' ' + cardDetailsData.amount!.toString(),
                      // +" "+
                      // '+ GST',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.red, fontSize: 16),
                        children: [
                          WidgetSpan(
                            child: Transform.translate(
                              offset: const Offset(0.10, 10.0),
                              child: Text(
                                " " + '+GST',
                                style: TextStyle(
                                  fontSize:13,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  cardDetailsData.shortDescription!,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black54),
                ),
              ),
              (viewExpand != 'More')
                  ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: HtmlWidget(
                  cardDetailsData.longDescription!,
                ),
              )
                  : Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  GestureDetector(
                    onTap: () {
                      viewExpand != 'More'
                          ? viewExpand = 'More'
                          : viewExpand = 'Less';
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0, bottom: 4),
                      child: Text(
                        viewExpand,
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              GestureDetector(
                onTap: () {
                  // Get.to(() => PrepaidCardOfferListScreen(
                  //   cardId: cardDetailsData.id!,
                  // ));
                },
                child: Container(
                  width: screenWidth - 30,
                  height: 50,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.teal,Colors.teal.shade900, ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text(
                        "Deals & Offers",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white),
                      )),
                ),
              ),
              SizedBox(
                height: 12,
              ),
        Container(
          height: 50,
          width: screenWidth,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal,Colors.teal.shade900, ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text(
              "Apply Card",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white),
            ),
          ),
        ),

              // isUpgradeScreen
              //     ? GestureDetector(
              //   onTap: () {
              //     selectedCard = cardDetailsData;
              //     //_upgradeApplyCouponCode();
              //     touchpointRemeber();
              //   },
              //   child: Container(
              //     height: 50,
              //     width: screenWidth,
              //     decoration: BoxDecoration(
              //         gradient: LinearGradient(
              //           colors: [primaryColor, secondaryColor],
              //           begin: Alignment.centerLeft,
              //           end: Alignment.centerRight,
              //         ),
              //         borderRadius: BorderRadius.circular(10)),
              //     child: Center(
              //       child: Text(
              //         "Upgrade",
              //         style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //             fontSize: 18,
              //             color: Colors.white),
              //       ),
              //     ),
              //   ),
              // )
              //     : GestureDetector(
              //   onTap: () {
              //
              //     if (User.apiToken.isEmpty) {
              //       Get.to(() => LoginScreen(isFromWoohoo: false));
              //     } else {
              //       selectedCard = cardDetailsData;
              //       _applyCardCheckWalletCreationAndPayment();
              //       //  Get.to(() => ApplyKycScreen(razorPayId: '', firstName: '', lastName: '', panNumber: '', cardId: '', tx_id: 0,));
              //     }
              //   },
              //   child: Container(
              //     height: 50,
              //     width: screenWidth,
              //     decoration: BoxDecoration(
              //         gradient: LinearGradient(
              //           colors: [primaryColor, secondaryColor],
              //           begin: Alignment.centerLeft,
              //           end: Alignment.centerRight,
              //         ),
              //         borderRadius: BorderRadius.circular(10)),
              //     child: Center(
              //       child: Text(
              //         "Apply Card",
              //         style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //             fontSize: 18,
              //             color: Colors.white),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
