package node_service;

import android.app.IntentService;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.IBinder;

import androidx.annotation.Nullable;

import java.io.Serializable;

import static node_service.ApprovalActivity.NODE_REQUEST;
import static node_service.ApprovalActivity.VISITOR_ALLOWED;
import static node_service.ApprovalActivity.VISITOR_ALLOWED_EVERYTIME;
import static node_service.ApprovalActivity.VISITOR_REJECT;

public class NotificationIntentService extends IntentService {

    static NodeService nodeService;
    private NodeRequestPojo nodeRequestPojo;
    private ServiceConnection myConnection = new ServiceConnection() {
        @Override
        public void onServiceConnected(ComponentName name, IBinder service) {
            NodeService.MyBinder binder = (NodeService.MyBinder) service;
            nodeService = binder.getService();
        }

        @Override
        public void onServiceDisconnected(ComponentName name) {
            nodeService = null;
        }
    };

    /**
     * Creates an IntentService.  Invoked by your subclass's constructor.
     */
    public NotificationIntentService() {
        super("notificationIntentService");
    }

    public static void setNodeObject(Context nodeObject) {
        nodeService = (NodeService) nodeObject;
    }

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return super.onBind(intent);
    }

    @Override
    public void onCreate() {
        super.onCreate();
    }


    @Override
    protected void onHandleIntent(Intent intent) {

        if (intent != null) {


            Serializable nodeRequest = intent.getSerializableExtra(NODE_REQUEST);
            if (nodeRequest != null) {
                nodeRequestPojo = (NodeRequestPojo) nodeRequest;
            }
            switch (intent.getAction()) {
                case "allow":
                    memberAction(VISITOR_ALLOWED);
                    break;
                case "always_allow":
                    memberAction(VISITOR_ALLOWED_EVERYTIME);
                    break;
                case "reject":
                    memberAction(VISITOR_REJECT);
                    break;
                case "open":
                    openActivity(nodeRequestPojo);
                    break;
            }
        }

    }

    private void openActivity(NodeRequestPojo nodeRequestPojo) {
        Intent approvalActivity = new Intent(getApplicationContext(), ApprovalActivity.class);
        approvalActivity.putExtra("node_request", nodeRequestPojo);
        approvalActivity.setAction(Intent.ACTION_MAIN);
        approvalActivity.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK | Intent.FLAG_ACTIVITY_NEW_TASK);
        approvalActivity.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);

        startActivity(approvalActivity);
    }

    private void memberAction(int visitorAllowStatus) {
        FcmAcknowledge fcmAcknowledge = new FcmAcknowledge();
        if (visitorAllowStatus == VISITOR_ALLOWED) {
            fcmAcknowledge.approvalFlag = FcmAcknowledge.APPROVAL_FLAG.ALLOW;
        } else if (visitorAllowStatus == VISITOR_REJECT) {
            fcmAcknowledge.approvalFlag = FcmAcknowledge.APPROVAL_FLAG.REJECT;
        } else {
            fcmAcknowledge.approvalFlag = FcmAcknowledge.APPROVAL_FLAG.ALLOW_ALWAYS;
        }
        if (nodeService != null) {

            SocketResponsePojo socketResponsePojo = new SocketResponsePojo();
            socketResponsePojo.nodeRequestPojo = nodeRequestPojo;
            if (fcmAcknowledge.approvalFlag == FcmAcknowledge.APPROVAL_FLAG.ALLOW) {
                socketResponsePojo.status = "allowed";
                socketResponsePojo.state = 1;
            } else if (fcmAcknowledge.approvalFlag == FcmAcknowledge.APPROVAL_FLAG.ALLOW_ALWAYS) {
                socketResponsePojo.status = "always_allowed";
                socketResponsePojo.state = 2;
            } else if (fcmAcknowledge.approvalFlag == FcmAcknowledge.APPROVAL_FLAG.REJECT) {
                socketResponsePojo.status = "denied";
                socketResponsePojo.state = 3;
            }
            nodeService.onEmit(socketResponsePojo);
        }

        Intent intent = new Intent(this, NodeService.class);
        stopService(intent);
    }


    @Override
    public void onDestroy() {
        super.onDestroy();
    }
}