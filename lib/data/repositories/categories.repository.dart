import 'package:kushmarkets/constants/api.dart';
import 'package:kushmarkets/data/models/api_response.dart';
import 'package:kushmarkets/data/models/category.dart';
import 'package:kushmarkets/services/http.service.dart';
import 'package:kushmarkets/utils/api_response.utils.dart';

class CategoryRepository extends HttpService {
  //get vendors from server base on the type
  Future<List<Category>> getCategories() async {
    List<Category> categories = [];

    //make http call for vendors data
    final apiResult = await get(Api.categories);

    // print("Api result ==> ${apiResult.data}");
    //format the resposne
    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);
    if (!apiResponse.allGood) {
      throw apiResponse.errors;
    }

    // print("About to collect");
    //convert the data to list of category model
    (apiResponse.body as List).forEach((categoryJSONObject) {
      //vendor data
      categories.add(Category.fromJSON(categoryJSONObject));
    });

    return categories;
  }
}
