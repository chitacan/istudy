//
//  Candy.m
//  redkookie-CandySearch
//
//  Created by cloody on 13. 1. 5..
//  Copyright (c) 2013년 cloody. All rights reserved.
//

#import "Candy.h"

@implementation Candy

@synthesize category = _category;
@synthesize name = _name;

+ (id)candyOfCategory:(NSString *)category name:(NSString *)name
{
    Candy *newCandy = [[self alloc] init];
    newCandy.category = category;
    newCandy.name = name;
    return newCandy;
}

@end
