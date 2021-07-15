import 'package:kushmarkets/constants/api.dart';
import 'package:kushmarkets/data/models/api_response.dart';
import 'package:kushmarkets/data/models/currency.dart';
import 'package:kushmarkets/data/models/wallet.dart';
import 'package:kushmarkets/services/http.service.dart';
import 'package:kushmarkets/utils/api_response.utils.dart';

class WalletRepository extends HttpService {
  //get vendors from server base on the type
  Future<List<dynamic>> getWallet() async {
    //make http call for vendors data
    final apiResult = await get(Api.wallet);
    //format the resposne
    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);
    if (!apiResponse.allGood) {
      throw apiResponse.errors;
    }

    List<dynamic> data = [];
    data.add(
      Currency.fromJson(currencyJSONObject: apiResponse.body["currency"]),
    );
    data.add(Wallet.fromJson(apiResponse.body["wallet"]));
    return data;
  }

  //
  Future<ApiResponse> requestTopUp(dynamic amount) async {
    //make http call for vendors data
    final apiResult = await post(Api.wallet,{
      "amount": amount,
    });
    //
    //format the resposne
    return ApiResponseUtils.parseApiResponse(apiResult);
  }
}
