package node_service;

import android.content.Context;
import android.content.Intent;
import android.util.Log;

import com.google.gson.Gson;

import org.json.JSONException;
import org.json.JSONObject;

import io.socket.emitter.Emitter;


public class NotifyMemberApproval implements Emitter.Listener {

    public static final String MEMBER_APPROVAL_REQUEST = "com.chsone.vizlog.member.approval_request";
    private final Context context;
//    private final ISocketEmitter iSocketEmitter;

    public NotifyMemberApproval(Context applicationContext) {
        this.context = applicationContext;
//        this.iSocketEmitter = iSocketEmitter;
    }

    @Override
    public void call(Object... args) {
        try {
            Log.e("TAG", args[0].toString());
            JSONObject js = new JSONObject(args[0].toString());
            JSONObject data = (JSONObject) js.get("data");
            NodeRequestPojo nodeRequestPojo = new Gson().fromJson(data.toString(), NodeRequestPojo.class);
            Intent intent = new Intent();
            intent.putExtra("node_request", nodeRequestPojo);

//            intent.putExtra(AppConstant.SOCKET_EMITTER, iSocketEmitter);
            intent.setAction(MEMBER_APPROVAL_REQUEST);
//            intent.setAction(Intent.ACTION_NEW_OUTGOING_CALL);

            context.sendBroadcast(intent);

//            Intent approvalActivity = new Intent();
//            approvalActivity.setClassName("com.cubeone.app", "node_service.ApprovalActivity");
////                NodeRequestPojo visitorApprovalPojo = (NodeRequestPojo) extras.get("node_request");
//                approvalActivity.putExtra("node_request", nodeRequestPojo);
//                approvalActivity.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK|Intent.FLAG_ACTIVITY_CLEAR_TASK);
//
//                context.startActivity(approvalActivity);

        } catch (JSONException e) {
            e.printStackTrace();
        }
//        Log.e("NOtifyMember",new Gson().toJson(args[0]));
//        String received = (String) args[0];
//        NodeRequestPojo nodeRequestPojo = new Gson().fromJson(received,NodeRequestPojo.class);


    }

}
