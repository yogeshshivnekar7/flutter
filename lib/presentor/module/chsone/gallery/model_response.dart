abstract class RequestAlbumModelResponse {
  void onSuccessAlbums(response);

  void onError(String response);

  void onFailure(String response);
}

abstract class RequestAddAlbumModelResponse {
  void onSuccessAddAlbum(response);

  void onError(String response);

  void onFailure(String response);
}

abstract class RequestPhotoModelResponse {
  void onSuccessPhotos(response);

  void onError(String response);

  void onFailure(String response);
}

abstract class RequestAddPhotoModelResponse {
  void onSuccessAddPhoto(response);

  void onError(String response);

  void onFailure(String response);
}
