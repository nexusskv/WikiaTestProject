//
//  WTPAppDelegate.m
//  WikiaTestProject
//
//  Created by rost on 10.12.14.
//  Copyright (c) 2014 Rost. All rights reserved.
//

#import "WTPAppDelegate.h"
#import "WTPTableViewController.h"


@implementation WTPAppDelegate

#pragma mark - App life cycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    WTPTableViewController *tableVC = [[WTPTableViewController alloc] init];
    self.navController = [[UINavigationController alloc] initWithRootViewController:tableVC];
    self.window.rootViewController = self.navController;
        
    [self.window makeKeyAndVisible];
    
    return YES;
}
#pragma mark -

@end
