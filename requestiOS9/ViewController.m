//
//  ViewController.m
//  requestiOS9
//
//  Created by Cafex-Development on 17/11/15.
//  Copyright © 2015 Cafex-Development. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //Init the NSURLSession with a configuration
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL *url = [[NSURL alloc]initWithString:@"https://ps1.cloud1.cafex.com:8443/csdk-sample/SDK/login"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    NSArray *objects = [NSArray arrayWithObjects:@"1001", @"123", nil];
    NSArray *keys    = [NSArray arrayWithObjects:@"username", @"password", nil];
    NSData *payLoad = [NSJSONSerialization dataWithJSONObject:[NSDictionary dictionaryWithObjects:objects forKeys:keys] options:0 error:nil];
    //   NSString *params = @"username=1001&password=password";
    
    //   [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    //Create task
    NSURLSessionUploadTask * dataTask =[defaultSession uploadTaskWithRequest:request fromData:payLoad completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //Handle your response here
        NSError *error1;
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error1];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (responseDict) {
                NSLog(@"response %@", responseDict);
            }
        });
    }];
    [dataTask resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
