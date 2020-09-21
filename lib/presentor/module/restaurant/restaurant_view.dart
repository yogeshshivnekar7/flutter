abstract class RestaurantView {
  onRestaurantFound(var restaurant, {bool isLastRequest});

  onRestaurantURLFound(var restaurant, {String company_name});

  onError(var error);

  onFailure(var failed);

  void addressDeleted(var success);

  void addressDeletionFailed(var failed);

  clearList();
}
