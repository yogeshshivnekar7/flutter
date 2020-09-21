import 'dart:io';
//import 'dart:html';
import 'list_photo_model.dart';
import 'package:sso_futurescape/presentor/module/chsone/gallery/photos_view.dart';

class ListPhotoPresenter {
  PhotoListView photoListView;

  ListPhotoPresenter(photoView) {
    this.photoListView = photoView;
  }

  void getPhotoList(currentUnit, albumid, {String loadPage}) {
    ListPhotoModel model = new ListPhotoModel();
    model.listPhotos(currentUnit, albumid, photoListView, loadPage: loadPage);
  }

  void uploadImage(albumid, File image) {
    //photoView.showProgress();
    ListPhotoModel model = new ListPhotoModel();
    model.uploadImage(albumid, image, photoListView);
  }
  
  void deletePhotos(currentUnit, photoids, {String loadPage}) {
    ListPhotoModel model = new ListPhotoModel();
    model.deletePhotos(currentUnit, photoids, photoListView,
        loadPage: loadPage);
  }
}
