import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prezentycardmodule/screens/prepaid%20card/applykyc.dart';
import 'package:prezentycardmodule/screens/prepaid%20card/prepaidcardofferlist.dart';
import 'package:prezentycardmodule/util/user.dart';

import '../../bloc/walletbloc/wlalet.dart';
import '../../models/getcardlistresp.dart';
import '../../network/api_response.dart';
import '../../util/CustomLoader/commomapiloader.dart';
import '../../util/app_helper.dart';
import '../../util/app_textBox.dart';
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
                  Get.to(() => PrepaidCardOfferListScreen(
                    cardId: cardDetailsData.id!,
                  ));
                },
                child: Container(
                  width: screenWidth - 30,
                  height: 50,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primaryColor,primaryColor],
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
                            color: secondaryColor),
                      )),
                ),
              ),
              SizedBox(
                height: 12,
              ),
        GestureDetector(onTap: (){
       //_applyCardApplyCouponCode();
            Get.to(()=>  ApplyKycScreen(razorPayId: "", cardId: cardDetailsData.id.toString(), firstName: "", lastName: "", panNumber: "", tx_id:0)) ;


        },
          child: Container(
            height: 50,
            width: screenWidth,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor,primaryColor ],
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
                    color: secondaryColor),
              ),
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
  String globalRefReferralCode = '';
  Future<bool> _validateCouponCode(String code) async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (code.isNotEmpty) {
      // bool b = await _walletBloc.validate(selectedCard!.id.toString(), code);
      // if (!b) {
      //   snackBarMessage('Invalid coupon code');
      //   return false;
      // }
    }
    Get.close(1);
    return true;
  }
  String? validatePANCard(String value) {
    return value.isEmpty ||
        value.length != 10 ||
        !FormatAndValidate.alphaRegExp.hasMatch(value.substring(0,
            2)) //First three characters i.e. "XYZ" in the above PAN are alphabetic series running from AAA to ZZZ
        ||
        !FormatAndValidate.alphaRegExp.hasMatch(value.substring(
            3)) //Fourth character i.e. "P" stands for Individual status of applicant.
        ||
        !FormatAndValidate.alphaRegExp.hasMatch(value.substring(
            4)) //Fifth character i.e. "K" in the above PAN represents first character of the PAN holder's last name/surname.
        ||
        !FormatAndValidate.alphaRegExp.hasMatch(value.substring(4,
            8)) //Next four characters i.e. "8200" in the above PAN are sequential number running from 0001 to 9999.
        ||
        !FormatAndValidate.alphaRegExp.hasMatch(value.substring(
            9)) //Last character i.e. "S" in the above PAN is an alphabetic check digit.
        ? "Enter 10 digit valid PAN Card number"
        : null;
  }
  _applyCardApplyCouponCode({String? enteredCouponCode,String? enteredReferralCode}) {
    final TextFieldControl _textFieldControlEmail = TextFieldControl();
    final Rx<TextFieldControl> _textFieldControlFirstName =
        TextFieldControl().obs;
    final Rx<TextFieldControl> _textFieldControlLastName =
        TextFieldControl().obs;
    final TextFieldControl _textFieldControlPhoneNumber = TextFieldControl();
    final Rx<TextFieldControl> _textFieldControlCouponCode =
        TextFieldControl().obs;
    final Rx<TextFieldControl> _textFieldControlPan = TextFieldControl().obs;
    final Rx<TextFieldControl> _textFieldControlReferralCode =
        TextFieldControl().obs;

    _textFieldControlEmail.controller.text = UserModule.userEmail;
    _textFieldControlPhoneNumber.controller.text = UserModule.userMobile;
   // globalRefReferralCode = '';

    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: StatefulBuilder(
              builder: (context, setState) => SafeArea(
                child: Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: CloseButton()),
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.stretch,
                                  children: [
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "Hey, Your virtual card is ready in simple 3 Steps! ",
                                      style: TextStyle(
                                        color: secondaryColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Divider(
                                      height: 16,
                                    ),
                                    Text(
                                      '''Step 1 : Preliminary details
Step 2 : Payment Authorization
Step 3 : Address and the ID Details
At last, You will receive an OTP from the issuer to validate your mobile number. You may start using the virtual card after the OTP validation.''',
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 14,
                                        height: 1.5,
                                      ),
                                    ),
                                    Divider(
                                      height: 16,
                                    ),
                                    Text(
                                      "*** Make sure your PAN Number and the mobile number while registration to complete the onboarding.",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              'STEP 1 : Preliminary details',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Text(
                            'Name',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                          AppTextBox(
                            enabled: true,
                            textFieldControl: _textFieldControlFirstName.value,
                            hintText: 'First Name',
                            keyboardType: TextInputType.name,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Last name',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                          AppTextBox(
                            enabled: true,
                            textFieldControl: _textFieldControlLastName.value,
                            hintText: 'Last name',
                            keyboardType: TextInputType.name,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Email address',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                          AppTextBox(
                            textFieldControl: _textFieldControlEmail,
                            hintText: '',
                            enabled: false,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Phone Number',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                          AppTextBox(
                            textFieldControl: _textFieldControlPhoneNumber,
                            enabled: false,
                            hintText: '',
                            keyboardType: TextInputType.number,
                            prefixIcon: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '+91 -${UserModule.userMobile}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  // Icon(Icons .keyboard_arrow_down_rounded)
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          AppTextBox(
                            textFieldControl: _textFieldControlPan.value,
                            hintText: 'PAN',
                            textCapitalization: TextCapitalization.characters,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Coupon/Promo code',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              TextButton(
                                  onPressed: () async {
                                    // String? code = await Get.to(() =>
                                    //     // CouponCodeScreen(
                                    //     //     cardId: selectedCard!.id!)
                                    // );
                                 //   _textFieldControlCouponCode
                                       // .value.controller.text = code ?? '';
                                  },
                                  child: Text('Available coupons ')),
                            ],
                          ),
                          Obx(() => AppTextBox(
                            textFieldControl:
                            _textFieldControlCouponCode.value,
                            textCapitalization:
                            TextCapitalization.characters,
                            hintText:enteredCouponCode == null? 'Coupon code' : "${enteredCouponCode}",
                          )),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Referral Person Code',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Get.dialog(
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Material(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                          child: Padding(
                                            padding: const EdgeInsets.all(22),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  "Enter your referred person or friends referral code for availing the touch points both of you.",
                                                  // textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                ),
                                                SizedBox(
                                                  height: 16,
                                                ),
                                                CloseButton(color: primaryColor)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.info_outline_rounded),
                                color: Colors.grey,
                              )
                            ],
                          ),

                          Obx(
                                () => AppTextBox(
                              enabled: true,
                              textFieldControl:
                              _textFieldControlReferralCode.value,
                              hintText: enteredReferralCode == null ?'Referral person code' : "${enteredReferralCode}",
                              textCapitalization: TextCapitalization.characters,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                              onPressed: () async {
                                String pan =
                                    _textFieldControlPan.value.controller.text;
                                String? err = validatePANCard(pan);
                                if (err != null) {
                                  toastMessage(err);
                                  return;
                                }

                                String code = _textFieldControlCouponCode
                                    .value.controller.text;
                                bool b = await _validateCouponCode(code);
                                String firstName = _textFieldControlFirstName
                                    .value.controller.text;
                                String lastName = _textFieldControlLastName
                                    .value.controller.text;

                                if (b) {
                                  globalRefReferralCode =
                                      _textFieldControlReferralCode
                                          .value.controller.text
                                          .trim();
                                  // _applyCardGetTaxInfo(
                                  //     code, pan, firstName, lastName);
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  'Continue',
                                ),
                              ),
                            ),
                          )
                        ]),
                  ),
                ),
              ),
            ),
          );
        });
  }
  // _applyCardGetTaxInfo(
  //     String couponCode, String pan, String firstName, String lastName) async {
  //   ApplyCardTaxInfoResponse? taxData = await _walletBloc.getApplyCardTaxInfo({
  //     'account_id': User.userId,
  //     'card_id': selectedCard?.id,
  //     'name': firstName,
  //     //'name': User.userName,
  //     'email': User.userEmail,
  //     'phone_number': '+91-${User.userMobile}',
  //     'coupon_code': couponCode,
  //     'pan_number': pan,
  //     'last_name': lastName
  //   });
  //
  //   if (taxData != null && taxData.data != null) {
  //     AppDialogs.loading();
  //     StateCodeResponse? response = await _walletBloc.getStateList();
  //     AppDialogs.closeDialog();
  //
  //     if (response == null) return;
  //
  //     _applyCardTaxBottomSheet(couponCode, taxData.data!, response.data ?? [],
  //         panNumber: pan, firstName: firstName, lastName: lastName);
  //   }
  // }
}
