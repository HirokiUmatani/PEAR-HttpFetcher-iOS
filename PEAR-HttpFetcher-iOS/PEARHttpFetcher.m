//
//  HttpFercher.m
//  LessonApp
//
//  Created by hirokiumatani on 2015/06/02.
//  Copyright (c) 2015年 hirokiumatani. All rights reserved.
//

#import "PEARHttpFetcher.h"
static NSString * httpGet     = @"GET";
static NSString * httpPost    = @"POST";
static NSInteger  httpTimeOut = 15;

@implementation PEARHttpFetcher

#pragma mark - Get Sync
- (void)fetchSyncWithUrlString:(NSString *)urlString
                       success:(FetchSuccess)success
                        failed:(FetchFailed)failed
{

    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSMutableURLRequest * urlRequest = [self setHttpRequestWithURL:urlString method:@"GET"];
    NSURLSessionDataTask * task = [session dataTaskWithRequest:urlRequest
                                             completionHandler:^(NSData * data, NSURLResponse * response, NSError * error)
    {
        [self stopNetworkIndicator];
        if (!error)
        {
            NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *) response;
            if (httpResp.statusCode == 200)
            {
                success(data);
            }
        }
    }];
    [self restartNetworkIndicator];
    [task resume];
    
}

#pragma mark - Get ASync
- (void)fetchAsyncWithUrlString:(NSString *)urlString
                        success:(FetchSuccess)success
                         failed:(FetchFailed)failed
{
   
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSMutableURLRequest * urlRequest = [self setHttpRequestWithURL:urlString method:@"GET"];
    NSURLSessionDataTask * task = [session dataTaskWithRequest:urlRequest
                                             completionHandler:^(NSData * data, NSURLResponse * response, NSError * error)
    {
        [self stopNetworkIndicator];
        if (!error)
        {
            NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *) response;
            if (httpResp.statusCode == 200)
            {
                dispatch_async(dispatch_get_main_queue(), ^
                {
                    success(data);
                });
                
            }
        }
    }];
    [self restartNetworkIndicator];
    [task resume];
}

#pragma mark - Post Sync
- (void)fetchSyncWithUrlString:(NSString *)urlString
                     paramData:(NSData *)paramData
                       success:(FetchSuccess)success
                        failed:(FetchFailed)failed
{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSMutableURLRequest * urlRequest = [self setHttpRequestWithURL:urlString method:@"POST"];
    [urlRequest setHTTPBody:paramData];
    NSURLSessionDataTask * task = [session dataTaskWithRequest:urlRequest
                      completionHandler:^(NSData * data, NSURLResponse * response, NSError * error)
    {
        [self stopNetworkIndicator];
        if (!error)
        {
            NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *) response;
            if (httpResp.statusCode == 200)
            {
                success(data);
            }
        }
    }];
    [self restartNetworkIndicator];
    [task resume];

}

#pragma mark - Post ASync
- (void)fetchAsyncWithUrlString:(NSString *)urlString
                      paramData:(NSData *)paramData
                        success:(FetchSuccess)success
                         failed:(FetchFailed)failed
{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSMutableURLRequest * urlRequest = [self setHttpRequestWithURL:urlString method:@"POST"];
    [urlRequest setHTTPBody:paramData];
    NSURLSessionDataTask * task = [session dataTaskWithRequest:urlRequest
                                             completionHandler:^(NSData * data, NSURLResponse * response, NSError * error)
    {
        [self stopNetworkIndicator];
        if (!error)
        {
            NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *) response;
            if (httpResp.statusCode == 200)
            {
                dispatch_async(dispatch_get_main_queue(), ^
                               {
                                   success(data);
                               });
                
            }
        }
    }];
    [self restartNetworkIndicator];
    [task resume];
}

#pragma mark - Set Post Parameter -
- (NSData *)setStringParameter:(NSString *)paramString, ...NS_REQUIRES_NIL_TERMINATION
{
    NSMutableArray *contentLists = @[].mutableCopy;
    va_list args;
    va_start(args, paramString);
    for (NSString *arg = paramString;
         arg != nil;
         arg = va_arg(args, NSString*))
        [contentLists addObject:arg];
    
    va_end(args);
    
    NSMutableString *newContentString = [NSMutableString string];
    [newContentString appendString:@"@\""];
    for(NSInteger i = 0; i < contentLists.count; i++)
    {
        [newContentString appendString:contentLists[i]];
        if (i == contentLists.count - 1)
            break;
        
        if (i % 2 == 0)
            [newContentString appendString:@"="];
        
        else
            [newContentString appendString:@"&"];
    }
    [newContentString appendString:@"\""];
    NSData *result = [newContentString dataUsingEncoding:NSUTF8StringEncoding];
    return result;
}

#pragma mark - Set Request Parameter
- (NSMutableURLRequest *)setHttpRequestWithURL:(NSString *)urlString
                                        method:(NSString *)method
{
    NSURL * url = [NSURL URLWithString:urlString];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:method];
    [urlRequest setTimeoutInterval: httpTimeOut];
    return urlRequest;
}

#pragma mark - Indicator
- (void)restartNetworkIndicator
{
    UIApplication.sharedApplication.networkActivityIndicatorVisible = NO;
    UIApplication.sharedApplication.networkActivityIndicatorVisible = YES;
}
- (void)stopNetworkIndicator
{
    UIApplication.sharedApplication.networkActivityIndicatorVisible = NO;
}
@end
