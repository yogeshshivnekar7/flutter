import 'album_view.dart';
import 'list_album_model.dart';

class ListAlbumPresenter {
  AlbumListView albumListView;

  ListAlbumPresenter(albumView) {
    this.albumListView = albumView;
  }

  void getAlbumList(currentUnit, {String loadPage}) {
    ListAlbumModel model = new ListAlbumModel();
    model.listAlbums(currentUnit, albumListView, loadPage: loadPage);
  }

  void deleteAlbums(currentUnit, albumids, {String loadPage}) {
    ListAlbumModel model = new ListAlbumModel();
    model.deleteAlbums(currentUnit, albumids, albumListView,
        loadPage: loadPage);
  }

  void createAlbum(name, {String loadPage}) {
    ListAlbumModel model = new ListAlbumModel();
    model.createAlbum(name, albumListView, loadPage: loadPage);
  }
}
