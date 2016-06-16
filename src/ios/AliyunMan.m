#import "AliyunMan.h"
#import <Cordova/CDVPluginResult.h>
#import <AlicloudMobileAnalitics/ALBBMAN.h>

@implementation AliyunMan

- (void)initialize:(CDVInvokedUrlCommand*)command
{
    NSDictionary* obj = [self getArgsObject:command.arguments];
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"MANConfig" ofType:@"plist"];
    if (plistPath == nil) {
        NSLog(@"error: PushConfig.plist not found");
        assert(0);
    }
    NSMutableDictionary *plistData = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSString * appKey = [plistData valueForKey:@"APP_KEY"];
    NSString * appSecret = [plistData valueForKey:@"APP_SECRET"];

    ALBBMANAnalytics *man = [ALBBMANAnalytics getInstance];
    [man initWithAppKey:appKey secretKey:appSecret];
}

- (void)updateUserAccount:(CDVInvokedUrlCommand*)command
{
    NSDictionary* obj = [self getArgsObject:command.arguments];

    ALBBMANAnalytics *man = [ALBBMANAnalytics getInstance];
}

- (void)userRegister:(CDVInvokedUrlCommand*)command
{
    NSDictionary* obj = [self getArgsObject:command.arguments];

    ALBBMANAnalytics *man = [ALBBMANAnalytics getInstance];
}

- (void)pageHit:(CDVInvokedUrlCommand*)command
{
    NSDictionary* obj = [self getArgsObject:command.arguments];

    ALBBMANAnalytics *man = [ALBBMANAnalytics getInstance];
}

- (void)customHit:(CDVInvokedUrlCommand*)command
{
    NSDictionary* obj = [self getArgsObject:command.arguments];

    ALBBMANAnalytics *man = [ALBBMANAnalytics getInstance];
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

-(NSData*) getValue:(NSDictionary *) obj {
  NSString* string = [obj valueForKey:keyValue];

  if (string == nil) {
    return nil;
  }

  if (![string isKindOfClass:[NSString class]]) {
    return nil;
  }

  NSData *data = [[NSData alloc] initWithBase64EncodedString:string options:0];

  if (data == nil || data.length == 0) {
    return nil;
  }

  return data;
}

-(NSString*) getStringValue:(NSDictionary *)obj :(NSString *)key {
    NSString* result = [obj valueForKey:key];
    if (result == nil) {
        return @"";
    }
    return result;
}

-(NSNumber*) getBoolValue:(NSDictionary *)obj :(NSString *)key {
  NSNumber* result = [obj valueForKey:key];

  if (result == nil) {
    return [NSNumber numberWithBool:NO];
  }

  if (![request isKindOfClass:[NSNumber class]]) {
    return [NSNumber numberWithBool:NO];
  }

  return result;
}

@end