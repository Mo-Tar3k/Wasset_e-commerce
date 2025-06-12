import 'package:e_commerce/features/add_products/core/repos/images_repo/images_dashboard_repo.dart';
import 'package:e_commerce/features/add_products/core/services/api_service_dashboard.dart';

class ImagesRepoImplDashboard implements ImagesRepoDashboard {
  // ignore: unused_field
  final ApiServiceDashboard _apiServiceDashboard;

  ImagesRepoImplDashboard(this._apiServiceDashboard);

  @override
  Future<void> uploadImage(String imagePath) async {
    // Implement the logic to upload an image using _apiService
    print('Uploading image: $imagePath');
  }

  @override
  Future<String> fetchImageUrl(String imageId) async {
    // Implement the logic to fetch image URL using _apiService
    print('Fetching image URL for ID: $imageId');
    return 'https://example.com/image/$imageId';
  }
}
