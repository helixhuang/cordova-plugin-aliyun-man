var aliyunman = {
    initialize: function (successCallback, params) {
        cordova.exec(successCallback, successCallback, "AliyunMan", "initialize", [params]);
    },
    updateUserAccount: function (successCallback, params) {
        cordova.exec(successCallback, successCallback, "AliyunMan", "updateUserAccount", [params]);
    }
};
module.exports = aliyunman;
