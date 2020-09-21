// import 'package:sso_futurescape/presentor/module/chsone/complaints/add_complaint_model.dart';
// import 'package:sso_futurescape/presentor/module/chsone/gallery/album_model.dart';
// import 'package:sso_futurescape/presentor/module/chsone/complaints/complaint_reply_model.dart';
import 'package:sso_futurescape/presentor/module/chsone/gallery/list_album_model.dart';

// import 'add_reply_model.dart';

import 'package:sso_futurescape/presentor/module/chsone/gallery/model_response.dart';

abstract class AlbumView extends RequestAlbumModelResponse {
  // onError(var error);

  // onFailure(var failed);

  // onSuccess(String response);
}

abstract class AddAlbumView extends RequestAddAlbumModelResponse {
  // onError(var error);

  // onFailure(var failed);

  // onSuccess(String response);
}

abstract class AlbumListView extends ListAlbumModelResponse {}

// abstract class AlbumReplyView extends AlbumReplyModelResponse {}

// abstract class AddReplyView extends RequestAddReplyModelResponse {}
