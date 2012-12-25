//
//  Fruit.m
//  chitacan-table
//
//  Created by kyung yeol Kim on 12. 12. 19..
//  Copyright (c) 2012년 kyung yeol Kim. All rights reserved.
//

#import "Fruit.h"

@implementation Fruit

@synthesize name;
@synthesize description;

-(id) initWithName:(NSString *)n AndDescription:(NSString *)desc {
    self.name = n;
    self.description = desc;
    return self;
}

@end
