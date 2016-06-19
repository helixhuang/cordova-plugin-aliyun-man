#  Cordova Plugin for Aliyun Mobile Analytics(MAN) (Not Official)
This plugin allows you to use Aliyun Mobile Analytics(MAN) on Android, iOS.

Read more from Aliyun site [Aliyun Mobile Analytics Docs]([https://help.aliyun.com/product/9005959_30019.html?spm=5176.750001.2.35.S4zt6o])

## Installation ##

Cordova

```cordova plugin add cordova-plugin-aliyun-man --variable APP_KEY=XXX --variable APP_SECRET=XXX```

## Methods ##

* [aliyunman.initialize] (#initialize)
* [aliyunman.updateUserAccount] (#updateUserAccount) 
* [aliyunman.userRegister] (#userRegister) 
* [aliyunman.pageHit] (#pageHit)
* [aliyunman.customHit] (#customHit)

### initialize ###

```javascript
aliyunman.initialize({
    'debug':false,
    'crashHandler':true,
    'autoPageTrack':false
},function(){
    console.log("Success");
},function(){
    console.log("Fail");
});
```

### updateUserAccount ###

```javascript
aliyunman.updateUserAccount({
    'userName':'Helix',
    'userId':'001'
},function(){
    console.log("Success");
},function(){
    console.log("Fail");
});
```

### userRegister ###

```javascript
aliyunman.userRegister({
    'userName':'Helix'
},function(){
    console.log("Success");
},function(){
    console.log("Fail");
});
```

### pageHit ###

```javascript
aliyunman.pageHit({
    'pageName':'page',
    'referPageName':'refer',
    'duration':1000 * 60 * 3
},function(){
    console.log("Success");
},function(){
    console.log("Fail");
});
```

### customHit ###

```javascript
aliyunman.customHit({
    'eventLabel':'eventLabel',
    'eventPage':'eventPage',
    'duration':1000 * 60 * 3
},function(){
    console.log("Success");
},function(){
    console.log("Fail");
});
```

