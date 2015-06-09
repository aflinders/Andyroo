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

@interface NewsItem : NSManagedObject

@property (assign, nonatomic) NSInteger type;
@property (copy, nonatomic) NSString *headline;
@property (copy, nonatomic) NSString *info;
@property (copy, nonatomic) NSDate *startTime;
@property (copy, nonatomic) NSDate *endTime;
@property (strong, nonatomic) Address *address;
@property (copy, nonatomic) NSString *phone;
@property (copy, nonatomic) NSString *websiteURL;

@end
