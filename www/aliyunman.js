var aliyunman = {
    initialize: function (params,successCallback,failCallback) {
        cordova.exec(successCallback, failCallback, "AliyunMan", "initialize", [params]);
    },
    updateUserAccount: function (params,successCallback,failCallback) {
        cordova.exec(successCallback, failCallback, "AliyunMan", "updateUserAccount", [params]);
    },
    userRegister: function (params,successCallback,failCallback) {
        cordova.exec(successCallback, failCallback, "AliyunMan", "userRegister", [params]);
    },
    pageHit: function (params,successCallback,failCallback) {
        cordova.exec(successCallback, failCallback, "AliyunMan", "pageHit", [params]);
    },
    customHit: function (params,successCallback,failCallback) {
        cordova.exec(successCallback, failCallback, "AliyunMan", "customHit", [params]);
    }
};
module.exports = aliyunman;
