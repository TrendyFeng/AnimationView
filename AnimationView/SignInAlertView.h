//
//  SignInAlertView.h
//  ylShop
//
//  Created by C on 2017/6/20.
//  Copyright © 2017年 eeepay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignInAlertView : UIView


@property (nonatomic, copy) void (^SignInAlertViewClick)(NSString *msg);
@property (nonatomic, copy) void (^completeClick)(void);

@property (strong, nonatomic) NSString *advertiseLink; //广告链接
@property (strong, nonatomic) NSString *advertiseTitle; //广告标题

- (instancetype)initWithFrame:(CGRect)frame;
- (void)hiddenView;

@end
