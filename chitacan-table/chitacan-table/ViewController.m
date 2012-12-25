//
//  ViewController.m
//  chitacan-table
//
//  Created by kyung yeol Kim on 12. 12. 19..
//  Copyright (c) 2012년 kyung yeol Kim. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "DetailViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"fruit";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    return appDelegate.fruits.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *myIdentifier = @"myIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero];
    }
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    Fruit *f = (Fruit *)[appDelegate.fruits objectAtIndex:indexPath.row];
    cell.textLabel.text = f.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    Fruit *fruit = (Fruit *)[appDelegate.fruits objectAtIndex:indexPath.row];
    
    DetailViewController *viewController
    = [[DetailViewController alloc] initWithNibName:@"DetailViewController"
                                             bundle:nil];
    
    viewController.title = fruit.name;
    [self.navigationController pushViewController:viewController animated:YES];
    viewController.fruitDescription.text = fruit.description;
}

- (BOOL) respondsToSelector:(SEL)aSelector {
    if (aSelector == @selector(tableView:commitEditingStyle:forRowAtIndexPath:)) {
        NSLog(@"%@", [NSThread callStackSymbols]);
        return true;
    }
    else
        return [super respondsToSelector:aSelector];
}


@end
