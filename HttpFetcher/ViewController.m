//
//  ViewController.m
//  HttpFetcher
//
//  Created by hirokiumatani on 2015/10/30.
//  Copyright (c) 2015年 hirokiumatani. All rights reserved.
//

#import "ViewController.h"
#import "PEARHttpFetcher.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //sample
    [self sampleHttpRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sampleHttpRequest
{
    PEARHttpFetcher *httpFetcher = [PEARHttpFetcher new];
    [httpFetcher fetchAsyncWithUrlString:@"http://127.0.0.1"
                                 success:^(NSData *responseData)
    {
        //call back success
    }
                                  failed:^(NSError *error)
    {
        //call back failed
    }];
}
@end
