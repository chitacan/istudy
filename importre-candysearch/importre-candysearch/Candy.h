//
//  Candy.h
//  importre-candysearch
//
//  Created by importre on 12. 12. 15..
//  Copyright (c) 2012년 AhnLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Candy : NSObject

@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSString *name;

+ (id)candyOfCategory:(NSString *)category name:(NSString *)name;

@end
