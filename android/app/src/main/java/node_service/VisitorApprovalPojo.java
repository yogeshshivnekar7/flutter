package node_service;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

import java.io.Serializable;

/**
 * Created by YogeshD on 19/2/19.
 */

public class VisitorApprovalPojo implements Serializable {


    public long id;

    @SerializedName("visitor_name")
    @Expose
    private String visitorName;
    @SerializedName("building_unit_id")
    @Expose
    private int buildingUnitId;
    @SerializedName("image_url")
    @Expose
    private String imageUrl;
    @SerializedName("unit_number")
    @Expose
    private String unitNumber;
    @SerializedName("visitor_type")
    @Expose
    private String visitorType;
    @SerializedName("coming_from")
    @Expose
    private String commingFrom;
    @SerializedName("mobile_number")
    @Expose
    private String mobileNumber;
    @SerializedName("gatekeeper_device_token")
    @Expose
    private String gatekeeperDeviceToken;
    @SerializedName("current_time")
    @Expose
    private String currentTime;
    @SerializedName("purpose")
    @Expose
    private String purpose;
    private int notificationID;

    public int getBuildingUnitId() {
        return buildingUnitId;
    }

    public void setBuildingUnitId(int buildingUnitId) {
        this.buildingUnitId = buildingUnitId;
    }

    public String getVisitorName() {
        return visitorName;
    }

    public void setVisitorName(String visitorName) {
        this.visitorName = visitorName;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getUnitNumber() {
        return unitNumber;
    }

    public void setUnitNumber(String unitNumber) {
        this.unitNumber = unitNumber;
    }

    public String getVisitorType() {
        return visitorType;
    }

    public void setVisitorType(String visitorType) {
        this.visitorType = visitorType;
    }

    public String getCommingFrom() {
        return commingFrom;
    }

    public void setCommingFrom(String commingFrom) {
        this.commingFrom = commingFrom;
    }

    public String getMobileNumber() {
        return mobileNumber;
    }

    public void setMobileNumber(String mobileNumber) {
        this.mobileNumber = mobileNumber;
    }

    public String getGatekeeperDeviceToken() {
        return gatekeeperDeviceToken;
    }

    public void setGatekeeperDeviceToken(String gatekeeperDeviceToken) {
        this.gatekeeperDeviceToken = gatekeeperDeviceToken;
    }

    public String getCurrentTime() {
        return currentTime;
    }

    public void setCurrentTime(String currentTime) {
        this.currentTime = currentTime;
    }

    public String getPurpose() {
        return purpose;
    }

    public void setPurpose(String purpose) {
        this.purpose = purpose;
    }

    public int getNotificationID() {
        return notificationID;
    }

    public void setNotificationID(int notificationID) {

        this.notificationID = notificationID;
    }
}