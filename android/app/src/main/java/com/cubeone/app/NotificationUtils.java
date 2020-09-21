package com.cubeone.app;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.media.AudioAttributes;
import android.media.MediaPlayer;
import android.net.Uri;
import android.os.Build;
import android.util.Log;

import androidx.annotation.DrawableRes;
import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;
import androidx.core.app.NotificationCompat;

import static android.content.Context.NOTIFICATION_SERVICE;

/**
 * Created by ₹!houlG on 2/5/19.
 * Futurescape Tech
 * rahul.giradkar@futurescapetech.com
 */
public class NotificationUtils {

    private static NotificationManager notifyManager;


    /**
     * @param context
     * @param title           notification title
     * @param message         notification sub title
     * @param notification_id
     * @param small_image     drawable id
     * @param large_image     drawable id
     * @param intent
     */
    public static Notification createNotification(@NonNull Context context, @NonNull String title, @NonNull String message, String notification_id, @DrawableRes Integer small_image, @DrawableRes Integer large_image, Intent intent) {

        final int NOTIFY_ID = Integer.parseInt(notification_id); // ID of notification
        Notification notification;
        if (intent == null) {
            notification = getNotification(context, title, message, notification_id, small_image, large_image);
        } else {
            notification = getNotificationIntent(context, title, message, notification_id, small_image, large_image, intent);
        }
        NotificationManager manager = (NotificationManager) context.getSystemService(NOTIFICATION_SERVICE);
        manager.notify((int) System.currentTimeMillis(), notification);
        return notification;
    }

    /*public static Notification createNotification(@NonNull Context context, @NonNull String title, @NonNull String message, String notification_id, @DrawableRes Integer small_image, @DrawableRes Integer large_image, Intent intent, Uri uri, MediaPlayer mMediaPlayer) {
        final int NOTIFY_ID = Integer.parseInt(notification_id); // ID of notification
        Notification notification;
        if (intent == null) {
            notification = getNotification(context, title, message, notification_id, small_image, large_image);
        } else {
            notification = getNotification(context, title, message, notification_id, small_image, large_image, intent, uri, mMediaPlayer);
        }
        notifyManager.notify(NOTIFY_ID, notification);
        return notification;
    }
*/
    public static Notification getNotificationIntent(@NonNull Context context, @NonNull String title, @NonNull String message, String notification_id, @DrawableRes Integer small_image, @DrawableRes Integer large_image, Intent intent) {
        Intent intent2;
        PendingIntent pendingIntent;
        NotificationCompat.Builder builder;
        if (notifyManager == null) {
            notifyManager = (NotificationManager) context.getSystemService(NOTIFICATION_SERVICE);
        }
        int ic_popup_reminder = android.R.drawable.ic_popup_reminder;
        if (small_image != null) {
            ic_popup_reminder = small_image;
        }

        Bitmap bitmap = null;
        if (large_image != null) {
            bitmap = BitmapFactory.decodeResource(context.getResources(), large_image);
        }
        Uri uri = getNotifcationUri(context);
        Log.e("NotificaFilePath111", uri.getPath());
        createNotificationChannel(context, message, notification_id, uri);
        builder = new NotificationCompat.Builder(context, notification_id);
        intent2 = intent;
        intent2.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TASK);
        pendingIntent = PendingIntent.getActivity(context, 0, intent2, 0);
        builder.setContentTitle(title)
                .setSmallIcon(ic_popup_reminder)
                .setContentText(message)
                .setPriority(NotificationCompat.PRIORITY_HIGH)
                .setAutoCancel(true)
                .setSound(uri)
                .setOngoing(true)
                .setContentIntent(pendingIntent)
                .setVibrate(new long[]{100, 200, 300, 400, 500, 400, 300, 200, 400});
        if (bitmap != null) {
            builder.setLargeIcon(bitmap);
        }
/*        Intent yesReceive = new Intent();
        yesReceive.setAction(AppConstant.NOODE_URL_KEY);
        PendingIntent pendingIntentYes = PendingIntent.getBroadcast(context, 12345, yesReceive, PendingIntent.FLAG_UPDATE_CURRENT);
        builder.addAction(R.drawable.com_facebook_button_icon, "Yes", pendingIntentYes);*/
        return builder.build();
    }

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    private static AudioAttributes getAudioAttributes() {
        return new AudioAttributes.Builder()
                .setUsage(AudioAttributes.USAGE_NOTIFICATION)
                .build();
    }

    public static Notification getNotification(@NonNull Context context, @NonNull String title, @NonNull String message, String notification_id, @DrawableRes Integer small_image, @DrawableRes Integer large_image, Intent intent,
                                               Uri uri2, MediaPlayer mMediaPlayer) {
        //  String notification_id = context.getString(R.string.default_notification_channel_id); // default_channel_id
        //  String message = context.getString(R.string.default_notification_channel_title); // Default Channel
        Intent intent2;
        PendingIntent pendingIntent;
        NotificationCompat.Builder builder;
        if (notifyManager == null) {
            notifyManager = (NotificationManager) context.getSystemService(NOTIFICATION_SERVICE);
        }
        final int ic_popup_reminder;
        if (small_image == null) {
            ic_popup_reminder = android.R.drawable.ic_popup_reminder;
        } else {
            ic_popup_reminder = small_image;
        }

        Bitmap bitmap = null;
        if (large_image != null) {
            bitmap = BitmapFactory.decodeResource(context.getResources(),
                    large_image);
        }

        Uri uri = getNotifcationUri(context);
        Log.e("Notification File Path", uri.getPath());
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            createNotificationChannel(context, message, notification_id, uri);
            builder = new NotificationCompat.Builder(context, notification_id);
            intent2 = intent;
            intent2.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_SINGLE_TOP);
            pendingIntent = PendingIntent.getActivity(context, 0, intent2, 0);
            builder.setContentTitle(title)                            // required
                    .setSmallIcon(ic_popup_reminder)   // required
                    .setContentText(message) // required
                    //.setDefaults(Notification.DEFAULT_ALL)
                    .setAutoCancel(true)
                    .setSound(uri)
                    .setContentIntent(pendingIntent)
                    .setTicker(title)
                    .setVibrate(new long[]{100, 200, 300, 400, 500, 400, 300, 200, 400});
            if (bitmap != null) {
                builder.setLargeIcon(bitmap);
            }
        } else {
            builder = new NotificationCompat.Builder(context, notification_id);
            intent2 = intent;
            intent2.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_SINGLE_TOP);
            pendingIntent = PendingIntent.getActivity(context, 0, intent2, 0);
            builder.setContentTitle(title)                            // required
                    .setSmallIcon(ic_popup_reminder)   // required
                    .setContentText(message) // required
                    //.setDefaults(Notification.DEFAULT_ALL)
                    .setAutoCancel(true)
                    .setSound(uri)
                    .setContentIntent(pendingIntent)
                    .setTicker(title)
                    .setVibrate(new long[]{100, 200, 300, 400, 500, 400, 300, 200, 400})
                    .setPriority(Notification.PRIORITY_HIGH);
            if (bitmap != null) {
                builder.setLargeIcon(bitmap);
            }
        }
        return builder.build();
    }

    private static Uri getNotifcationUri(@NonNull Context context) {
        Uri uri = Uri.parse(ContentResolver.SCHEME_ANDROID_RESOURCE + "://" + context.getPackageName() + "/raw/custom_notification");
        Log.e("Notification File Path", uri.getPath());
        Log.e("Notification File Path", ContentResolver.SCHEME_ANDROID_RESOURCE + "://" + context.getPackageName() + "/raw/custom_notification");
        return uri;
    }

    public static Notification getNotification(@NonNull Context context, @NonNull String title, @NonNull String message, String notification_id, @DrawableRes Integer small_image, @DrawableRes Integer large_image) {
        //  String notification_id = context.getString(R.string.default_notification_channel_id); // default_channel_id
        //  String message = context.getString(R.string.default_notification_channel_title); // Default Channel
//        Intent intent2;
        PendingIntent pendingIntent;
        NotificationCompat.Builder builder;
        if (notifyManager == null) {
            notifyManager = (NotificationManager) context.getSystemService(NOTIFICATION_SERVICE);
        }
        final int ic_popup_reminder;
        if (small_image == null) {
            ic_popup_reminder = android.R.drawable.ic_popup_reminder;
        } else {
            ic_popup_reminder = small_image;
        }
        Bitmap bitmap = null;
        if (large_image != null) {
            bitmap = BitmapFactory.decodeResource(context.getResources(),
                    large_image);
        }
        Uri uri = getNotifcationUri(context);
        Log.e("dsvnsdjvn", "ejgvnser");
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            createNotificationChannel(context, message, notification_id, uri);
            builder = new NotificationCompat.Builder(context, notification_id);
            builder.setContentTitle(title)
                    .setSmallIcon(ic_popup_reminder)
                    .setContentText(message) // required
                    //.setDefaults(Notification.DEFAULT_ALL)
                    .setAutoCancel(true)
                    .setSound(uri)
//                    .setContentIntent(pendingIntent)
                    .setTicker(title).setVisibility(NotificationCompat.VISIBILITY_PUBLIC)
                    .setVibrate(new long[]{100, 200, 300, 400, 500, 400, 300, 200, 400});

//            Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse("https://www.journaldev.com"));
//            PendingIntent s = PendingIntent.getActivity(context, 0, intent, 0);
//
//            Intent buttonIntent = new Intent(context, ApprovalReceiver.class);
////            buttonIntent.putExtra("notificationId", NOTIFICATION_ID);
//            PendingIntent dismissIntent = PendingIntent.getBroadcast(context, 0, buttonIntent, 0);
//
////        builder.setContentIntent(launchIntent);
//            builder.addAction(android.R.drawable.ic_menu_view, "VIEW", s);
//            builder.addAction(android.R.drawable.ic_delete, "DISMISS", dismissIntent);
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
                    //.setDefaults(Notification.DEFAULT_ALL)
                    .setAutoCancel(true)
                    //.setSound(uri)
//                    .setContentIntent(pendingIntent)
                    .setTicker(title).setVisibility(NotificationCompat.VISIBILITY_PUBLIC)
                    .setVibrate(new long[]{100, 200, 300, 400, 500, 400, 300, 200, 400})
                    .setPriority(Notification.PRIORITY_HIGH);
            if (bitmap != null) {
                builder.setLargeIcon(bitmap);
            }
        }
        return builder.build();
    }

    private static void createNotificationChannel(Context context, @NonNull String message, String notification_id, Uri uri) {
        /*MediaPlayer mp = MediaPlayer. create (context, uri);
        mp.start();*/
        Log.e("Create NOtification", "NotificaFilePath111");
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            int importance = NotificationManager.IMPORTANCE_HIGH;
            NotificationChannel mChannel = null;
            mChannel = new NotificationChannel(notification_id, "App Notification", importance);
            mChannel.enableVibration(true);
            mChannel.setDescription("Make sound");
            //mChannel.setSound(uri, getAudioAttributes());
            mChannel.setVibrationPattern(new long[]{100, 200, 300, 400, 500, 400, 300, 200, 400});
            if (uri != null) {
                AudioAttributes audioAttributes = new AudioAttributes.Builder()
                        .setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
                        .setUsage(AudioAttributes.USAGE_NOTIFICATION)
                        .build();
                mChannel.setSound(uri, audioAttributes);
            }
            // NotificationManagerCompat notificationManager = NotificationManagerCompat.from(context);
            notifyManager.createNotificationChannel(mChannel);
        }
    }

    /**
     * @param context
     * @param title
     * @param message
     * @param notification_id notification notification_id
     * @param intent
     */

   /* public static void createNotification(@NonNull Context context, @NonNull String title, @NonNull String message, String notification_id, Intent intent) {
        createNotification(context, title, message, notification_id, null, null, intent);
    }

    public static void createNotification(@NonNull Context context, @NonNull String title, @NonNull String message, String notification_id) {
        createNotification(context, title, message, notification_id, null, null, null);
    }*/
}
