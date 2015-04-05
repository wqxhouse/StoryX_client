//
//  UrlPath.m
//  StoryX
//
//  Created by Robin Wu on 10/28/14.
//  Copyright (c) 2014 WSH. All rights reserved.
//

#import "UrlPath.h"

NSString *const _baseUrl = @"http://127.0.0.1:56789/home";
@implementation UrlPath

+ (NSString *)getHelloworldStr: (NSString *)str
{
    return [NSString stringWithFormat:@"%@/%@", _baseUrl, str];
}

+ (NSString *)sendString: (NSString *)str{

  return [NSString stringWithFormat:@"%@/%@", _baseUrl, str];
}

@end
