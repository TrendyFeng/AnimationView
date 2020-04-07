//
//  ViewController.m
//  AnimationView
//
//  Created by C on 2020/4/7.
//  Copyright © 2020 TrendyFeng. All rights reserved.
//

#import "ViewController.h"
#import "SignInAlertView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *SignBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)SignAction:(id)sender {
    SignInAlertView *view = [[SignInAlertView alloc] initWithFrame:self.view.frame];
    [view setSignInAlertViewClick:^(NSString *msg){
        [self.SignBtn setTitle:@"已签到" forState:UIControlStateNormal];
    }];
       [self.view addSubview:view];
}


@end
