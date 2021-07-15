import 'package:kushmarkets/data/models/category_banner.dart';
import 'package:kushmarkets/data/repositories/categories_banner.repository.dart';
import 'package:kushmarkets/viewmodels/base.viewmodel.dart';

class BannerViewModel extends MyBaseViewModel {
  //BannerRepository instance
  CategoryBannerRepository _bannerRepository = CategoryBannerRepository();

  List<CategoryBanner> banners;

  //get all banners
  void fetchBanners() async {
    //add null data so listener can show shimmer widget to indicate loading
    setBusy(true);

    try {
      banners = await _bannerRepository.getBanners();
    } catch (error) {
      setError(error);
      print("Error getting banners ==> $error");
    }
    setBusy(false);
  }
}
