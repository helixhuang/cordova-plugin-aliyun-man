package com.cecoco.cordova;

import android.app.Activity;

import com.alibaba.sdk.android.man.MANService;
import com.alibaba.sdk.android.man.MANServiceProvider;

import org.apache.cordova.CordovaWebView;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class AliyunMan extends CordovaPlugin {

  public AliyunMan() {
  }

  public void initialize(CordovaInterface cordova, CordovaWebView webView) {
    super.initialize(cordova, webView);
  }

  public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
    if ("initialize".equals(action)) {
      initializeAction(args, callbackContext);
    } else if ("updateUserAccount".equals(action)) {
      updateUserAccountAction(args, callbackContext);
    } else {
      return false;
    }
    return true;
  }

  private void initializeAction(JSONArray args, CallbackContext callbackContext) {
    JSONObject returnObj = new JSONObject();
    JSONObject obj = getArgsObject(args);
    Activity activity = cordova.getActivity();
    MANService manService = MANServiceProvider.getService();
    if (obj != null && obj.optBoolean("debug", false)) {
      manService.getMANAnalytics().turnOnDebug();
    }
    manService.getMANAnalytics().init(activity.getApplication(), activity.getApplicationContext());
    if (obj != null && !obj.optBoolean("crashHandler", true)) {
      manService.getMANAnalytics().turnOffCrashHandler();
    }
    if (obj != null && !obj.optBoolean("autoPageTrack", false)) {
      manService.getMANAnalytics().turnOffAutoPageTrack();
    }
    PluginResult pluginResult = new PluginResult(PluginResult.Status.OK, returnObj);
    pluginResult.setKeepCallback(true);
    callbackContext.sendPluginResult(pluginResult);
  }

  private void updateUserAccountAction(JSONArray args, CallbackContext callbackContext) {
    JSONObject returnObj = new JSONObject();
    JSONObject obj = getArgsObject(args);
    Activity activity = cordova.getActivity();
    MANService manService = MANServiceProvider.getService();

    String userName = obj.optString("userName","");
    String userId = obj.optString("userId","");

    manService.getMANAnalytics().updateUserAccount(userName, userId);

    PluginResult pluginResult = new PluginResult(PluginResult.Status.OK, returnObj);
    pluginResult.setKeepCallback(true);
    callbackContext.sendPluginResult(pluginResult);
  }


  private JSONObject getArgsObject(JSONArray args) {
    if (args.length() == 1) {
      try {
        return args.getJSONObject(0);
      } catch (JSONException ex) {
      }
    }

    return null;
  }
}
