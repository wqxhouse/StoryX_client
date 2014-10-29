//
//  ClassPair.m
//  TestDI
//
//  Created by Robin Wu on 7/14/14.
//  Copyright (c) 2014 Testing. All rights reserved.
//

#import "ClassPair.h"

@interface ClassPair ()
{
    Class _t1;
    Class _t2;
    BOOL _realDataActive;
}

@end

@implementation ClassPair

- (Class)getRealDataClass
{
    return _t1;
}

- (Class)getMockDataClass
{
    return _t2;
}

- (BOOL)isRealDataActive
{
    return _realDataActive;
}

- (void)setRealDataActive: (BOOL)tf
{
    _realDataActive = tf;
}

- (instancetype)initWithClassPair: (Class)pairOne second:(Class)pairTwo
{
    self = [super init];
    if(self)
    {
        _t1 = pairOne;
        _t2 = pairTwo;
        _realDataActive = YES;
    }
    return self;
}

@end
