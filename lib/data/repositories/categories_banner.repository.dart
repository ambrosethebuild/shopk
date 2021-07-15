import 'package:kushmarkets/constants/api.dart';
import 'package:kushmarkets/data/models/api_response.dart';
import 'package:kushmarkets/data/models/category_banner.dart';
import 'package:kushmarkets/services/http.service.dart';
import 'package:kushmarkets/utils/api_response.utils.dart';

class CategoryBannerRepository extends HttpService {
  //get vendors from server base on the type
  Future<List<CategoryBanner>> getBanners() async {
    List<CategoryBanner> banners = [];

    //make http call for vendors data
    final apiResult = await get(Api.banners);

    //format the resposne
    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);
    if (!apiResponse.allGood) {
      throw apiResponse.errors;
    }

    //convert the data to list of banner model
    (apiResponse.body as List).forEach((jsonObject) {
      banners.add(CategoryBanner.fromJSON(jsonObject));
    });

    return banners;
  }
}
