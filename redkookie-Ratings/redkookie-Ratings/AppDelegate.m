//
//  AppDelegate.m
//  redkookie-Ratings
//
//  Created by Kim cloody on 12. 12. 25..
//  Copyright (c) 2012 AhnLab. All rights reserved.
//

#import "AppDelegate.h"
#import "Player.h"
#import "PlayersViewController.h"

@implementation AppDelegate {
    
    // ???????
    NSMutableArray *players;
}

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
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
	player.game = @"Texas Hold’em Poker";
	player.rating = 2;
	[players addObject:player];
    
    // Why? : the app delegate doesn’t know anything about PlayersViewController yet, so it will have to dig through the storyboard to find it.
    
    // init 의 컨트롤러는 현재 스토리보드에서 탭바 컨트롤러, 그러므로 윈도우의 루트는 탭바 컨트롤러
	UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    // 그 탭바 컨트롤러의 0 번째 뷰 컨트롤러는 현재 네비게이션 컨트롤러
	UINavigationController *navigationController = [[tabBarController viewControllers] objectAtIndex:0];
    // 그 네비게이션 컨트롤러의 0 번째 (루트뷰가 아니고 0 번째??) 컨트롤러는 테이블뷰 컨트롤러, 이것은 PlayersView~
    // Why? : Unfortunately, UINavigationController has no rootViewController property so we’ll have to delve into its viewControllers array.
	PlayersViewController *playersViewController = [[navigationController viewControllers] objectAtIndex:0];
    // 그 컨트롤러에 players 라는 array 를 선언해 놓았으므로 여기서 만든 것을 전달
	playersViewController.players = players;
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
