package com.cubeone.app;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.os.PowerManager;
import android.provider.Settings;
import android.util.Log;

import androidx.core.content.ContextCompat;

import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;

import org.jetbrains.annotations.NotNull;

import java.util.Map;

import node_service.NodeService;

public class MyFirebaseService extends FirebaseMessagingService {

    private String TAG = "MyFirebaseService";
    private String online_order_notification_type = "Online Order";


    @Override
    public void onMessageReceived(RemoteMessage remoteMessage) {
        super.onMessageReceived(remoteMessage);
        try {
            Log.d(TAG, "remoteMessage: " + remoteMessage.getNotification().getTitle());
        } catch (Exception e) {
            e.printStackTrace();
        }

        try {
            Log.d(TAG, "Message data payload: " + remoteMessage.getData());
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (remoteMessage.getNotification() != null && remoteMessage.getNotification().getTitle() != null) {
            if (online_order_notification_type.equalsIgnoreCase(remoteMessage.getNotification().getTitle())) {
                handleNotifications(remoteMessage.getNotification(), remoteMessage.getData());
            } else {
                NotificationUtils.createNotification(getApplicationContext(), remoteMessage.getNotification().getTitle(), remoteMessage.getNotification().getBody(), "1234", R.drawable.oneapp_logo_notication, null, getIntent(remoteMessage.getData()));
            }
        } else {
            Map<String, String> data = remoteMessage.getData();
            Log.d(TAG, "Message data payload: " + remoteMessage.getData());
            if ("fcm_approval_type".equalsIgnoreCase(data.get("notification_type"))) {
                wakeUp();
                NotificationUtils.createNotification(getApplicationContext(), "Hey Member", "Someone is visiting to you", "1234", R.drawable.oneapp_logo_notication, null, null);
                String androidDeviceKey = Settings.Secure.getString(getApplication().getContentResolver(), Settings.Secure.ANDROID_ID);
                Log.e("NodeService", "androidDeviceKey -- " + androidDeviceKey);
                Intent nodeServiceIntent = new Intent(getApplicationContext(), NodeService.class);
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                    ContextCompat.startForegroundService(getApplicationContext(), nodeServiceIntent);
                } else {
                    startService(nodeServiceIntent);
                }
            }
        }
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

    void handleNotifications(RemoteMessage.Notification notification, Map<String, String> message) {
        String title = "order";
        String body = "body";
        String order_status = message.get("status");
        String delivery_status = message.get("delivery_status");
        Log.e(TAG, "online_status" + order_status);
        Log.e(TAG, "delivery" + delivery_status);
        try {
            if (order_status.equalsIgnoreCase("in process") && delivery_status.equalsIgnoreCase("undelivered")) {
                title = "Order confirmed";
                body = "Order has confirmed by restaurant in process.";
//            print('Order confirmed');
//            _showOnlineOrderNotificationWithSound(message);
                NotificationUtils.createNotification(getApplicationContext(), title, body, "1234", R.drawable.oneapp_logo_notication, null, getIntent(message));
            } else if (order_status.equalsIgnoreCase("in transit") &&
                    delivery_status.equalsIgnoreCase("dispatched")) {
                title = "Order Picked Up";
                body = "On the way";
//            print('Order Picked Up');
//            _showOnlineOrderNotificationWithSound(message);
                NotificationUtils.createNotification(getApplicationContext(), title, body, "1234", R.drawable.oneapp_logo_notication, null, getIntent(message));
            } else if ((order_status.equalsIgnoreCase("in transit") ||
                    order_status.equalsIgnoreCase("delivered") ||
                    order_status.equalsIgnoreCase("completed")) &&
                    delivery_status.equalsIgnoreCase("delivered")) {
                title = "Order Delivered";
                body = "Thank you for order!";
//            print('Order Delivered');
//            _showOnlineOrderNotificationWithSound(message);
                NotificationUtils.createNotification(getApplicationContext(), title, body, "1234", R.drawable.oneapp_logo_notication, null, getIntent(message));
            } else {
                if (notification != null)
                    NotificationUtils.createNotification(getApplicationContext(), notification.getTitle(), notification.getBody(), "1234", R.drawable.oneapp_logo_notication, null, getIntent(message));
            }
        } catch (Exception e) {
            if (notification != null)
                NotificationUtils.createNotification(getApplicationContext(), notification.getTitle(), notification.getBody(), "1234", R.drawable.oneapp_logo_notication, null, getIntent(message));
        }
//        print('delivery: $delivery_status');
    }

    @NotNull
    private Intent getIntent(Map<String, String> message) {
        Intent intent = new Intent(getApplicationContext(), MainActivity.class);
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_SINGLE_TOP);
        intent.addCategory(Intent.CATEGORY_LAUNCHER);
        intent.setAction(Intent.ACTION_MAIN);
        if (message != null) {
            for (String f : message.keySet()) {
                intent.putExtra(f, message.get(f));
            }
        }
        return intent;
    }


}
