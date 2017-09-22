#import "AliyunMan.h"
#import <Cordova/CDV.h>
#import <AlicloudMobileAnalitics/ALBBMAN.h>

@implementation AliyunMan

- (void)initialize:(CDVInvokedUrlCommand*)command
{
    NSDictionary* obj = [self getArgsObject:command.arguments];
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"MANConfig" ofType:@"plist"];
    if (plistPath == nil) {
        NSLog(@"error: MANConfig.plist not found");
        assert(0);
    }
    NSMutableDictionary *plistData = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSString * appKey = [plistData valueForKey:@"APP_KEY"];
    NSString * appSecret = [plistData valueForKey:@"APP_SECRET"];
    ALBBMANAnalytics *man = [ALBBMANAnalytics getInstance];
    if ([self getBoolValue:obj :@"debug" :[NSNumber numberWithBool:NO]]){
        [man turnOnDebug];
    }
    [man initWithAppKey:appKey secretKey:appSecret];
    if (![self getBoolValue:obj :@"crashHandler" :[NSNumber numberWithBool:YES]]){
        [man turnOffCrashHandler];
    }

    NSString * version = [self getStringValue:obj :@"version"];
    if ( ![version == (id)[NSNull null] || version.length == 0] ) {
        [man setAppVersion:version];
    }

    NSString * channel = [self getStringValue:obj :@"channel"];
    if ( ![channel == (id)[NSNull null] || channel.length == 0] ) {
      [man setChannel:channel];
    }

    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"initialized"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)updateUserAccount:(CDVInvokedUrlCommand*)command
{
    NSDictionary* obj = [self getArgsObject:command.arguments];

    ALBBMANAnalytics *man = [ALBBMANAnalytics getInstance];

    [man updateUserAccount:[self getStringValue:obj :@"userName"] userid:[self getStringValue:obj :@"userId"]];

    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"updated"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)userRegister:(CDVInvokedUrlCommand*)command
{
    NSDictionary* obj = [self getArgsObject:command.arguments];

    ALBBMANAnalytics *man = [ALBBMANAnalytics getInstance];

    [man userRegister:[self getStringValue:obj :@"userName"]];

    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"updated"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)pageHit:(CDVInvokedUrlCommand*)command
{
    NSDictionary* obj = [self getArgsObject:command.arguments];

    ALBBMANPageHitBuilder *pageHitBuilder = [[ALBBMANPageHitBuilder alloc] init];
    [pageHitBuilder setPageName:[self getStringValue:obj :@"pageName"]];
    [pageHitBuilder setReferPage:[self getStringValue:obj :@"referPageName"]];
    [pageHitBuilder setDurationOnPage:[self getLongValue:obj :@"duration"]];
    ALBBMANTracker *tracker = [[ALBBMANAnalytics getInstance] getDefaultTracker];
    [tracker send:[pageHitBuilder build]];

    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"sent"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)customHit:(CDVInvokedUrlCommand*)command
{
    NSDictionary* obj = [self getArgsObject:command.arguments];

    ALBBMANCustomHitBuilder *customBuilder = [[ALBBMANCustomHitBuilder alloc] init];
    [customBuilder setEventLabel:[self getStringValue:obj :@"eventLabel"]];
    [customBuilder setEventPage:[self getStringValue:obj :@"eventPage"]];
    [customBuilder setDurationOnEvent:[self getLongValue:obj :@"duration"]];
    ALBBMANTracker *tracker = [[ALBBMANAnalytics getInstance] getDefaultTracker];
    [tracker send:[customBuilder build]];

    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"sent"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

//General Helpers
-(NSDictionary*) getArgsObject:(NSArray *)args {
  if (args == nil) {
    return nil;
  }

  if (args.count != 1) {
    return nil;
  }

  NSObject* arg = [args objectAtIndex:0];

  if (![arg isKindOfClass:[NSDictionary class]]) {
    return nil;
  }

  return (NSDictionary *)[args objectAtIndex:0];
}


-(NSString*) getStringValue:(NSDictionary *)obj :(NSString *)key {
    NSString* result = [obj valueForKey:key];
    if (result == nil) {
        return @"";
    }
    return result;
}

-(NSNumber*) getBoolValue:(NSDictionary *)obj :(NSString *)key :(NSNumber *)defaultValue{
    NSNumber* result = [obj valueForKey:key];

    if (result == nil) {
        return defaultValue;
    }

    if (![result isKindOfClass:[NSNumber class]]) {
        return defaultValue;
    }

    return result;
}


-(long long) getLongValue:(NSDictionary *)obj :(NSString *)key {
  NSNumber* result = [obj valueForKey:key];

  if (result == nil) {
    return 0;
  }

  if (![result isKindOfClass:[NSNumber class]]) {
    return 0;
  }

  return [result longLongValue];
}
@end
