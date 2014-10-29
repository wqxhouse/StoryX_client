//
//  IOCan.h
//  IOCan
//
//  Created by Robin Wu on 7/14/14.
//  Copyright (c) 2014 WSH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IOCan: NSObject

+ (id)getInstance: (Protocol *)protocol;

+ (void)bindProtocol: (Protocol *)protocol withClass: (Class) concreteClass;
+ (void)bindProtocol: (Protocol *)protocol
        withRealData: (Class)realDataClass
        withMockData: (Class)mockDataClass;

+ (void)bindRealData: (Protocol *)protocol;
+ (void)bindMockData: (Protocol *)protocol;

@end
