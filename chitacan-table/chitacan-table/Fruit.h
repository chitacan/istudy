//
//  Fruit.h
//  chitacan-table
//
//  Created by kyung yeol Kim on 12. 12. 19..
//  Copyright (c) 2012년 kyung yeol Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol pilotDelegate <NSObject>
-(void)fly;
@end

@interface Fruit : NSObject

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *description;

-(id) initWithName:(NSString*)name AndDescription:(NSString*) desc;

@end
