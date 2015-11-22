//
//  PEARHttpFercher.h
//  HttpFetcher
//
//  Created by hirokiumatani on 2015/06/02.
//  Copyright (c) 2015年 hirokiumatani. All rights reserved.
//
#import <UIKit/UIKit.h>

/*** request success blocks */
typedef void (^FetchSuccess)(NSData *responceData);

/*** request failed blocks */
typedef void (^FetchFailed)(NSError *error);


/*** @class fetcher web api class */
@interface PEARHttpFetcher : NSObject<NSURLSessionTaskDelegate>

#pragma mark Method
/*** sync fetcher get method */
- (void)fetchSyncWithUrlString:(NSString *)urlString
                       success:(FetchSuccess)success
                        failed:(FetchFailed)failed;
/*** async fetcher get method */
- (void)fetchAsyncWithUrlString:(NSString *)urlString
                        success:(FetchSuccess)success
                         failed:(FetchFailed)failed;

/*** sync fetcher post method */
- (void)fetchSyncWithUrlString:(NSString *)urlString
                     paramData:(NSData *)paramData
                       success:(FetchSuccess)success
                        failed:(FetchFailed)failed;

/*** async fetcher post method */
- (void)fetchAsyncWithUrlString:(NSString *)urlString
                      paramData:(NSData *)paramData
                        success:(FetchSuccess)success
                         failed:(FetchFailed)failed;

/*** genarate post parameter */
- (NSData *)setStringParameter:(NSString *)paramString,...NS_REQUIRES_NIL_TERMINATION;
@end
