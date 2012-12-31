//
//  AppDelegate.m
//  chitacan-storyboards
//
//  Created by kyung yeol Kim on 12. 12. 31..
//  Copyright (c) 2012년 kyung yeol Kim. All rights reserved.
//

#import "AppDelegate.h"
#import "Player.h"
#import "PlayerViewController.h"

@implementation AppDelegate {
    NSMutableArray *players;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self initPlayersWithDefaults];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Player Objects

- (void)initPlayersWithDefaults {
    players = [NSMutableArray arrayWithCapacity:20];
    
    Player *player = [[Player alloc] init];
    player.name = @"Bill Evans";
    player.game = @"Tic-Tac-Toe";
    player.rating = 4;
    [players addObject:player];
    
    player = [[Player alloc] init];
    player.name = @"Oscar Peterson";
    player.game = @"Spin the Bottle";
    player.rating = 5;
    [players addObject:player];
    
    player = [[Player alloc] init];
    player.name = @"Dave Brubeck";
    player.game = @"Texas Hold'em Poker";
    player.rating = 2;
    [players addObject:player];
    
    UITabBarController      *tabBarController       = (UITabBarController*) self.window.rootViewController;
    UINavigationController  *navController          = [[tabBarController viewControllers] objectAtIndex:0];
    PlayerViewController    *playerViewController   = [[navController viewControllers] objectAtIndex:0];
    playerViewController.players = players;
}

@end
