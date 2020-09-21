package com.cubeone.app


import android.content.IntentFilter
import android.util.Log
import androidx.multidex.MultiDex
import io.flutter.app.FlutterApplication
//import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.GeneratedPluginRegistrant
//import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback
import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService
import node_service.ApprovalReceiver
import node_service.NotifyMemberApproval.MEMBER_APPROVAL_REQUEST
import com.facebook.FacebookSdk
import java.nio.channels.CompletionHandler


class Application : FlutterApplication(), PluginRegistry.PluginRegistrantCallback {

    override fun onCreate() {
        super.onCreate()
        MultiDex.install(this)
        FacebookSdk.sdkInitialize(getApplicationContext())
        FacebookSdk.setAutoInitEnabled(true)
        FlutterFirebaseMessagingService.setPluginRegistrant(this)
        registerReceiver()
    }


    override fun registerWith(registry: PluginRegistry) {
//        GeneratedPluginRegistrant.registerWith(registry)
    }

    private fun registerReceiver() {
        Log.e("APPLICATION", "registerReceiver");
        val intentFilter = IntentFilter()
        intentFilter.addAction(MEMBER_APPROVAL_REQUEST)
        registerReceiver(ApprovalReceiver(), intentFilter)
    }
}