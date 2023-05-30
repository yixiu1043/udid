package com.ob.foundation.udid

import android.app.Application
import android.content.Context
import android.provider.Settings
import android.util.Log
import androidx.annotation.NonNull
import com.github.gzuliyujiang.oaid.DeviceID

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** UdidPlugin */
class UdidPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {

    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    private lateinit var application: Application

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "udid")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "getUdid") {
            val oaid = DeviceID.getOAID()
            Log.d("oaid", oaid)
            if (oaid == "00000000-0000-0000-0000-000000000000" || oaid.isBlank()) {
                val androidId = Settings.System.getString(
                    context.contentResolver,
                    Settings.Secure.ANDROID_ID
                )
                Log.d("androidId", androidId)
                result.success(androidId)
            } else {
                result.success(oaid)
            }

        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        application = binding.activity.application
        DeviceID.register(application)
    }

    override fun onDetachedFromActivityForConfigChanges() {
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    }

    override fun onDetachedFromActivity() {

    }
}
