

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

import '../../bloc/walletbloc/wlalet.dart';
import '../../models/getcardlistresp.dart';
import '../../models/getoffer.dart';
import '../../network/api_response.dart';
import '../../util/CustomLoader/commomapiloader.dart';
import '../../util/commonappbar.dart';
import '../../util/coomonapierror.dart';
import '../../util/coomonresult.dart';
import '../../util/user.dart';


class PrepaidCardOfferListScreen extends StatefulWidget {
  const PrepaidCardOfferListScreen({Key? key, required this.cardId}) : super(key: key);
  final int cardId;

  @override
  State<PrepaidCardOfferListScreen> createState() => _PrepaidCardOfferListScreenState();
}

class _PrepaidCardOfferListScreenState extends State<PrepaidCardOfferListScreen> {
  WalletBloc _walletBloc = WalletBloc();
  String viewExpand = "More";

  @override
  void initState() {
    super.initState();
    _getCardOffersList();
  }

  Future _getCardOffersList() async {
    _walletBloc.getCardOfferList(widget.cardId);
  }

  @override
  void dispose() {
    //_walletBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CommonAppBarWidget(
        onPressedFunction: (){
          Get.back();
        },
        image: UserModule.userImageUrl,
      ),      body: _applyCard(),
    );
  }

  Widget _applyCard() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            "Prepaid cards Offers",
            style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: StreamBuilder<ApiResponse<dynamic>>(
              stream: _walletBloc.getCardOfferListStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data!.status!) {
                    case Status.LOADING:
                      return Center(child: CommonApiLoader());
                    case Status.COMPLETED:
                      GetAllAvailableCardListResponse response = snapshot.data!.data!;
                      if((response.cards ??[]).isEmpty) {
                        return Center(
                            widthFactor: 2,
                            heightFactor: 2,
                            child: CommonApiResultsEmptyWidget('No offers to show'));
                      }
                      return ListView.builder(
                          primary: true,
                          shrinkWrap: true,
                          itemCount: (response.cards ??[]).length,
                          itemBuilder: ((context, index) {

                            return _cardOffersList(response.cards![index]);
                          }));
                    case Status.ERROR:
                      return CommonApiErrorWidget(
                          "${snapshot.data!.message!}", _getCardOffersList());
                  }
                }
                return SizedBox();
              }),
        ),
      ],
    );
  }

  Widget _cardOffersList(Cards cardDetailsData) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
          side: BorderSide(width: 0, color: Colors.transparent),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CachedNetworkImage(
              fit: BoxFit.contain,
              imageUrl: cardDetailsData.imageUrl ?? "",
              imageBuilder: (context, imageProvider) => Container(
                height: 320,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  // color: Colors.black12,
                  image: DecorationImage(
                      image: imageProvider, fit: BoxFit.contain),
                ),
              ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => SizedBox(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              cardDetailsData.title!,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: HtmlWidget(
                cardDetailsData.longDescription!),
          ),

          // (viewExpand != 'More')
          //     ? Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(
          //     cardDetailsData.longDescription!,
          //     style: TextStyle(
          //         color: Colors.black54, fontSize: 14, height: 2),
          //   ),
          // )
          //     : Container(),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Container(),
          //     GestureDetector(
          //       onTap: () {
          //         viewExpand != 'More'
          //             ? viewExpand = 'More'
          //             : viewExpand = 'Less';
          //         setState(() {});
          //       },
          //       child: Padding(
          //         padding: const EdgeInsets.only(right: 10.0, bottom: 4),
          //         child: Text(
          //           viewExpand,
          //           style: TextStyle(
          //               color: primaryColor, fontWeight: FontWeight.w600),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
