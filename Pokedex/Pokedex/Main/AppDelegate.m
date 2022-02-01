//
//  AppDelegate.m
//  Pokedex
//
//  Created by Abraham Abreu on 01/12/21.
//

#import "AppDelegate.h"
#import <UIKit/UIKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc]init];
    [appearance configureWithTransparentBackground];
    appearance.backgroundColor = UIColor.clearColor;
    appearance.backgroundEffect = [UIBlurEffect effectWithStyle: UIBlurEffectStyleLight];
        
    UINavigationBarAppearance *scrollingAppearance = [[UINavigationBarAppearance alloc]init];
    [scrollingAppearance configureWithTransparentBackground];
    scrollingAppearance.backgroundColor = UIColor.whiteColor;
        
    UINavigationBar.appearance.standardAppearance = appearance;
    UINavigationBar.appearance.scrollEdgeAppearance = scrollingAppearance;
    UINavigationBar.appearance.compactAppearance = scrollingAppearance;
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
