//
//  BackgroundSessionManager.h
//  ESRadio
//
//  Created by Nova Internet on 16/2/17.
//  Copyright © 2017 Nova Internet. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface BackgroundSessionManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

@property (nonatomic, copy) void (^savedCompletionHandler)(void);

@end
