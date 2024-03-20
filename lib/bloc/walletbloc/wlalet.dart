import 'dart:async';

import 'package:get/get.dart';
import 'package:prezentycardmodule/models/getcardlistresp.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/getoffer.dart';
import '../../models/regiwalletrespo.dart';
import '../../models/statecode.dart';
import '../../network/api_error_message.dart';
import '../../network/api_response.dart';
import '../../network/app_dialouges.dart';
import '../../repository/walletrepo.dart';
import '../../util/CustomLoader/loadmore.dart';


class WalletBloc {
  WalletRepository? _walletRepository;
//  WalletPaymentUpiResponse? walletPaymentUpiResponse;

  WalletBloc({this.listener}) {
    if (_walletRepository == null) _walletRepository = WalletRepository();
    _getAvailableCardListController =
    StreamController<ApiResponse<dynamic>>.broadcast();
    _getStateListController =
    StreamController<ApiResponse<StateCodeResponse>>.broadcast();
    _getCardOfferListController =
        StreamController<ApiResponse<GetAllAvailableCardListResponse>>();

  }

  bool isLoading = false;
  bool hasNextPage = true;
  int pageNumber = 0;
  int perPage = 20;
  Cards? walletDetailsData;

  LoadMoreListener? listener;
  //
  // late StreamController<ApiResponse<WalletStatementResponse>>
  // _statementController;
  //
  // StreamSink<ApiResponse<WalletStatementResponse>>? get stamementSink =>
  //     _statementController.sink;
  //
  // Stream<ApiResponse<WalletStatementResponse>> get statementStream =>
  //     _statementController.stream;
  //
  // List<Transactions> statementList = [];

//------------------------------------------------------------------------------
//   late StreamController<ApiResponse<StateCodeResponse>> _getStateListController;
//
//   StreamSink<ApiResponse<StateCodeResponse>> get _getStateListSink =>
//       _getStateListController.sink;
//
//   Stream<ApiResponse<StateCodeResponse>> get getStateListStream =>
//       _getStateListController.stream;

//------------------------------------------------------------------------------
  late StreamController<ApiResponse<dynamic>> _getAvailableCardListController;

  StreamSink<ApiResponse<dynamic>> get _getAvailableCardListSink =>
      _getAvailableCardListController.sink;

  Stream<ApiResponse<dynamic>> get getAvailableCardListStream =>
      _getAvailableCardListController.stream;
  //------------------------------------------------------------------------------
  late StreamController<ApiResponse<StateCodeResponse>> _getStateListController;

  StreamSink<ApiResponse<StateCodeResponse>> get _getStateListSink =>
      _getStateListController.sink;

  Stream<ApiResponse<StateCodeResponse>> get getStateListStream =>
      _getStateListController.stream;


//------------------------------------------------------------------------------
  late StreamController<ApiResponse<GetAllAvailableCardListResponse>>
  _getCardOfferListController;

  StreamSink<ApiResponse<GetAllAvailableCardListResponse>> get _getCardOfferListSink =>
      _getCardOfferListController.sink;

  Stream<ApiResponse<GetAllAvailableCardListResponse>> get getCardOfferListStream =>
      _getCardOfferListController.stream;

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//   late StreamController<ApiResponse<GetCardOffersResponse>>
//   _getCardOfferListController;
//
//   StreamSink<ApiResponse<GetCardOffersResponse>> get _getCardOfferListSink =>
//       _getCardOfferListController.sink;
//
//   Stream<ApiResponse<GetCardOffersResponse>> get getCardOfferListStream =>
//       _getCardOfferListController.stream;

//------------------------------------------------------------------------------
//   late StreamController<ApiResponse<WalletDetailsResponse>>
//   _getWalletDetailsController;
//
//   StreamSink<ApiResponse<WalletDetailsResponse>> get _getWalletDetailsSink =>
//       _getWalletDetailsController.sink;
//
//   Stream<ApiResponse<WalletDetailsResponse>> get getWalletDetailsStream =>
//       _getWalletDetailsController.stream;

//------------------------------------------------------------------------------
//
//   late StreamController<ApiResponse<OffersResponse>> _OfferListController;
//
//   StreamSink<ApiResponse<OffersResponse>> get OfferListSink =>
//       _OfferListController.sink;
//
//   Stream<ApiResponse<OffersResponse>> get OfferListStream =>
//       _OfferListController.stream;

  //------------------------------------------------------------------------------
  //
  // late StreamController<ApiResponse<CouponListingModel>> _CouponListController;
  //
  // StreamSink<ApiResponse<CouponListingModel>> get _CouponListSink =>
  //     _CouponListController.sink;
  //
  // Stream<ApiResponse<CouponListingModel>> get CouponListStream =>
  //     _CouponListController.stream;

//------------------------------------------------------------------------------

  //late StreamController<ApiResponse<TouchPointsModel>> _TouchPointsController;
  //
  // StreamSink<ApiResponse<TouchPointsModel>> get _TouchPointSink =>
  //     _TouchPointsController.sink;
  //
  // Stream<ApiResponse<TouchPointsModel>> get TouchPointStream =>
  //     _TouchPointsController.stream;

//------------------------------------------------------------------------------
//   late StreamController<ApiResponse<TouchPointsEarningHistoryModel>>
//   _TouchPointsEarningHistoryController;
//
//   StreamSink<ApiResponse<TouchPointsEarningHistoryModel>>
//   get _TouchPointEarningHistorySink =>
//       _TouchPointsEarningHistoryController.sink;
//
//   Stream<ApiResponse<TouchPointsEarningHistoryModel>>
//   get TouchPointEarningHistoryStream =>
//       _TouchPointsEarningHistoryController.stream;

//------------------------------------------------------------------------------

//   late StreamController<ApiResponse<TouchPointsRedemptionHistoryModel>>
//   _TouchPointsRedemptionHistoryController;
//
//   StreamSink<ApiResponse<TouchPointsRedemptionHistoryModel>>
//   get _TouchPointRedemptionHistorySink =>
//       _TouchPointsRedemptionHistoryController.sink;
//
//   Stream<ApiResponse<TouchPointsRedemptionHistoryModel>>
//   get TouchPointRedemptionHistoryStream =>
//       _TouchPointsRedemptionHistoryController.stream;
//
// //------------------------------------------------------------------------------
//
//   late StreamController<ApiResponse<GetMerchantsListModel>>
//   _GetMerchantsListController;
//
//   StreamSink<ApiResponse<GetMerchantsListModel>> get _GetMerchantsListSink =>
//       _GetMerchantsListController.sink;
//
//   Stream<ApiResponse<GetMerchantsListModel>> get GetMerchantsListStream =>
//       _GetMerchantsListController.stream;
//
// //------------------------------------------------------------------------------
//
//   late StreamController<ApiResponse<ExistingPayeeModel>>
//   _getExistingPayeeController;
//
//   StreamSink<ApiResponse<ExistingPayeeModel>> get _getExistingPayeeSink =>
//       _getExistingPayeeController.sink;
//
//   Stream<ApiResponse<ExistingPayeeModel>> get getExistingPayeeStream =>
//       _getExistingPayeeController.stream;
//
// //------------------------------------------------------------------------------
//
//   late StreamController<ApiResponse<ExistingPayeeModel>>
//   _getFavouritePayeesListController;
//
//   StreamSink<ApiResponse<ExistingPayeeModel>> get _getFavouritePayeesListSink =>
//       _getFavouritePayeesListController.sink;
//
//   Stream<ApiResponse<ExistingPayeeModel>> get getFavouritePayeesListStream =>
//       _getFavouritePayeesListController.stream;
//
// //------------------------------------------------------------------------------
//
//   late StreamController<ApiResponse<LoadMoneyTransactionHistoryModel>>
//   _loadMoneyTransactionHistoryController;
//
//   StreamSink<ApiResponse<
//       LoadMoneyTransactionHistoryModel>> get _loadMoneyTransactionHistorySink =>
//       _loadMoneyTransactionHistoryController.sink;
//
//   Stream<ApiResponse<
//       LoadMoneyTransactionHistoryModel>> get loadMoneyTransactionHistoryStream =>
//       _loadMoneyTransactionHistoryController.stream;

//------------------------------------------------------------------------------



  getAvailableCardList() async {
    _getAvailableCardListSink.add(ApiResponse.loading('Fetching'));
    try {
      AppDialogs.loading();

      GetAllAvailableCardListResponse response =
      await _walletRepository!.getAllAvailableCardList();
      if (response.success ?? false) {
        _getAvailableCardListSink.add(ApiResponse.completed(response));
      } else {
        _getAvailableCardListSink
            .add(ApiResponse.error(response.message ?? 'Something went wrong'));
      }
    } catch (e, s) {
      Completer().completeError(e, s);
      _getAvailableCardListSink
          .add(ApiResponse.error(("ad")));
    } finally {
      Get.back();
    }
  }


  Future<StateCodeResponse?> getStateList() async {
    try {
      _getStateListSink.add(ApiResponse.loading('Fetching'));

      StateCodeResponse response = await _walletRepository!.getStateList();
      if (response.success ?? false) {
        _getStateListSink.add(ApiResponse.completed(response));
        return response;
      } else {
        _getStateListSink
            .add(ApiResponse.error(response.message ?? 'Something went wrong'));
      }
    } catch (e, s) {
      Completer().completeError(e, s);
      _getStateListSink
          .add(ApiResponse.error("cx"));
    }
    return null;
  }
  Future<RegisterWalletResponse> registerWallet(Map<String, dynamic> body) async {
    try {
      RegisterWalletResponse response =
      await _walletRepository!.registerWallet(body);
      return response;
    } catch (e, s) {
      Completer().completeError(e, s);
      throw e;
    }
  }



  getCardOfferList(int cardId) async {
    try {
      _getCardOfferListSink.add(ApiResponse.loading('Fetching'));

      GetAllAvailableCardListResponse response =
      await _walletRepository!.GetCardOffers(cardId);
      if (response.success ?? false) {
        _getCardOfferListSink.add(ApiResponse.completed(response));
      } else {
        _getCardOfferListSink
            .add(ApiResponse.error(response.message ?? 'Something went wrong'));
      }
    } catch (e, s) {
      Completer().completeError(e, s);
      _getCardOfferListSink
          .add(ApiResponse.error("d"));
    }
  }
}