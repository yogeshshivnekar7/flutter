package node_service;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.media.MediaPlayer;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.widget.RemoteViews;

import androidx.annotation.NonNull;
import androidx.core.app.NotificationCompat;

import com.cubeone.app.R;

import static android.content.Context.NOTIFICATION_SERVICE;


public class ApprovalReceiver extends BroadcastReceiver {
    Handler callActionHandler = new Handler();
    private Context con;
    private Intent inte;

    /* Runnable runRingingActivity = new Runnable() {
         @Override
         public void run() {
             try {
                 mMediaPlayer = new MediaPlayer();
                 mMediaPlayer.setDataSource(con, RingtoneManager.getDefaultUri(RingtoneManager.TYPE_ALL));
                 mMediaPlayer.setAudioStreamType(AudioManager.STREAM_RING);
                 mMediaPlayer.prepare();
                 mMediaPlayer.start();
             } catch (Exception e) {

             }
             Bundle extras = inte.getExtras();
             NodeRequestPojo nodeRequestPojo = (NodeRequestPojo)extras.get("node_request");
             Intent de = new Intent(con, ApprovalActivity.class);
             de.putExtra(ApprovalActivity.NODE_REQUEST, nodeRequestPojo);
 //            getNotification(con,"New Visitor","You have visitor","1");
 //            openNotification();
             // context, title, message, notification_id, null, null, intent
             getNotification(con, "New Visitor", "You have visitor " + nodeRequestPojo.approvalPojo.getVisitorName() + " from " + nodeRequestPojo.approvalPojo.getCommingFrom(), "123234");
             Intent approvalActivity = new Intent("android.intent.action.MAIN");
             approvalActivity.setClassName("com.cubeone.app", "com.cubeone.app.MainActivity");
 //            Intent approvalActivity = new Intent(con, MainActivity.class);
 //            Bundle extras = inte.getExtras();
             if (extras != null) {
                 Log.e("ApprovalReceiver", "extras");
 //                openDialog();
                 NodeRequestPojo visitorApprovalPojo = (NodeRequestPojo) extras.get("node_request");
                 approvalActivity.putExtra("node_request", visitorApprovalPojo);
                 approvalActivity.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TASK);

                 con.startActivity(approvalActivity);

 //                PendingIntent pendingIntent = PendingIntent.getActivity(con, 0, approvalActivity, PendingIntent.FLAG_ONE_SHOT);
 ////                ((AlarmManager)con. getSystemService(ALARM_SERVICE)).set(AlarmManager.RTC_WAKEUP, System.currentTimeMillis() * 1000, pendingIntent);
 //                try {
 //                    pendingIntent.send();
 //                } catch (PendingIntent.CanceledException e) {
 //                    e.printStackTrace();
 //                }


             }
         }
     };*/
    private MediaPlayer mMediaPlayer;
/*
    private void openDialog() {
        new AlertDialog.Builder(con)
                .setTitle("Delete entry")
                .setMessage("Are you sure you want to delete this entry?")

                // Specifying a listener allows you to take an action before dismissing the dialog.
                // The dialog is automatically dismissed when a dialog button is clicked.
                .setPositiveButton(android.R.string.yes, new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        // Continue with delete operation
                    }
                })

                // A null listener allows the button to dismiss the dialog and take no further action.
                .setNegativeButton(android.R.string.no, null)
                .setIcon(android.R.drawable.ic_dialog_alert)
                .show();
    }*/

    public Notification getNotification(Context context, @NonNull String title, @NonNull String message, String notification_id) {
        //  String notification_id = context.getString(R.string.default_notification_channel_id); // default_channel_id
        //  String message = context.getString(R.string.default_notification_channel_title); // Default Channel
//        Intent intent2;
        PendingIntent pendingIntent;
        NotificationCompat.Builder builder;
        NotificationManager notifyManager = (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);

        final int ic_popup_reminder = android.R.drawable.ic_popup_reminder;


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
                    .setDefaults(Notification.DEFAULT_ALL)
                    .setPriority(NotificationCompat.PRIORITY_HIGH)
                    .setAutoCancel(true)
//                    .setContentIntent(pendingIntent)
                    .setTicker(title)
                    .setVibrate(new long[]{100, 200, 300, 400, 500, 400, 300, 200, 400});

            Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse("https://www.journaldev.com"));
            PendingIntent s = PendingIntent.getActivity(context, 0, intent, 0);

            Intent buttonIntent = new Intent(context, ApprovalReceiver.class);
//            buttonIntent.putExtra("notificationId", NOTIFICATION_ID);
            PendingIntent dismissIntent = PendingIntent.getBroadcast(context, 0, buttonIntent, 0);

//        builder.setContentIntent(launchIntent);
            builder.addAction(android.R.drawable.ic_menu_view, "VIEW", s);
            builder.addAction(android.R.drawable.ic_delete, "DISMISS", dismissIntent);
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
                    .setAutoCancel(true)
//                    .setContentIntent(pendingIntent)
                    .setTicker(title)
                    .setVibrate(new long[]{100, 200, 300, 400, 500, 400, 300, 200, 400})
                    .setPriority(Notification.PRIORITY_HIGH);
            if (bitmap != null) {
                builder.setLargeIcon(bitmap);
            }
        }
        notifyManager.notify(1, builder.build());
        return builder.build();
    }

    public void openNotification() {
        Bundle extras = inte.getExtras();
        NodeRequestPojo nodeRequestPojo = (NodeRequestPojo) extras.get("node_request");
        Intent de = new Intent(con, ApprovalActivity.class);
        de.putExtra(ApprovalActivity.NODE_REQUEST, nodeRequestPojo);
        Notification notification = new Notification();

        NotificationManager mNotificationManager = (NotificationManager) con.getSystemService(NOTIFICATION_SERVICE);

        RemoteViews contentView = new RemoteViews(con.getPackageName(), R.layout.custom_notification);

        contentView.setTextViewText(R.id.notification_message, "Custom notification");

        notification.contentView = contentView;


        PendingIntent contentIntent = PendingIntent.getActivity(con, 0, de, 0);
        notification.contentIntent = contentIntent;

        notification.flags |= Notification.FLAG_NO_CLEAR; //Do not clear the notification
        notification.defaults |= Notification.DEFAULT_LIGHTS; // LED
        notification.defaults |= Notification.DEFAULT_VIBRATE; //Vibration
        notification.defaults |= Notification.DEFAULT_SOUND; // Sound

        mNotificationManager.notify(1, notification);

    }

    @Override
    public void onReceive(Context context, Intent intent) {
        con = context;
        inte = intent;
        try {
            Log.e("RECEICVER", intent.getAction());
           /* if (MEMBER_APPROVAL_REQUEST.equalsIgnoreCase(intent.getAction())) {
                Log.e("ApprovalReceiver", "onReceive");
                callActionHandler.postDelayed(runRingingActivity, 1000);

            }*/


        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
