//
//  Candy.h
//  redkookie-CandySearch
//
//  Created by cloody on 13. 1. 5..
//  Copyright (c) 2013년 cloody. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Candy : NSObject
{
    NSString *category;
    NSString *name;
}

@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *name;

+ (id)candyOfCategory:(NSString*)category name:(NSString*)name;

@end
