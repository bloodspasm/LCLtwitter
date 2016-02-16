//
//  Singleton.m
//  LCLtwitterDemo
//
//  Created by liaochenliang on 16-2-15.
//  Copyright (c) 2016年 liaochenliang. All rights reserved.
//

#import "Singleton.h"
#import "OAuthConsumer.h"

NSString *Sclient_id = @"0IddQMHlMkLfI4s6ShFEqqXPV";
NSString *Ssecret = @"r4jBwqnhWpdUyNrdxcjqVSMb0K7l6K3c92YsZXUVnCfwKo7eUm";
NSString *Scallback = @"http://127.0.0.1/twitter/callback.php";

@interface Singleton (){
    OAConsumer * _consumer;
    OAToken * _requestToken;
    OAToken * _accessToken;
    void(^_completion)(BOOL isCompletion, NSDictionary *dic);
}
@end

@implementation Singleton

/*  Automatically called from the `+(void)load` method. */
+ (instancetype)sharedManager
{
    //Singleton instance
    static Singleton *kbManager;
    
    //Dispatching it once.
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //  Initializing keyboard manger.
        kbManager = [[self alloc] init];
    });
    
    //Returning kbManager.
    return kbManager;
}

- (void) GetsearchKey:(NSString *)Key GetToken:(NSDictionary *)token Completion:(void (^)(BOOL isCompletion, NSDictionary *dic))completion{
    _completion = completion;
    if (Key!=nil&&[[token allKeys]containsObject:@"_accessToken"]) {
        _consumer = [[OAConsumer alloc] initWithKey:Sclient_id secret:Ssecret];
        NSString *URLstring = [NSString stringWithFormat:@"https://api.twitter.com/1.1/search/tweets.json?q=%@",Key];
        NSURL* accessTokenUrl = [NSURL URLWithString:URLstring];
        _requestToken = token[@"_accessToken"];
        OAMutableURLRequest* requestTokenRequest = [[OAMutableURLRequest alloc] initWithURL:accessTokenUrl
                                                                                   consumer:_consumer
                                                                                      token:_accessToken
                                                                                      realm:nil
                                                                          signatureProvider:nil];
        
        [requestTokenRequest setHTTPMethod:@"GET"];
        OADataFetcher* dataFetcher = [[OADataFetcher alloc] init];
        [dataFetcher fetchDataWithRequest:requestTokenRequest
                                 delegate:self
                        didFinishSelector:@selector(didReceiveuserdata:data:)
                          didFailSelector:@selector(didFailOdatah:error:)];
    }else{
         // ERROR!
        _completion(NO,@{@"error":@"1.检查认证\n2.搜索词有误"});
    }
}

- (void)didReceiveuserdata:(OAServiceTicket*)ticket data:(NSData*)data {
    NSString* httpBody = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSMutableDictionary * dic = [NSJSONSerialization JSONObjectWithData:[httpBody dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    NSLog(@"dic = %@",dic);
    _completion(YES,dic);
}

- (void)didFailOdatah:(OAServiceTicket*)ticket error:(NSError*)error {
    // ERROR!
    _completion(NO,@{@"error":@"error"});
}

@end
