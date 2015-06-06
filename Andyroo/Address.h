//
//  Address.h
//  Andyroo
//
//  Created by Andrew Flinders on 6/5/15.
//  Copyright (c) 2015 Andyroo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Address : NSObject

@property (assign, nonatomic) NSInteger number;
@property (copy, nonatomic) NSString *street;
@property (copy, nonatomic) NSString *unit;
@property (copy, nonatomic) NSString *city;
@property (copy, nonatomic) NSString *state;
@property (copy, nonatomic) NSString *postalCode;
@property (copy, nonatomic) NSString *country;

@end
