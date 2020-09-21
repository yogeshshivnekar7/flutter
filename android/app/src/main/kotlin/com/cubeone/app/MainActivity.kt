package com.cubeone.app

import android.content.Intent
import android.content.SharedPreferences
import android.os.Bundle
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodChannel
import node_service.AppConstant.*

public class MainActivity : FlutterActivity(), FlutterPlugin {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        Log.e("configureFlutterEngine", "configureFlutterEngine")
//        GeneratedPluginRegistrant.registerWith(registry)
    }

    private var mMethodChannel: MethodChannel? = null
    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        Log.e("onAttachedToEngine", "onAttachedToEngine")


        TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
    }

    private var push_notification_redirect: String? = null
    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        val bundle: Bundle? = getIntent().getExtras()
        if (bundle != null) {
            for (key in bundle.keySet()) {
                Log.e("ContentValues.onNewIntent", key + " : " + if (bundle.get(key) != null) bundle.get(key) else "NULL")
                if (key.equals("push_notification_redirect")) {
                    push_notification_redirect = bundle.get(key).toString()
                    /*mChange:MethodChannel = MethodChannel(getFlutterEngine()?.getDartExecutor()?.getBinaryMessenger(), "").*/
                }
            }
        }
    }
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val bundle: Bundle? = getIntent().getExtras()
        if (bundle != null) {
            for (key in bundle.keySet()) {
                Log.e("ContentValues.TAG onCreate", key + " : " + if (bundle.get(key) != null) bundle.get(key) else "NULL")
                if (key.equals("push_notification_redirect")) {
                    push_notification_redirect = bundle.get(key).toString()
                    /*mChange:MethodChannel = MethodChannel(getFlutterEngine()?.getDartExecutor()?.getBinaryMessenger(), "").*/
                }
            }
            getIntent().replaceExtras(Bundle())
        }
//        setContentView(R.layout.activity_approval)
        Log.e("MainActivity", "onCreate")
        Thread(Runnable {
            kotlin.run {
                mMethodChannel = MethodChannel(getFlutterEngine()?.getDartExecutor()?.getBinaryMessenger(), CHANNEL)
                callListner()
            }
            MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger, "app.channel.shared.data").setMethodCallHandler { call, result ->
                if (call.method!!.contentEquals("getSharedText")) {
                    if (push_notification_redirect != null) {
//                        Log.d("push_notificationredirect", push_notification_redirect)
                        result.success(push_notification_redirect)
                        push_notification_redirect = null
                    }

                }
            }
        }).start()

    }

    private fun callListner() {
        mMethodChannel?.setMethodCallHandler { call, result ->
            if (call.method.equals("node_url")) {
//                keepResult = result;
                val sharedPref: SharedPreferences = getSharedPreferences(PREFERNCE_KEY, PRIVATE_MODE)
                Log.e("MAIN_ACTIVITY", "cainaisndinsiandi -----------------" + call.arguments.toString())
//               Log.e("ddd",call.arguments.javaClass.name);
                var ha = call.arguments as HashMap<String, String>

                Log.e("mnaninainf", ha["node_url_key"]!!)
                val editor = sharedPref.edit()
                editor.putString(NOODE_URL_KEY, ha["node_url_key"])
                editor.commit()
                Log.e("valeu --- ", sharedPref.getString(NOODE_URL_KEY, "")!!)

            }
        }
    }

    //
    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        mMethodChannel?.setMethodCallHandler(null)
        mMethodChannel = null
    }


    val CHANNEL = "com.cubeone.app/MainActivity"

//    private lateinit var logger: AppEventsLogger

//    override fun onCreate(savedInstanceState: Bundle?) {
//        super.onCreate(savedInstanceState)
//        GeneratedPluginRegistrant.registerWith(this)
//        this.logger = AppEventsLogger.newLogger(this)
//        Log.e("MainActivity", "amsidiadiianindiniandmainainigain-----------------------")
////        sendNotification();
//        MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result ->
//            if (call.method.equals("node_url")) {
//                keepResult = result;
//                val sharedPref: SharedPreferences = getSharedPreferences(PREFERNCE_KEY, PRIVATE_MODE)
//                Log.e("MAIN_ACTIVITY", "cainaisndinsiandi -----------------" + call.arguments.toString())
////               Log.e("ddd",call.arguments.javaClass.name);
//                var ha = call.arguments as HashMap<String, String>
//
//                Log.e("mnaninainf", ha["node_url_key"])
//                val editor = sharedPref.edit()
//                editor.putString(NOODE_URL_KEY, ha["node_url_key"])
//                editor.commit()
//                Log.e("valeu --- ", sharedPref.getString(NOODE_URL_KEY, ""))
//
//            }
//        }
//    }


}
