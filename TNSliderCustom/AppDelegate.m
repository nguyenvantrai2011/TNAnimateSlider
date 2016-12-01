//
//  AppDelegate.m
//  TNSliderCustom
//
//  Created by Trai Nguyen on 11/4/16.
//  Copyright © 2016 Trai Nguyen. All rights reserved.
//

#import "AppDelegate.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    int a = 3;
    int b = 6;
    a = a + b;
    b = a - b;
    a = a - b;
    NSLog(@"a = %d", a);
    NSLog(@"b = %d", b);
    
    LAContext *context = [[LAContext alloc] init];
    
    NSError *authError = nil;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                 localizedReason:@"Authenticate to login"
                           reply:^(BOOL success, NSError *error) {
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   if (error) {
                                       switch (error.code) {
                                           case LAErrorAuthenticationFailed:
                                               break;
                                           case LAErrorUserFallback:
                                               break;
                                           case LAErrorUserCancel:
                                               break;
                                           default:
                                               break;
                                       }
                                       
                                   }
                                   if (error) {
                                       NSLog(@"%@", error);
                                   }
                                   if (success) {
                                       NSLog(@"Login Success");
                                   }
                               });
                               
                           }];
    } else {
        NSLog(@"%@", authError);
    }
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
