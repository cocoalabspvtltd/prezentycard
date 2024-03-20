
import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/getcardlistresp.dart';
import '../models/regiwalletrespo.dart';
import '../models/statecode.dart';
import '../network/api_provider.dart';
import '../network/api_provider_prepaid_cards.dart';
import '../network/apis.dart';

class WalletRepository{
  late ApiProvider apiClient;
  var _dio = Dio();

  WalletRepository() {
    apiClient = new ApiProvider();
  }
  Future<GetAllAvailableCardListResponse> getAllAvailableCardList(
      {String? CardId = null}) async {
    final response = await apiClient
        .getJsonInstance()
        .get('${Apis.getAllAvailableCardList}');
    return GetAllAvailableCardListResponse.fromJson(response.data);
  }

  Future<StateCodeResponse> getStateList() async {
    final response = await apiClient.getJsonInstance().get(
      '${Apis.getStateCode}',
    );
    return StateCodeResponse.fromJson(response.data);
  }
  Future<RegisterWalletResponse> registerWallet(Map<String, dynamic> body) async {
    Response response = await apiClient
        .getJsonInstance()
        .post(Apis.registerWallet, data: body);
    return RegisterWalletResponse.fromJson(jsonDecode(response.data));
  }

  Future<GetAllAvailableCardListResponse> GetCardOffers(int? cardId) async {
    final response = await apiClient
        .getJsonInstance()
        .get('api/prepaid-cards/offers/${cardId}/list', );
    return GetAllAvailableCardListResponse.fromJson(response.data);
  }
}