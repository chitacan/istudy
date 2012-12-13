//
//  ViewController.h
//  HelloWorld
//
//  Created by Jaewe Heo on 12. 12. 11..
//  Copyright (c) 2012년 AhnLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    IBOutlet UITextField *txtName;
    IBOutlet UILabel *lblHello;
}

@property (nonatomic, retain) IBOutlet UITextField *txtName;
@property (nonatomic, retain) IBOutlet UILabel *lblHello;

- (IBAction) updateText:(id) sender;

@end
