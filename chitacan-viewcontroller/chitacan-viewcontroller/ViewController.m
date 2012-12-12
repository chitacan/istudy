//
//  ViewController.m
//  chitacan-viewcontroller
//
//  Created by kyung yeol Kim on 12. 12. 10..
//  Copyright (c) 2012년 kyung yeol Kim. All rights reserved.
//

#import "ViewController.h"
#import "ViewController2.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.navigationItem setTitle:@"screen one"];
    
    UIBarButtonItem *goToNext = [[UIBarButtonItem alloc] initWithTitle:@"next"
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(goForward)];
    [self.navigationItem setRightBarButtonItem:goToNext];
    
    UIBarButtonItem *backbutton = [[UIBarButtonItem alloc] initWithTitle:@"back"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:nil
                                                                  action:nil];
    [self.navigationItem setBackBarButtonItem:backbutton];
}

- (void)goForward
{
    ViewController2 *vc2 = [[ViewController2 alloc]init];
    
    [self.navigationController pushViewController:vc2 animated:YES];
}

- (void)backButton
{
    NSLog(@"ㅋㅋㅋ");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
