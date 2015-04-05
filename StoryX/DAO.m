//
//  DAO.m
//  TestDI
//
//  Created by Robin Wu on 7/16/14.
//  Copyright (c) 2014 Testing. All rights reserved.
//

#import "DAO.h"
#import <AFNetworking/AFNetworking.h>

@interface DAO ()
@end

static AFHTTPRequestOperationManager *_manager;
static AFHTTPRequestOperationManager *_jsonReqManager;
static dispatch_queue_t _cacheThreadToken;
static const char *kCacheThreadName = "_DAOCacheThread";
static BOOL alertShown = false;

@implementation DAO

+ (AFSecurityPolicy*) securityPolicy
{
    /**** SSL Pinning ****/
    NSString *certPath = [[NSBundle mainBundle] pathForResource:@"server" ofType:@"cer"];
    NSData *certData = [NSData dataWithContentsOfFile:certPath];
    
    if(certData == nil)
    {
        return nil;
    }
    
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    [securityPolicy setPinnedCertificates:@[certData]];
   // [securityPolicy setSSLPinningMode:AFSSLPinningModeCertificate];
    
    return securityPolicy;
}

+ (void)initialize
{
//    _cacheThreadToken = dispatch_queue_create(kCacheThreadName, NULL);
//    _manager = [AFHTTPRequestOperationManager manager];
//    _jsonReqManager = [AFHTTPRequestOperationManager manager];
//    _jsonReqManager.requestSerializer = [AFJSONRequestSerializer serializer];
//    AFSecurityPolicy *secure = [self securityPolicy];
//    if(secure == nil)
//    {
//        _manager = nil;
//        _jsonReqManager = nil;
//    }
//    else
//    {
//        [_manager setSecurityPolicy:[self securityPolicy]];
//        [_jsonReqManager setSecurityPolicy:[self securityPolicy]];
//    }
    _manager = [AFHTTPRequestOperationManager manager];
}

+ (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    alertShown = false;
}


+ (void)getRequest: (NSString *)requestUrl callback: (void(^)(NSDictionary *, NSError *))callback
{
    if(_manager == nil)
    {
        NSError *error = [NSError errorWithDomain:@"error.DAO" code:404 userInfo:[NSDictionary dictionaryWithObject:@"Server error, manager is nil" forKey:NSLocalizedDescriptionKey]];
        callback(nil, error);
        return;
    }
    
    [_manager GET: requestUrl
       parameters: nil
          success: ^(AFHTTPRequestOperation *operation, id responseObject) {
//              if([self checkErrorCode:responseObject])
//              {
//                  callback(responseObject, nil);
//              }
              NSLog(@"get");
              callback(responseObject, nil);
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [self handleError: error];
              NSLog(@"get error");
              callback(nil, error);
          }];
}

+ (void)postRequest: (NSString *)requestUrl withData: (NSDictionary *)postData
           callback: (void(^)(NSDictionary *, NSError *))callback
{
    if(_manager == nil)
    {
        NSError *error = [NSError errorWithDomain:@"error.DAO" code:405 userInfo:[NSDictionary dictionaryWithObject:@"Server error, manager is nil" forKey:NSLocalizedDescriptionKey]];
        callback(nil, error);
        return;
    }
    
    [_manager POST: requestUrl
        parameters: postData
           success: ^(AFHTTPRequestOperation *operation, id responseObject) {
//               if([self checkErrorCode:responseObject])
//               {
//                   callback(responseObject, nil);
//               }
              NSLog(@"get");
           }
           failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
               
               NSLog(@"get error");
               callback(nil, error);
           }];
}

+ (void)handleError: (NSError *)err
{
    NSLog(@"DAO handling error");
}


@end
