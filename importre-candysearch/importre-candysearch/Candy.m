//
//  Candy.m
//  importre-candysearch
//
//  Created by importre on 12. 12. 15..
//  Copyright (c) 2012년 AhnLab. All rights reserved.
//

#import "Candy.h"

@implementation Candy

+ (id)candyOfCategory:(NSString *)category name:(NSString *)name {
    Candy *candy = [[self alloc] init];
    candy.category = category;
    candy.name = name;
    return candy;
}

@end
