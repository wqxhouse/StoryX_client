//
//  ClassPair.h
//  TestDI
//
//  Created by Robin Wu on 7/14/14.
//  Copyright (c) 2014 Testing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassPair : NSObject

- (Class)getRealDataClass;
- (Class)getMockDataClass;
- (instancetype)initWithClassPair: (Class)pairOne second:(Class)pairTwo;

- (BOOL)isRealDataActive;
- (void)setRealDataActive: (BOOL)tf;

@end
