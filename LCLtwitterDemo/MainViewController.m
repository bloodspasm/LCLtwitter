//
//  MainViewController.m
//  LCLtwitterDemo
//
//  Created by liaochenliang on 16-2-15.
//  Copyright (c) 2016年 liaochenliang. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController (){
    NSDictionary *Token;
}
@property (weak, nonatomic) IBOutlet UITextView *TextView;
@property (weak, nonatomic) IBOutlet UITextField *TextField;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)_touchGetTokenandKey:(id)sender {
    TwitterOAuthViewController * twitterOAuthVC = [[TwitterOAuthViewController alloc] initWithCompletion:^(BOOL succeeded, id object) {
        if (succeeded && object) {
            // get token
            Token = object;
            NSLog(@"Token = %@",Token);
        }
    }];
    [self.navigationController pushViewController:twitterOAuthVC animated:YES];
}

- (IBAction)_actionSearchinfo:(id)sender {
    //Search
    [self.view endEditing:YES];
    [[Singleton sharedManager]GetsearchKey:self.TextField.text GetToken:Token Completion:^(BOOL isCompletion, NSDictionary *dic) {
        if (isCompletion) {
            self.TextView.text = [NSString stringWithFormat:@"%@",dic];
        }
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
