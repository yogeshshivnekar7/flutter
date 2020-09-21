import 'dart:collection';
import 'dart:io';

import 'package:sso_futurescape/presentor/module/restaurant/restaurant_presenter.dart';
import 'package:sso_futurescape/presentor/module/sso/profile/profile_model.dart';
import 'package:sso_futurescape/presentor/module/sso/profile/profile_view.dart';

class ProfilePresenter extends ProfileModelResponse {
  ProfileResponseView profileResponseView;

  ProfileModel profileModel;

  ProfilePresenter(ProfileResponseView responseView) {
    this.profileResponseView = responseView;
    profileModel = new ProfileModel(this);
  }

  void getProfileDetails() {
    profileResponseView.showProgress();
    profileModel.getUserProfile();
  }

  void getProfileProgress() {
    profileResponseView.showProgress();
    profileModel.getUserProfileProgress();
  }

  void verifyEmail(String email) {
    profileResponseView.showProgress();
    profileModel.verifyEmail(email);
  }

  void verifyMobile(String mobile) {
    profileResponseView.showProgress();
    profileModel.verifyMobile(mobile);
  }

  @override
  void onSuccess(String success) {
    profileResponseView.hideProgress();
    profileResponseView.onSuccess(success);
  }

  @override
  void onFailure(String failure) {
    profileResponseView.hideProgress();
    profileResponseView.onFailure(failure);
  }

  @override
  void onError(String error) {
    profileResponseView.hideProgress();
    profileResponseView.onError(error);
    print("profile_presenter_error" + error);
  }

  void updateProfileDetails(
      HashMap<String, String> finalParam) {
    profileResponseView.showProgress();
    profileModel.updateUserProfile(finalParam);
  }

  void uploadProfileImage(String accessToken, File image) {
    profileResponseView.showProgress();
    profileModel.updateProfileImage(image);
  }

  void deleteAddress(String address_tag, success, failed) {
    /*
    profileResponseView.showProgress();
    profileModel.deleteUserAddress(address_tag);*/
    AddressModel().deleteAddress(address_tag, success, failed);


  }

  void addNewAddress(param) {
    profileResponseView.showProgress();
    profileModel.addNewAddress(param);
  }

  void getCountry() {
    profileResponseView.showProgress();
    profileModel.getCountry();
  }

  void getStates(String country_id) {
    profileResponseView.showProgress();
    profileModel.getStates(country_id);
  }

  @override
  void onProfileProgress(String success) {
    // TODO: implement onProfileProgress
    profileResponseView.hideProgress();
    profileResponseView.onProfileProgress(success);
  }

}
