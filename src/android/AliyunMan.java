package com.cecoco.cordova;

import android.app.Activity;

import com.alibaba.sdk.android.man.MANHitBuilders;
import com.alibaba.sdk.android.man.MANPageHitBuilder;
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
    } else if ("userRegister".equals(action)) {
      userRegisterAction(args, callbackContext);
    } else if ("pageHit".equals(action)) {
      pageHitAction(args, callbackContext);
    } else if ("customHit".equals(action)) {
      customHitAction(args, callbackContext);
    } else {
      return false;
    }
    return true;
  }

  private void initializeAction(JSONArray args, CallbackContext callbackContext) {
    JSONObject obj = getArgsObject(args);
    try {
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
      callbackContext.success("initialized");
    } catch (Exception ex) {
      callbackContext.error(ex.getMessage());
    }
  }

  private void updateUserAccountAction(JSONArray args, CallbackContext callbackContext) {
    JSONObject obj = getArgsObject(args);
    if (obj==null) {
      callbackContext.error("null input");
      return;
    }
    try{
      MANService manService = MANServiceProvider.getService();
      String userName = obj.optString("userName","");
      String userId = obj.optString("userId","");
      manService.getMANAnalytics().updateUserAccount(userName, userId);
      callbackContext.success("updated");
    } catch (Exception ex) {
      callbackContext.error(ex.getMessage());
    }
  }

  private void userRegisterAction(JSONArray args, CallbackContext callbackContext) {
    JSONObject obj = getArgsObject(args);
    if (obj==null) {
      callbackContext.error("null input");
      return;
    }
    try{
      MANService manService = MANServiceProvider.getService();
      String userName = obj.optString("userName","");
      manService.getMANAnalytics().userRegister(userName);
      callbackContext.success("updated");
    } catch (Exception ex) {
      callbackContext.error(ex.getMessage());
    }
  }

  private void pageHitAction(JSONArray args, CallbackContext callbackContext) {
    JSONObject obj = getArgsObject(args);
    if (obj==null) {
      callbackContext.error("null input");
      return;
    }
    try{
      String pageName = obj.optString("pageName","");
      String referPageName = obj.optString("referPageName","");
      int duration = obj.getInt("duration");
      JSONObject properties = obj.getJSONObject("properties");
      MANPageHitBuilder hitBuilder = new MANPageHitBuilder(pageName);
      hitBuilder.setDurationOnPage(duration);
      hitBuilder.setReferPage(referPageName);
      if (properties!=null){
        while (properties.keys().hasNext()){
          String key = properties.keys().next();
          String value = properties.getString(key);
          hitBuilder.setProperty(key, value);
        }
      }
      MANService manService = MANServiceProvider.getService();
      manService.getMANAnalytics().getDefaultTracker().send(hitBuilder.build());
      callbackContext.success("sent");
    } catch (Exception ex) {
      callbackContext.error(ex.getMessage());
    }
  }

  private void customHitAction(JSONArray args, CallbackContext callbackContext) {
    JSONObject obj = getArgsObject(args);
    if (obj==null) {
      callbackContext.error("null input");
      return;
    }
    try{
      String eventLabel = obj.optString("eventLabel","");
      String eventPage = obj.optString("eventPage","");
      int duration = obj.getInt("duration");
      JSONObject properties = obj.getJSONObject("properties");

      MANHitBuilders.MANCustomHitBuilder hitBuilder = new MANHitBuilders.MANCustomHitBuilder(eventLabel);
      hitBuilder.setDurationOnEvent(duration);
      hitBuilder.setEventPage(eventPage);
      if (properties!=null){
        while (properties.keys().hasNext()){
          String key = properties.keys().next();
          String value = properties.getString(key);
          hitBuilder.setProperty(key, value);
        }
      }

      MANService manService = MANServiceProvider.getService();
      manService.getMANAnalytics().getDefaultTracker().send(hitBuilder.build());
      callbackContext.success("sent");
    } catch (Exception ex) {
      callbackContext.error(ex.getMessage());
    }
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
