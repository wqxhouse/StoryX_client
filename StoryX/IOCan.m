//
//  IOCan.m
//  IOCan
//
//  Created by Robin Wu on 7/14/14.
//  Copyright (c) 2014 WSH. All rights reserved.
//

#import "IOCan.h"
#import "ClassPair.h"

static NSMutableDictionary *_assoc;
static NSMutableDictionary *_instances;
@implementation IOCan

+ (void) initialize
{
    _assoc = [NSMutableDictionary dictionary];
    _instances = [NSMutableDictionary dictionary];
}

+ (id)getInstance: (Protocol *)protocol
{
    NSString *protocolName = NSStringFromProtocol(protocol);
    ClassPair *cp = (ClassPair *)[_assoc objectForKey:protocolName];
    if (cp != nil)
    {
        id classObj;
        if ([cp isRealDataActive])
        {
            classObj = [cp getRealDataClass];
            //classObj = [cp getMockDataClass];
        }
        else
        {
            classObj = [cp getMockDataClass];
        }
        //id classObj = [_assoc objectForKey:protocolName];
        if (classObj)
        {
            NSString *className = NSStringFromClass(classObj);
            id instance = [_instances objectForKey:className];
            @synchronized(self)
            {
                if (instance == nil)
                {
                    instance = [[classObj alloc] init];
                    [_instances setObject:instance forKey:className];
                }
            }
            return instance;
        }
        else if(![cp isRealDataActive])
        {
            [NSException raise:@"protocol not registered" format:@"protocol %@ is not registered for mock data", protocolName];
        }
    }
    else
    {
        [NSException raise:@"protocol not registered" format:@"protocol %@ is not registered", protocolName];
    }
    
    return nil;
}

+ (void)bindProtocol: (Protocol *)protocol withClass: (Class) concreteClass
{
    [self bindProtocol:protocol withRealData:concreteClass withMockData:nil];
}

+ (void)bindProtocol:(Protocol *)protocol
        withRealData:(Class)realDataClass
        withMockData:(Class)mockDataClass
{
    NSString *protocolName = NSStringFromProtocol(protocol);
    ClassPair *cp = [[ClassPair alloc] initWithClassPair:realDataClass second:mockDataClass];
    [_assoc setObject:cp forKey:protocolName];
}

+ (void)bindRealData: (Protocol *)protocol
{
    NSString *protocolName = NSStringFromProtocol(protocol);
    ClassPair *cp = [_assoc objectForKey:protocolName];
    if (cp != nil)
    {
        [cp setRealDataActive:YES];
    }
    else
    {
        [NSException raise:@"protocol not registered" format:@"protocol %@ is not registered", protocolName];
    }
}

+ (void)bindMockData: (Protocol *)protocol
{
    NSString *protocolName = NSStringFromProtocol(protocol);
    ClassPair *cp = [_assoc objectForKey:protocolName];
    if (cp != nil)
    {
        [cp setRealDataActive:NO];
    }
    else
    {
        [NSException raise:@"protocol not registered" format:@"protocol %@ is not registered", protocolName];
    }
}

@end
