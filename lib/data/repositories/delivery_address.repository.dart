import 'package:kushmarkets/constants/api.dart';
import 'package:kushmarkets/constants/strings/profile/delivery_address.strings.dart';
import 'package:kushmarkets/constants/strings/profile/edit_delivery_address.strings.dart';
import 'package:kushmarkets/constants/strings/profile/new_delivery_address.strings.dart';
import 'package:kushmarkets/data/models/api_response.dart';
import 'package:kushmarkets/data/models/deliver_address.dart';
import 'package:kushmarkets/data/models/dialog_data.dart';
import 'package:kushmarkets/services/http.service.dart';
import 'package:kushmarkets/utils/api_response.utils.dart';

class DeliveryAddressRepository extends HttpService {
  //get vendors from server base on the type
  Future<List<DeliveryAddress>> myDeliveryAddresses({int vendorId}) async {
    //make http call for vendors data
    final apiResult = await get(
      Api.deliveryAddress,
      queryParameters: {
        "vendor_id": vendorId ?? "",
      },
    );

    //format the resposne
    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);
    if (!apiResponse.allGood) {
      throw apiResponse.errors;
    }

    //convert the data to list of delivery address model
    List<DeliveryAddress> deliveryAddresses = apiResponse.data
        .map((deliveryJSONObject) => DeliveryAddress.fromJSON(
              jsonObject: deliveryJSONObject,
            ))
        .toList();
    return deliveryAddresses;
  }

  //save user new delivery address
  Future<DialogData> saveDeliveryAddress({
    String name,
    bool isDefault = false,
    String address,
    double latitude,
    double longitude,
  }) async {
    //instance of the model to be returned
    final resultDialogData = DialogData();
    //make http call for vendors data
    final apiResult = await post(
      Api.deliveryAddress,
      {
        "name": name,
        "address": address,
        "is_default": isDefault,
        "latitude": latitude.toString(),
        "longitude": longitude.toString(),
      },
    );

    //format the resposne
    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);
    if (apiResponse.allGood) {
      resultDialogData.title = NewDeliveryaAddressStrings.processCompleteTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.successThenClosePage;
    } else {
      resultDialogData.title = NewDeliveryaAddressStrings.processFailedTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.failed;
    }

    return resultDialogData;
  }

  //delete selected delivery address
  Future<DialogData> deleteDeliveryAddress({
    DeliveryAddress deliveryAddress,
  }) async {
    //instance of the model to be returned
    final resultDialogData = DialogData();
    //make http call for vendors data
    final apiResult = await delete(
      "${Api.deliveryAddress}/${deliveryAddress.id}",
    );

    //format the resposne
    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);
    if (apiResponse.allGood) {
      resultDialogData.title = DeliveryaAddressStrings.processCompleteTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.success;
    } else {
      resultDialogData.title = DeliveryaAddressStrings.processFailedTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.failed;
    }

    return resultDialogData;
  }

  //update user delivery address
  Future<DialogData> updateDeliveryAddress({
    int deliveryAddressId,
    bool isDefault = false,
    String name,
    String address,
    double latitude,
    double longitude,
  }) async {
    //instance of the model to be returned
    final resultDialogData = DialogData();
    //make http call for vendors data
    final apiResult = await patch(
      "${Api.deliveryAddress}/${deliveryAddressId}",
      {
        "name": name,
        "is_default": isDefault,
        "address": address,
        "latitude": latitude.toString(),
        "longitude": longitude.toString(),
      },
    );

    //format the resposne
    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);
    if (apiResponse.allGood) {
      resultDialogData.title = EditDeliveryaAddressStrings.processCompleteTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.successThenClosePage;
    } else {
      resultDialogData.title = EditDeliveryaAddressStrings.processFailedTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.failed;
    }

    return resultDialogData;
  }

  //
  Future<DeliveryAddress> preselectDeliveryAddress({int vendorId}) async {
    //make http call for vendors data
    final apiResult = await get(
      Api.defaultDeliveryAddress,
      queryParameters: {
        "vendor_id": vendorId,
      },
    );

    //format the resposne
    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);
    if (!apiResponse.allGood) {
      throw apiResponse.errors;
    }

    //convert the data to list of delivery address model
    return DeliveryAddress.fromJSON(
      jsonObject: apiResponse.body,
    );
  }
}
