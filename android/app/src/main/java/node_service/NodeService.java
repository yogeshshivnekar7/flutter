package node_service;

import android.annotation.SuppressLint;
import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Bitmap;
import android.graphics.Color;
import android.graphics.PixelFormat;
import android.media.AudioManager;
import android.media.MediaPlayer;
import android.media.RingtoneManager;
import android.os.Binder;
import android.os.Build;
import android.os.IBinder;
import android.os.PowerManager;
import android.provider.Settings;
import android.util.Log;
import android.view.Window;
import android.view.WindowManager;

import androidx.annotation.NonNull;
import androidx.core.app.NotificationCompat;

import com.cubeone.app.R;
import com.google.gson.Gson;

import org.json.JSONObject;

import java.net.URISyntaxException;
import java.util.concurrent.TimeUnit;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

import io.socket.client.IO;
import io.socket.client.Socket;
import io.socket.emitter.Emitter;
import okhttp3.Call;
import okhttp3.OkHttpClient;

import static node_service.AppConstant.NOODE_URL_KEY;
import static node_service.AppConstant.PREFERNCE_KEY;
import static node_service.AppConstant.PRIVATE_MODE;
import static node_service.ApprovalActivity.NODE_REQUEST;

/**
 * Created by rahul on 31/1/18.
 * NodeService
 */
public class NodeService extends Service implements ISocketEmitter {
    //    private Integer companyId = 1094;
    public static MediaPlayer mMediaPlayer;
    //      final String NODE_SERVER_URL = "http://notifications.vezaone.com";
    //final String NODE_SERVER_URL = "http://192.168.1.22:4000";
//    final String NODE_SERVER_URL = "https://stgvisitapi.cubeone.biz/";

    //    final String NODE_SERVER_URL = "http://testrealtime.vizitorlog.com/";
    final String ASK_MEMBER_APPROVAL = "ask_member_approval";//member listen
    final String MEMBER_APPROVAL = "member_approval";//emit
    NotifyMemberApproval notifyMemberApproval;
    private Socket mSocket;
    private NotificationManager notificationManager;
    private int NOTIFICATION_ID = 4500;
    private int counter = 0;

    @Override
    public IBinder onBind(Intent intent) {
        return new MyBinder();
    }

    @Override
    public void onCreate() {
        super.onCreate();
        if (Build.VERSION.SDK_INT >= 26) {
            String NOTIFICATION_CHANNEL_ID = "com.example.simpleapp";
            String channelName = "Gate security service";
            NotificationChannel chan = new NotificationChannel(NOTIFICATION_CHANNEL_ID, channelName, NotificationManager.IMPORTANCE_NONE);
            chan.setLightColor(Color.BLUE);
            //chan.setDescription("sfsdfdsfdfg");
            chan.setLockscreenVisibility(Notification.VISIBILITY_PRIVATE);
            NotificationManager manager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
            assert manager != null;
            manager.createNotificationChannel(chan);

            NotificationCompat.Builder notificationBuilder = new NotificationCompat.Builder(this, NOTIFICATION_CHANNEL_ID);
            Notification notification = notificationBuilder.setOngoing(true)
                    .setSmallIcon(R.mipmap.ic_launcher)
                    .setContentTitle("One Gate")
                    .setContentText("One Gate security is running")
                    .setPriority(NotificationManager.IMPORTANCE_MIN)
                    .setCategory(Notification.CATEGORY_SERVICE)

                    .build();

            startForeground(NOTIFICATION_ID, notification);


        }

        connectSocket();
    }

    private void connectSocket() {
        try {
            SharedPreferences sharedPreferences = getApplicationContext().getSharedPreferences(PREFERNCE_KEY, PRIVATE_MODE);
            String nodeUrl = sharedPreferences.getString(NOODE_URL_KEY, "");
            Log.e("NODE", nodeUrl);

//            if (mSocket == null || !mSocket.connected()) {
            IO.Options opts = new IO.Options();
            opts.forceNew = true;
            /*opts.reconnection=false;*/
            opts.reconnectionDelay = 5000;
            opts.timeout = 30000;
            /* opts.transports = new String[]{WebSocket.NAME};*/
            Call.Factory okHttpClient = getOkHttpClient(); //new OkHttpClient.Builder().build();
            opts.callFactory = okHttpClient;
            String androidDeviceKey = Settings.Secure.getString(getApplication().getContentResolver(), Settings.Secure.ANDROID_ID);
            Log.e("NodeService", "androidDeviceKey -- " + androidDeviceKey);
            opts.query =
                        /*"company_id=" + companyId
                        + "&" +*/
                    "device_id=" + androidDeviceKey;
            mSocket = IO.socket(nodeUrl, opts);
            Log.e("NODE_SERVICE", "NODE_SERVER_URL -- " + nodeUrl + opts.query);
            getNotifyMethods();
            mSocket.on(Socket.EVENT_CONNECT, new OnConnectD(Socket.EVENT_CONNECT));
            mSocket.on(Socket.EVENT_CONNECTING, new OnConnectD(Socket.EVENT_CONNECTING));
            mSocket.on(Socket.EVENT_DISCONNECT, new OnConnectD(Socket.EVENT_DISCONNECT));
            mSocket.on(Socket.EVENT_ERROR, new OnConnectD(Socket.EVENT_ERROR));
            mSocket.on(Socket.EVENT_CONNECT_ERROR, new OnConnectD(Socket.EVENT_CONNECT_ERROR));
            mSocket.on(Socket.EVENT_CONNECT_TIMEOUT, new OnConnectD(Socket.EVENT_CONNECT_TIMEOUT));
            mSocket.on(Socket.EVENT_RECONNECT, new OnConnectD(Socket.EVENT_RECONNECT));
            mSocket.on(Socket.EVENT_RECONNECTING, new OnConnectD(Socket.EVENT_RECONNECTING));
            mSocket.on(Socket.EVENT_RECONNECT_ERROR, new OnConnectD(Socket.EVENT_RECONNECT_ERROR));
            mSocket.on(Socket.EVENT_RECONNECT_FAILED, new OnConnectD(Socket.EVENT_RECONNECT_FAILED));
            mSocket.on(Socket.EVENT_RECONNECT_ATTEMPT, new OnConnectD(Socket.EVENT_RECONNECT_ATTEMPT));
            mSocket.on(Socket.EVENT_PING, new OnConnectD(Socket.EVENT_PING));
            mSocket.on(Socket.EVENT_PONG, new OnConnectD(Socket.EVENT_PONG));
            mSocket.connect();
//            }
           /* Thread thread = new Thread(new Runnable() {
                @Override
                public void run() {
                    try {
                        Thread.sleep(1000);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                    Log.e("time", String.valueOf(new Date().getTime()));
                }
            });
            thread.start();*/
            //  Log.i("notify", new Gson().toJson(mSocket));
        } catch (URISyntaxException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public OkHttpClient getOkHttpClient() {

        try {
//            if (okHttpClient == null) {
// Create a trust manager that does not validate certificate chains
            final TrustManager[] trustAllCerts = new TrustManager[]{
                    new X509TrustManager() {
                        @Override
                        public void checkClientTrusted(java.security.cert.X509Certificate[] chain, String authType) {
                        }

                        @Override
                        public void checkServerTrusted(java.security.cert.X509Certificate[] chain, String authType) {
                        }

                        @Override
                        public java.security.cert.X509Certificate[] getAcceptedIssuers() {
                            return new java.security.cert.X509Certificate[]{};
                        }
                    }
            };

// Install the all-trusting trust manager
            final SSLContext sslContext = SSLContext.getInstance("SSL");
            sslContext.init(null, trustAllCerts, new java.security.SecureRandom());
// Create an ssl socket factory with our all-trusting manager
            final SSLSocketFactory sslSocketFactory = sslContext.getSocketFactory();

// OkHttpClient okHttpClient = new OkHttpClient();
//log.warn("Using the trustAllSslClient is highly discouraged and should not be used in Production!");
            OkHttpClient.Builder builder = new OkHttpClient.Builder();
            builder.sslSocketFactory(sslSocketFactory, (X509TrustManager) trustAllCerts[0]);
            builder.hostnameVerifier(new HostnameVerifier() {
                @Override
                public boolean verify(String hostname, SSLSession session) {
                    return true;
                }
            });
            builder.connectTimeout(30, TimeUnit.SECONDS);
            builder.writeTimeout(30, TimeUnit.SECONDS);
            builder.readTimeout(30, TimeUnit.SECONDS);
            return builder.build();
//return builder.build();

//            }
//            return okHttpClient;
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    private void getNotifyMethods() {
//        mSocket.on(ASK_MEMBER_APPROVAL, notifyMemberApproval = new NotifyMemberApproval(getApplicationContext()));
        mSocket.on(ASK_MEMBER_APPROVAL, new Emitter.Listener() {
            @Override
            public void call(Object... args) {
                try {
                    try {
                        wakeUp();
                        mMediaPlayer = new MediaPlayer();
                        mMediaPlayer.setDataSource(getApplicationContext(), RingtoneManager.getDefaultUri(RingtoneManager.TYPE_ALL));
                        mMediaPlayer.setAudioStreamType(AudioManager.STREAM_RING);
                        mMediaPlayer.prepare();
                        mMediaPlayer.start();
                    } catch (Exception e) {

                    }

                    JSONObject js = new JSONObject(args[0].toString());
                    JSONObject data = (JSONObject) js.get("data");
                    NodeRequestPojo nodeRequestPojo = new Gson().fromJson(data.toString(), NodeRequestPojo.class);
                    Log.e("TAG", args[0].toString());

                  /*  Intent fullScreenIntent =new Intent(NodeService.this, ApprovalActivity.class);
                    fullScreenIntent.putExtra("node_request", nodeRequestPojo);
                    PendingIntent fullScreenPendingIntent = PendingIntent.getActivity(NodeService.this, 1,
                            fullScreenIntent, PendingIntent.FLAG_UPDATE_CURRENT);
                    fullScreenPendingIntent.send();

                    NotificationCompat.Builder notificationBuilder = new NotificationCompat.Builder(NodeService.this, "adva").
                            setPriority(NotificationCompat.PRIORITY_HIGH)
                            .setCategory(NotificationCompat.CATEGORY_CALL).setSmallIcon(R.drawable.notification_icon).setContentText("asdaa").setContentTitle("test")
                            .setFullScreenIntent(fullScreenPendingIntent, true);
                    NotificationManager mNotificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE); mNotificationManager.notify(0, notificationBuilder.build());
*/


//                     notification icon .setContentTitle("Notification!") // title for notification .setContentText("Hello word") // message for notification .setAutoCancel(true); // clear notification after click Intent intent = new Intent(this, MainActivity.class); PendingIntent pi = PendingIntent.getActivity(this,0,intent,Intent.FLAG_ACTIVITY_NEW_TASK); mBuilder.setContentIntent(pi);


//                    Intent approvalActivity = new Intent();
                    Intent approvalActivity = new Intent(NodeService.this, ApprovalActivity.class);
//                    approvalActivity.setClassName("com.cubeone.app", "node_service.ApprovalActivity");
//                NodeRequestPojo visitorApprovalPojo = (NodeRequestPojo) extras.get("node_request");
                    approvalActivity.putExtra("node_request", nodeRequestPojo);
                    approvalActivity.setAction(Intent.ACTION_MAIN);
                    approvalActivity.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK | Intent.FLAG_ACTIVITY_NEW_TASK);
                    approvalActivity.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                    getNotification(getApplicationContext(), "New Visitor", "You have visitor " + nodeRequestPojo.approvalPojo.getVisitorName() + " from " + nodeRequestPojo.approvalPojo.getCommingFrom(), "123234", approvalActivity, nodeRequestPojo);
//                    approvalActivity.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK|Intent.FLAG_ACTIVITY_CLEAR_TASK);
                    startActivity(approvalActivity);
                } catch (Exception e) {
                    e.printStackTrace();
                }


            }
        });
    }

    void wakeUp() {
        try {

            PowerManager pm = (PowerManager) getApplicationContext().getSystemService(Context.POWER_SERVICE);
            boolean isScreenOn = pm.isScreenOn();
//        Log.e("screen on.................................", ""+isScreenOn);
            if (!isScreenOn) {
                @SuppressLint("InvalidWakeLockTag") PowerManager.WakeLock wl = pm.newWakeLock(PowerManager.FULL_WAKE_LOCK | PowerManager.ACQUIRE_CAUSES_WAKEUP | PowerManager.ON_AFTER_RELEASE, "MyLock");
                wl.acquire(10000);
                @SuppressLint("InvalidWakeLockTag") PowerManager.WakeLock wl_cpu = pm.newWakeLock(PowerManager.PARTIAL_WAKE_LOCK, "MyCpuLock");
                wl_cpu.acquire(10000);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }


    private Notification getNotification(Context context, @NonNull String title, @NonNull String message, String notification_id, Intent approvalActivity, NodeRequestPojo nodeRequestPojo) {
        //  String notification_id = context.getString(R.string.default_notification_channel_id); // default_channel_id
        //  String message = context.getString(R.string.default_notification_channel_title); // Default Channel
//        Intent intent2;
        new NotificationHandlerThread().start();
        NotificationCompat.Builder builder;
        NotificationManager notifyManager = (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);

        final int ic_popup_reminder = android.R.drawable.ic_popup_reminder;
        NotificationIntentService.setNodeObject(this);

        Bitmap bitmap = null;


        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            int importance = NotificationManager.IMPORTANCE_HIGH;
            NotificationChannel mChannel = notifyManager.getNotificationChannel(notification_id);
            if (mChannel == null) {
                mChannel = new NotificationChannel(notification_id, message, importance);
                mChannel.enableVibration(true);

                mChannel.setVibrationPattern(new long[]{100, 200, 300, 400, 500, 400, 300, 200, 400});
                notifyManager.createNotificationChannel(mChannel);
            }
            builder = new NotificationCompat.Builder(context, notification_id);
//            intent2 = intent;
//            intent2.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_SINGLE_TOP);
//            pendingIntent = PendingIntent.getActivity(context, 0, intent2, 0);
            builder.setContentTitle(title)                            // required
                    .setSmallIcon(ic_popup_reminder)   // required
                    .setContentText(message) // required
                    .setDefaults(NotificationCompat.DEFAULT_ALL)
                    .setPriority(NotificationCompat.PRIORITY_MAX)
                    .setAutoCancel(true).setWhen(0)
//                    .setTicker(title)
                    .setVibrate(new long[]{100, 200, 300, 400, 500, 400, 300, 200, 400});


//            PendingIntent pending = PendingIntent.getActivity(context, 0, approvalActivity, 0);

            Intent activityIntent = new Intent(context, NotificationIntentService.class);

            activityIntent.setAction("open");
            activityIntent.putExtra(NODE_REQUEST, nodeRequestPojo);
            PendingIntent activity = PendingIntent.getService(context, 0, activityIntent, PendingIntent.FLAG_UPDATE_CURRENT);

            Intent allowIntent = new Intent(context, NotificationIntentService.class);

            allowIntent.setAction("allow");
            allowIntent.putExtra(NODE_REQUEST, nodeRequestPojo);
            PendingIntent allow = PendingIntent.getService(context, 0, allowIntent, PendingIntent.FLAG_UPDATE_CURRENT);


            Intent alwaysallowIntent = new Intent(context, NotificationIntentService.class);
            alwaysallowIntent.setAction("always_allow");
            alwaysallowIntent.putExtra(NODE_REQUEST, nodeRequestPojo);
            PendingIntent alwaysAllow = PendingIntent.getService(context, 0, alwaysallowIntent, PendingIntent.FLAG_UPDATE_CURRENT);

            Intent rejectIntent = new Intent(context, NotificationIntentService.class);
            rejectIntent.setAction("reject");
            rejectIntent.putExtra(NODE_REQUEST, nodeRequestPojo);
            PendingIntent reject = PendingIntent.getService(context, 0, rejectIntent, PendingIntent.FLAG_UPDATE_CURRENT);

            builder.setContentIntent(activity);
            builder.addAction(android.R.drawable.ic_menu_view, "ALLOW", allow);
            builder.addAction(android.R.drawable.ic_delete, "ALWAYS ALLOW", alwaysAllow);
            builder.addAction(android.R.drawable.ic_delete, "REJECT", reject);
            if (bitmap != null) {
                builder.setLargeIcon(bitmap);
            }
        } else {
            builder = new NotificationCompat.Builder(context, notification_id);
//            intent2 = intent;
//            intent2.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_SINGLE_TOP);
//            pendingIntent = PendingIntent.getActivity(context, 0, intent2, 0);
            builder.setContentTitle(title)                            // required
                    .setSmallIcon(ic_popup_reminder)   // required
                    .setContentText(message) // required
                    .setDefaults(Notification.DEFAULT_ALL)
                    .setPriority(NotificationCompat.PRIORITY_MAX)
                    .setAutoCancel(true).setWhen(0)
//                    .setContentIntent(pendingIntent)
//                    .setTicker(title)
                    .setVibrate(new long[]{100, 200, 300, 400, 500, 400, 300, 200, 400});
//                    .setPriority(Notification.PRIORITY_HIGH);
            Intent activityIntent = new Intent(context, NotificationIntentService.class);

            activityIntent.setAction("open");
            activityIntent.putExtra(NODE_REQUEST, nodeRequestPojo);
            PendingIntent activity = PendingIntent.getService(context, 0, activityIntent, PendingIntent.FLAG_UPDATE_CURRENT);

            Intent allowIntent = new Intent(context, NotificationIntentService.class);

            allowIntent.setAction("allow");
            allowIntent.putExtra(NODE_REQUEST, nodeRequestPojo);
            PendingIntent allow = PendingIntent.getService(context, 0, allowIntent, PendingIntent.FLAG_UPDATE_CURRENT);


            Intent alwaysallowIntent = new Intent(context, NotificationIntentService.class);
            alwaysallowIntent.setAction("always_allow");
            alwaysallowIntent.putExtra(NODE_REQUEST, nodeRequestPojo);
            PendingIntent alwaysAllow = PendingIntent.getService(context, 0, alwaysallowIntent, PendingIntent.FLAG_UPDATE_CURRENT);

            Intent rejectIntent = new Intent(context, NotificationIntentService.class);
            rejectIntent.setAction("reject");
            rejectIntent.putExtra(NODE_REQUEST, nodeRequestPojo);
            PendingIntent reject = PendingIntent.getService(context, 0, rejectIntent, PendingIntent.FLAG_UPDATE_CURRENT);

            builder.setContentIntent(activity);
//            builder.setPriority(Notification.PRIORITY_MAX);
            builder.addAction(android.R.drawable.ic_menu_view, "ALLOW", allow);
            builder.addAction(android.R.drawable.ic_delete, "ALWAYS ALLOW", alwaysAllow);
            builder.addAction(android.R.drawable.ic_delete, "REJECT", reject);
            if (bitmap != null) {
                builder.setLargeIcon(bitmap);
            }
        }
//        notifyManager.notify(1, builder.build());
        startForeground(1, builder.build());

        return builder.build();
    }


    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        /*if (intent.getAction() != null) {
            stopForeground(true);
            stopSelf();
        }*/
        return START_STICKY;
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        if (mSocket != null) {
            mSocket.disconnect();
        }
        if (notificationManager != null) {
            this.stopForeground(true);
            notificationManager.cancel(NOTIFICATION_ID);
            Log.e("notificationManager", "mSocket notificationManager");
        }
    }

    @Override
    public void onEmit(SocketResponsePojo socketResponsePojo) {
        if (mSocket != null) {
            if (mMediaPlayer != null)
                mMediaPlayer.stop();
            String s = new Gson().toJson(socketResponsePojo);
            Log.e("Node servie --", "emit----------------- " + s);
            mSocket.emit(MEMBER_APPROVAL, s);
        }
    }

    class NotificationHandlerThread extends Thread {
        @Override
        public void run() {
            while (true) {
                try {
                    Thread.sleep(1000);

                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                counter++;
                if (counter == 30) {
                    counter = 0;
                    stopSelf();
                }

            }
        }
    }

    public class MyBinder extends Binder {
        public NodeService getService() {
            return NodeService.this;
        }
    }


}
