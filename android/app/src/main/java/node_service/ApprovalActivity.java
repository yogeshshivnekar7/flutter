package node_service;

import android.app.NotificationManager;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.media.AudioManager;
import android.media.MediaPlayer;
import android.media.Ringtone;
import android.media.RingtoneManager;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.IBinder;
import android.os.VibrationEffect;
import android.os.Vibrator;
import android.provider.Settings;
import android.util.Log;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

import com.cubeone.app.R;
import com.squareup.picasso.Picasso;

import java.io.Serializable;

import de.hdodenhof.circleimageview.CircleImageView;


public class ApprovalActivity extends AppCompatActivity {

    public static final String VISITOR_DATA = "VISITOR_DATA";
    public static final String NODE_REQUEST = "node_request";
    public static final int VISITOR_ALLOWED = 1;
    public static final int VISITOR_REJECT = 2;
    public static final int VISITOR_ALLOWED_EVERYTIME = 3;
    private static final String TAG = "ApprovalActivity";
    //    private ApprovalModel approvalModel;
    private static int counter = 0;
    //    private ISocketEmitter iSocketEmitter;
    NodeRequestPojo nodeRequestPojo;
    NodeService nodeService;
    private boolean isRequestRunning = false;
    private TextView tv_VisitorName;
    private ImageView imgv_allow;
    private ImageView imgv_reject;
    private ImageView imgv_allowEverytime;
    private VisitorApprovalPojo visitorPojo;
    private TextView edtComplexName;
    private TextView tv_unitNumber;
    private TextView tv_visitorType;
    private TextView tv_commingFrom;
    private CircleImageView caption_image;
    private TextView caption;
    private Ringtone ringtone;
    private Window window;
//    private MediaPlayer mMediaPlayer;
    private Vibrator vib;
//    private MediaPlayer player;
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
    //    private Handler handler;
    private TextView tv_purpose;
    private boolean threadOn = false;
    private Thread timer;

    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
//        approvalModel = ViewModelProviders.of(this).get(ApprovalModel.class);
        clearNotification();
        Log.e("NOTICAT", "always_allow");
        Intent intent1 = new Intent(ApprovalActivity.this, NodeService.class);
        stopService(intent1);
        if(NodeService.mMediaPlayer!=null && NodeService.mMediaPlayer.isPlaying()){
            NodeService.mMediaPlayer.stop();
            NodeService.mMediaPlayer.release();
            NodeService.mMediaPlayer=null;
        }
        setContentView(R.layout.activity_approval);
        init();
        Intent intent = getIntent();
        if (intent != null) {
            Serializable serializableExtra = intent.getSerializableExtra(VISITOR_DATA);
            if (serializableExtra != null) {
                visitorPojo = (VisitorApprovalPojo) serializableExtra;
            }

            Serializable nodeRequest = intent.getSerializableExtra(NODE_REQUEST);
            if (nodeRequest != null) {
                nodeRequestPojo = (NodeRequestPojo) nodeRequest;
                visitorPojo = nodeRequestPojo.approvalPojo;
            }
//            iSocketEmitter = (ISocketEmitter) intent.getSerializableExtra(AppConstant.SOCKET_EMITTER);
            setUIData(visitorPojo);
        }

    }

    private void clearNotification() {
//        int notificationId = getIntent().getIntExtra("notificationId", 0);

        NotificationManager manager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
        manager.cancel(123234);
    }

    private void startThread() {

        threadOn = true;
        if (timer == null || timer.isInterrupted()) {
            timer = new Thread(new Runnable() {
                @Override
                public void run() {
                    while (threadOn) {
                        Log.e(TAG, "counter ------------------------------- " + counter);
                        if (counter == 30) {
                            counter = 0;
                            stopRingtone();

                            finishActivity();
                            ApprovalActivity.this.finish();
                            return;
                        }

                        try {
                            if (!timer.isInterrupted()) {
                                Thread.sleep(1000);
                            }
                        } catch (InterruptedException e) {
                            e.printStackTrace();
                            stopRingtone();
                        }
                        counter++;
                    }
                }
            });
            timer.start();
        }

        setUpTone();
    }

    @Override
    public void onBackPressed() {
        //super.onBackPressed();

    }

    @Override
    protected void onResume() {
        super.onResume();
        Log.e(TAG, "------------------onResume ----------------------------- ");
        startThread();
       /* KeyguardManager manager = (KeyguardManager) this.getSystemService(Context.KEYGUARD_SERVICE);
        KeyguardManager.KeyguardLock lock = manager.newKeyguardLock("VizlogSocietyBuilding");
        lock.disableKeyguard();*/
       /* window = this.getWindow();
        window.addFlags(WindowManager.LayoutParams.FLAG_SHOW_WHEN_LOCKED | WindowManager.LayoutParams.FLAG_DISMISS_KEYGUARD);
        window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON | WindowManager.LayoutParams.FLAG_TURN_SCREEN_ON);
*/
        if (nodeService == null) {
            try {
                doBindService();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }


    public void doBindService() {
        Intent intent = new Intent(this, NodeService.class);
        bindService(intent, myConnection, Context.BIND_AUTO_CREATE);
    }

    @Override
    public void onAttachedToWindow() {
        Window window = getWindow();

        window.addFlags(WindowManager.LayoutParams.FLAG_TURN_SCREEN_ON
                | WindowManager.LayoutParams.FLAG_SHOW_WHEN_LOCKED
                | WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON
                | WindowManager.LayoutParams.FLAG_DISMISS_KEYGUARD
                | WindowManager.LayoutParams.FLAG_FULLSCREEN);

        super.onAttachedToWindow();
    }

    private void setUpTone() {
       /* Uri notification = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_RINGTONE);
        ringtone = RingtoneManager.getRingtone(getApplicationContext(), notification);
        ringtone.play();*/

//264116
        try {
            if(NodeService.mMediaPlayer==null) {
                NodeService.mMediaPlayer = new MediaPlayer();
                NodeService.mMediaPlayer.setDataSource(getApplicationContext(), RingtoneManager.getDefaultUri(RingtoneManager.TYPE_ALL));
                NodeService.mMediaPlayer.setAudioStreamType(AudioManager.STREAM_RING);
                NodeService.mMediaPlayer.prepare();
                NodeService.mMediaPlayer.start();
            }else {
                if(NodeService.mMediaPlayer.isPlaying()){
                    NodeService.mMediaPlayer.stop();
                    NodeService.mMediaPlayer=null;
                }
                NodeService.mMediaPlayer = new MediaPlayer();
                NodeService.mMediaPlayer.setDataSource(getApplicationContext(), RingtoneManager.getDefaultUri(RingtoneManager.TYPE_ALL));
                NodeService.mMediaPlayer.setAudioStreamType(AudioManager.STREAM_RING);
                NodeService.mMediaPlayer.prepare();
                NodeService.mMediaPlayer.start();
            }
//            Uri alert = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_ALL);
//
//            final AudioManager audioManager = (AudioManager) getSystemService(Context.AUDIO_SERVICE);
//
//            switch (audioManager.getRingerMode()) {
//                case AudioManager.RINGER_MODE_NORMAL:
//                    playRingtone(alert);
//                    break;
//                case AudioManager.RINGER_MODE_SILENT:
//                    customVibratePatternRepeat();
//                    break;
//                case AudioManager.RINGER_MODE_VIBRATE:
//                    customVibratePatternRepeat();
//                    break;
//                default:
//                    playRingtone(alert);
//                    break;
//            }


        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void setUIData(VisitorApprovalPojo visitorPojo) {
        try {
            tv_VisitorName.setText(visitorPojo.getVisitorName());
//            CompanyInfoModel companyInfoModel = AppStorage.getCompanyInfo(this);
//            if (companyInfoModel != null) {
//                edtComplexName.setText(companyInfoModel.getCompanyName());
//            } else {
//                edtComplexName.setText("Not Mention");
//            }

            if (visitorPojo.getPurpose() != null && !visitorPojo.getPurpose().isEmpty()) {
                tv_purpose.setText(capitalizeFirstLetter(visitorPojo.getPurpose()));
            } else {
                tv_purpose.setText("Not Mention");
            }
            tv_unitNumber.setText(visitorPojo.getUnitNumber());
            if (visitorPojo.getVisitorType() != null && !visitorPojo.getVisitorType().isEmpty()) {

                tv_visitorType.setText(capitalizeFirstLetter(visitorPojo.getVisitorType()));
            } else {
                tv_visitorType.setText("Visitor");
            }

            if (visitorPojo.getCommingFrom() != null && !visitorPojo.getCommingFrom().isEmpty()) {
                tv_commingFrom.setText(capitalizeFirstLetter(visitorPojo.getCommingFrom()));
            } else {
                tv_commingFrom.setText("Not Mention");
            }

            loadImage(visitorPojo);
        } catch (Exception e) {
            e.printStackTrace();
        }


    }

    private void playRingtone(Uri alert) {

       /* try {
            Log.i(TAG, "Playing ring");

            mMediaPlayer = new MediaPlayer();
            mMediaPlayer.setDataSource(this, alert);
            mMediaPlayer.setAudioStreamType(AudioManager.STREAM_RING);
            mMediaPlayer.setLooping(true);
            mMediaPlayer.prepare();
            mMediaPlayer.start();
        } catch (Exception e) {
            e.printStackTrace();
        }*/
//        player = MediaPlayer.create(this,
//                Settings.System.DEFAULT_RINGTONE_URI);
//        player.start();

    }

    private void customVibratePatternRepeat() {
        Log.i(TAG, "vibrating");
        vib = (Vibrator) getSystemService(Context.VIBRATOR_SERVICE);

        //vib.vibrate(500); //vibrate once only
        // 0 : Start without a delay
        // 400 : Vibrate for 400 milliseconds
        // 200 : Pause for 200 milliseconds
        // 400 : Vibrate for 400 milliseconds
        // long[] mVibratePattern = new long[]{2000, 100, 2000};
        long[] mVibratePattern = {1000, 1000, 1000, 1000, 1000};

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            vib.vibrate(VibrationEffect.createWaveform(mVibratePattern, 0));
        } else {
            //deprecated in API 26
            vib.vibrate(mVibratePattern, 0);
        }

        // -1 : Do not repeat this pattern
        // pass 0 if you want to repeat this pattern from 0th index

    }

    private void init() {
        tv_VisitorName = findViewById(R.id.tv_VisitorName);
        edtComplexName = findViewById(R.id.edtComplexName);
        tv_commingFrom = findViewById(R.id.tv_commingFrom);
        tv_unitNumber = findViewById(R.id.tv_unitNumber);
        tv_purpose = findViewById(R.id.tv_purpose);

        tv_visitorType = findViewById(R.id.tv_visitorType);
        caption_image = findViewById(R.id.caption_image);
        caption = findViewById(R.id.caption);

        imgv_allow = findViewById(R.id.imgv_allow);
        imgv_allow.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                memberAction(VISITOR_ALLOWED);
            }
        });
        imgv_reject = findViewById(R.id.imgv_reject);
        imgv_reject.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                memberAction(VISITOR_REJECT);
            }
        });
        imgv_allowEverytime = findViewById(R.id.imgv_allowEverytime);
        imgv_allowEverytime.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                memberAction(VISITOR_ALLOWED_EVERYTIME);
            }
        });
    }

    public void stopRingtone() {

        Log.i(TAG, "Stopping ringtone ");
       /* if (ringtone != null) {
            ringtone.stop();
        }*/

     /*   try {
            if (mMediaPlayer != null)
                mMediaPlayer.stop();
            else if (vib != null) {
                vib.cancel();
            }


        } catch (Exception e) {
            e.printStackTrace();
        }
*/
        try {
//
//            if (player != null)
//                player.stop();
            if(NodeService.mMediaPlayer!=null){
                NodeService.mMediaPlayer.stop();
            }
            if (vib != null)
                vib.cancel();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    private void memberAction(int visitorAllowStatus) {
        stopRingtone();
        FcmAcknowledge fcmAcknowledge = new FcmAcknowledge();
//        fcmAcknowledge.memberId = AppStorage.getUserProfileModel(this).users.visitorId;
//        fcmAcknowledge.buildingUnitId = visitorPojo.getBuildingUnitId();

        if (visitorAllowStatus == VISITOR_ALLOWED) {
            cancelNotification();
//            CenterToasty.success(getApplicationContext(), "Visitor Allowed").show();
//            CustomToastMsg.success(getApplicationContext(), "Visitor Allowed", CustomToastMsg.LENGTH_LONG);
            fcmAcknowledge.approvalFlag = FcmAcknowledge.APPROVAL_FLAG.ALLOW;
//            FCMNotificationSender.send(visitorPojo.getGatekeeperDeviceToken(), fcmAcknowledge, FCMNotificationSender.TYPE.approval_type);

        } else if (visitorAllowStatus == VISITOR_REJECT) {
            cancelNotification();
//            CustomToastMsg.error(getApplicationContext(), "Visitor Rejected", CustomToastMsg.LENGTH_LONG);
            fcmAcknowledge.approvalFlag = FcmAcknowledge.APPROVAL_FLAG.REJECT;
//            FCMNotificationSender.send(visitorPojo.getGatekeeperDeviceToken(), fcmAcknowledge, FCMNotificationSender.TYPE.approval_type);
        } else {
            cancelNotification();
//            CustomToastMsg.success(getApplicationContext(), "Visitor Allowed Everytime", CustomToastMsg.LENGTH_LONG);
            fcmAcknowledge.approvalFlag = FcmAcknowledge.APPROVAL_FLAG.ALLOW_ALWAYS;
//            FCMNotificationSender.send(visitorPojo.getGatekeeperDeviceToken(), fcmAcknowledge, FCMNotificationSender.TYPE.approval_type);
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

        finishActivity();
    }

    private void finishActivity() {
        Intent intent = new Intent(ApprovalActivity.this, NodeService.class);
        stopService(intent);
        ApprovalActivity.this.finish();
    }

    private void cancelNotification() {

        try {
            NotificationManager mNotificationManager =
                    (NotificationManager) getApplicationContext().getSystemService(Context.NOTIFICATION_SERVICE);
            mNotificationManager.cancel(visitorPojo.getNotificationID());
        } catch (Exception e) {
            e.printStackTrace();
        }

    }


    public String capitalizeFirstLetter(String inputString) {

        return inputString.substring(0, 1).toUpperCase() + inputString.substring(1);

    }

//    private void saveMissingApproval() {
//        approvalModel.saveMissingApproval(visitorPojo).observe(this, new Observer<VisitorApprovalPojo>() {
//            @Override
//            public void onChanged(@Nullable VisitorApprovalPojo visitorApprovalPojo) {
//
//                Log.i(TAG, " MissingApproval saved ");
//            }
//        });
//    }

    private void loadImage(final VisitorApprovalPojo visitorPojo) {
        if (visitorPojo.getImageUrl() == null || visitorPojo.getImageUrl().isEmpty()) {
            setTextOnImage(visitorPojo);
        } else {
            try {
                caption.setVisibility(View.GONE);
                Picasso.Builder builder = new Picasso.Builder(ApprovalActivity.this);
                builder.listener(new Picasso.Listener() {
                    @Override
                    public void onImageLoadFailed(Picasso picasso, Uri uri, Exception exception) {
                        String cationCode = visitorPojo.getVisitorName();
                        try {
                            char captionChar = cationCode.trim().toUpperCase().charAt(0);
                            caption.setText(String.valueOf(captionChar));
                            caption_image.setImageResource(AppConstant.getColor(captionChar));
                            caption.setVisibility(View.VISIBLE);
                        } catch (Exception e) {
                            caption.setText("#");
                            caption_image.setImageResource(AppConstant.getColor(' '));
                            caption.setVisibility(View.VISIBLE);
                            e.printStackTrace();
                        }
                        exception.printStackTrace();
                    }
                });
                builder.build().load(visitorPojo.getImageUrl()).resize(126, 126).into(caption_image);
            } catch (Exception e) {
                setTextOnImage(visitorPojo);
                Log.i("exception", e.getLocalizedMessage(), e);
            }
        }
    }

    private void setTextOnImage(VisitorApprovalPojo visitorPojo) {
        String cationCode = visitorPojo.getVisitorName();
        try {
            char captionChar = cationCode.trim().toUpperCase().charAt(0);
            caption.setText(String.valueOf(captionChar));


            if ("guest".equalsIgnoreCase(visitorPojo.getVisitorType())) {
                caption_image.setImageResource(R.color.visitor_color);
            } else if ("member".equalsIgnoreCase(visitorPojo.getVisitorType())) {
                caption_image.setImageResource(R.color.member_color);
            } else if ("staff".equalsIgnoreCase(visitorPojo.getVisitorType())) {
                caption_image.setImageResource(R.color.staff_color);
            }
        } catch (Exception e) {
            caption.setText("");
//            caption_image.setImageResource(AppConstant.getColor(' '));
            e.printStackTrace();
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        try {
            counter = 0;
            threadOn = false;
            timer.interrupt();
            timer = null;
            stopRingtone();
            Thread.sleep(1500);
            Log.e(TAG, "------------------onDestroy ----------------------------- ");
//            if (handler != null) {
//                handler.removeCallbacksAndMessages(null);
//            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void onStop() {
        super.onStop();
        try {
            stopRingtone();
//            if (handler != null) {
//                handler.removeCallbacksAndMessages(null);
//            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Override
    protected void onPause() {
        super.onPause();
//        timer.interrupt();
//        timer=null;
        if (nodeService != null) {
            unbindService(myConnection);
            nodeService = null;

        }
    }
}
