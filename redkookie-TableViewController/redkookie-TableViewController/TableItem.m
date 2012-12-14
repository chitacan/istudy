//
//  TableItem.m
//  redkookie-TableViewController
//
//  Created by Kim cloody on 12. 12. 13..
//  Copyright (c) 2012 AhnLab. All rights reserved.
//

#import "TableItem.h"

@implementation TableItem

@synthesize itemTitle = _itemTitle;
@synthesize itemDes = _itemDes;

- (id)initWithItemName:(NSString *)title andDes:(NSString *)des
{
    self.itemTitle = title;
    self.itemDes = des;
    
    return self;
}

@end
