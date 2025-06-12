abstract class ImagesRepoDashboard {
  Future<void> uploadImage(String imagePath);
  Future<String> fetchImageUrl(String imageId);
}
