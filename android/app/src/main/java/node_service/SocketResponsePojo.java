package node_service;

import com.google.gson.annotations.SerializedName;

public class SocketResponsePojo {
    @SerializedName("status")
    public String status;
    @SerializedName("state")
    public int state;
    @SerializedName("data")
    public NodeRequestPojo nodeRequestPojo;
}
