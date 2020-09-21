package node_service;

import com.google.gson.annotations.SerializedName;

import java.io.Serializable;

public class NodeRequestPojo implements Serializable {
    @SerializedName("member_visitor_id")
    public long memberVisitorId;
    @SerializedName("gate_device_id")
    public String gateDeviceId;
    @SerializedName("unique_id")
    public String uniqueId;
    @SerializedName("company_id")
    public long companyId;
    @SerializedName("app_id")
    public long appId;
    public int status = 0;
    @SerializedName("visitor_details")
    public VisitorApprovalPojo approvalPojo;

}
