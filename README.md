#  Cordova Plugin for Aliyun Mobile Analytics(MAN) (Not Official)

[![Join the chat at https://gitter.im/helixhuang/cordova-plugin-aliyun-man](https://badges.gitter.im/helixhuang/cordova-plugin-aliyun-man.svg)](https://gitter.im/helixhuang/cordova-plugin-aliyun-man?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

This plugin allows you to use Aliyun Mobile Analytics(MAN) on Android, iOS.

Read more from Aliyun site [here](https://help.aliyun.com/product/9005959_30019.html?spm=5176.750001.2.35.S4zt6o)

[![Gitter](https://badges.gitter.im/helixhuang/cordova-plugin-aliyun-man.svg)](https://gitter.im/helixhuang/cordova-plugin-aliyun-man?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

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


## More information ##
* Author: Helix Huang
* Website: http://www.cecoco.com/ (Under construction)
* Email: <huangjianping@gmail.com>
* Facebook: https://www.facebook.com/helix.huang
* LinkedIn: https://www.linkedin.com/in/helixhuang

## License ##
The MIT License (MIT)

Copyright (c) 2016 Rand Dusing and contributors.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
