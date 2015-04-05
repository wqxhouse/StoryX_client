//
//  DAO.h
//  TestDI
//
//  Created by Robin Wu on 7/16/14.
//  Copyright (c) 2014 Testing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAO : NSObject
+ (void)initialize;
+ (void)getRequest: (NSString *)requestUrl callback: (void(^)(NSDictionary *, NSError *))callback;
+ (void)postRequest: (NSString *)requestUrl withData: (NSDictionary *)postData
           callback: (void(^)(NSDictionary *, NSError *))callback;
+ (void)handleError: (NSError *)err;
@end
