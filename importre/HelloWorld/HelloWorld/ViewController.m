//
//  ViewController.m
//  HelloWorld
//
//  Created by Jaewe Heo on 12. 12. 11..
//  Copyright (c) 2012년 AhnLab. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize txtName,lblHello;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) updateText:(id) sender
{
    NSString *text;
    if([txtName.text length] == 0)
        text = @"Plealse enter your name";
    else
        text = [[NSString alloc] initWithFormat:@"Hello %@!", txtName.text];
    
    lblHello.text = text;
}

@end
