//
//  NewsItem.h
//  Andyroo
//
//  Created by Andrew Flinders on 5/7/15.
//  Copyright (c) 2015 Andyroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Address.h"

typedef enum : NSInteger {
    News = 0,
    Performance,
} ItemType;

@interface NewsItem : NSObject

@property (assign, nonatomic) NSInteger type;
@property (copy, nonatomic) NSString *headline;
@property (copy, nonatomic) NSString *info;
@property (copy, nonatomic) NSDate *startTime;
@property (copy, nonatomic) NSDate *endTime;
@property (strong, nonatomic) Address *address;
@property (copy, nonatomic) NSString *country;
@property (copy, nonatomic) NSString *streetAddress;
@property (copy, nonatomic) NSString *streetAddress2;
@property (copy, nonatomic) NSString *city;
@property (copy, nonatomic) NSString *state;
@property (copy, nonatomic) NSString *postalCode;
@property (copy, nonatomic) NSString *phone;
@property (copy, nonatomic) NSString *websiteURL;

@end
