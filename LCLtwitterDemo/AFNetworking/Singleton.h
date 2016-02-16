//
//  Singleton.h
//  LCLtwitterDemo
//
//  Created by liaochenliang on 16-2-15.
//  Copyright (c) 2016年 liaochenliang. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface Singleton : NSObject

/**
 Returns the default singleton instance.
 */
+ (instancetype)sharedManager;

/**
 *  search_tweets_json
 *
 *  @param Key   searchkey
 *  @param token requestToken
 *  @param completion json
 */
- (void) GetsearchKey:(NSString *)Key GetToken:(NSDictionary *)token Completion:(void (^)(BOOL isCompletion, NSDictionary *dic))completion;


@end
