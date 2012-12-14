//
//  TableItem.h
//  redkookie-TableViewController
//
//  Created by Kim cloody on 12. 12. 13..
//  Copyright (c) 2012 AhnLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableItem : NSObject
{
    NSString* itemTitle;
    NSString* itemDes;
}

@property (strong, nonatomic) NSString* itemTitle;

@property (strong, nonatomic) NSString* itemDes;

- (id)initWithItemName:(NSString*)title andDes:(NSString*)des;

@end
