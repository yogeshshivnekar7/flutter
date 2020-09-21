package node_service;

public class FcmAcknowledge {

    public Long memberId;

    public int buildingUnitId = 0;


    public APPROVAL_FLAG approvalFlag = APPROVAL_FLAG.NOTIFICATION_RECIEVED;

    public enum APPROVAL_FLAG {
        NOTIFICATION_RECIEVED, ALLOW, ALLOW_ALWAYS, REJECT
    }
}