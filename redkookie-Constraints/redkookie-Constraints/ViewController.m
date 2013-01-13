//
//  ViewController.m
//  redkookie-Constraints
//
//  Created by cloody on 13. 1. 13..
//  Copyright (c) 2013년 cloody. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)buttonTapped:(UIButton *)sender
{
    if ([[sender titleForState:UIControlStateNormal] isEqualToString:@"X"])
        [sender setTitle:@"A very long title for this button"
                forState:UIControlStateNormal];
    else
        [sender setTitle:@"X" forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
