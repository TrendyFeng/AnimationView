//
//  SignInAlertView.m
//  ylShop
//
//  Created by C on 2017/6/20.
//  Copyright © 2017年 eeepay. All rights reserved.
//

#import "SignInAlertView.h"
#import "KDAnimation.h"
@interface SignInAlertView ()<UIGestureRecognizerDelegate>

@end

@implementation SignInAlertView{
    
    UIView *backgroundView;
    //--
    UIImageView *firstTimeView;
    //--
    BOOL signIn;
    UIImageView *signInView;
    UIImageView *loadImgView;
    //--
    UIImageView *doneView;
    
}


- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGPathAddLineToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGPathAddLineToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGPathAddLineToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMinY(rect));
    CGPathCloseSubpath(path);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    
    NSArray *colors = @[(__bridge id) [UIColor clearColor].CGColor, (__bridge id) [UIColor blackColor].CGColor];
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    
    CGRect pathRect = CGPathGetBoundingBox(path);
    CGPoint center = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMidY(pathRect));
    CGFloat radius = MAX(pathRect.size.width / 2.0, pathRect.size.height / 2.0) * sqrt(2);
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextEOClip(context);
    
    CGContextDrawRadialGradient(context, gradient, center, 0, center, radius, 0);
    
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    CGPathRelease(path);
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    [self setBackgroundColor:[UIColor clearColor]];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenView)];
    [self addGestureRecognizer:tap];
    [tap setDelegate:self];
    
    backgroundView = [[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width - 277)/2,
                                                              (self.frame.size.height - 356)/2,
                                                              277, 356)];
    [self addSubview:backgroundView];
    
    [self makeDoneUIWithAmount:nil];
    [self makeBaseUIWithDict:nil];
    [self makeFirstTimeUI];
    
    [KDAnimation showAnimationWithView:backgroundView];
    
    
    return self;
}


- (void)makeFirstTimeUI{
    
    firstTimeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 277, 356)];
    firstTimeView.backgroundColor = [UIColor clearColor];
    firstTimeView.image = [UIImage imageNamed:@"SR_shuoming_img"];
    firstTimeView.userInteractionEnabled = YES;
    [backgroundView addSubview:firstTimeView];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(firstTimeView.frame.size.width - 40, 0, 40, 40);
    closeBtn.backgroundColor = [UIColor clearColor];
    [closeBtn setImage:[UIImage imageNamed:@"SR_close_img"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(hiddenView) forControlEvents:UIControlEventTouchUpInside];
    [firstTimeView addSubview:closeBtn];
    
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 2;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14],
                                 NSParagraphStyleAttributeName:paragraphStyle};
    
    
    
    NSString *contentStr = [NSString stringWithFormat:@"活动说明：\n每次签到都会获得平台赠送的鼓励金。活动所有获得的鼓励金只能用于抵扣提现手续费，且不可提现。每次赠送金额有效期3天，从赠送当天开始计算。过期则无法使用。商户需要确认参加签到活动，本活动最终解释权归本公司所有。"];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(18, 103,
                                                                        firstTimeView.frame.size.width - 18*2,
                                                                        firstTimeView.frame.size.height - 65 - 108)];
    textView.attributedText = [[NSAttributedString alloc] initWithString:contentStr attributes:attributes];
    textView.backgroundColor = [UIColor clearColor];
    textView.textColor = [UIColor blueColor];
    textView.editable = NO;
    [firstTimeView addSubview:textView];
    
    
    
    UIButton *signInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    signInBtn.frame = CGRectMake(25, firstTimeView.frame.size.height -30 -35,
                                 firstTimeView.frame.size.width - 25*2, 35);
    signInBtn.backgroundColor = [UIColor clearColor];
    [signInBtn setBackgroundImage:[UIImage imageNamed:@"blue_btn_nor"] forState:UIControlStateNormal];
    [signInBtn setTitle:@"同  意" forState:UIControlStateNormal];
    [signInBtn addTarget:self action:@selector(agreeAction) forControlEvents:UIControlEventTouchUpInside];
    [firstTimeView addSubview:signInBtn];
    
}

- (void)agreeAction{
    
    [UIView transitionFromView:firstTimeView
                        toView:signInView
                      duration:1.0
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    completion:nil];
    
    
}



- (void)makeBaseUIWithDict:(NSArray *)titleArr{
    
    signInView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 277, 356)];
    signInView.backgroundColor = [UIColor clearColor];
    signInView.image = [UIImage imageNamed:@"SR_shuoming_img"];
    signInView.userInteractionEnabled = YES;
    [backgroundView addSubview:signInView];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(signInView.frame.size.width - 40, 0, 40, 40);
    closeBtn.backgroundColor = [UIColor clearColor];
    [closeBtn setImage:[UIImage imageNamed:@"SR_close_img"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(hiddenView) forControlEvents:UIControlEventTouchUpInside];
    [signInView addSubview:closeBtn];
    
    UILabel *contentLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, (signInView.frame.size.height - 60)/ 2 - 20,
                                                                    signInView.frame.size.width, 60)];
    contentLbl.numberOfLines = 0;
    contentLbl.text = [NSString stringWithFormat:@"签到可获得鼓励金\n每日可签到一次"];
    contentLbl.textAlignment = NSTextAlignmentCenter;
    contentLbl.font = [UIFont systemFontOfSize:15.0f];
    contentLbl.textColor = [UIColor blackColor];
    [signInView addSubview:contentLbl];
    
    NSMutableArray *gifArray = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < 24 ; i++){
        [gifArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"signInLoadImg-%d.jpg",i+1]]];
    }
    loadImgView = [[UIImageView alloc] initWithFrame:CGRectMake((signInView.frame.size.width - 80/2)/2,
                                                                contentLbl.frame.origin.y + 60 + 10, 80/2, 80/2)];
    loadImgView.animationImages = gifArray;
    loadImgView.animationDuration = 1;
    [loadImgView startAnimating];
    loadImgView.hidden = YES;
    [signInView addSubview:loadImgView];
    
    
    UIButton *signInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    signInBtn.frame = CGRectMake(25, signInView.frame.size.height -30 -35,
                                 signInView.frame.size.width - 25*2, 35);
    signInBtn.backgroundColor = [UIColor clearColor];
    [signInBtn setBackgroundImage:[UIImage imageNamed:@"blue_btn_nor"] forState:UIControlStateNormal];
    [signInBtn setTitle:@"立即签到" forState:UIControlStateNormal];
    [signInBtn addTarget:self action:@selector(signInAction:) forControlEvents:UIControlEventTouchUpInside];
    [signInView addSubview:signInBtn];
    
    
}

- (void)signInAction:(UIButton *)sender{
    
    loadImgView.hidden = NO;
    sender.enabled = NO;
    signIn = YES;
    
    [self requestSignIn];
}

- (void)successAnimation{
    
    NSMutableArray *gifArray = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < 50 ; i++){
        [gifArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"signInLoadImg-%d.jpg",i+1]]];
    }
    loadImgView.animationImages = gifArray;
    loadImgView.animationDuration = 2;
    loadImgView.animationRepeatCount = 1;
    loadImgView.image = [UIImage imageNamed:@"signInLoadImg-50.jpg"];
    [loadImgView startAnimating];
    
    [self performSelector:@selector(signInSuccess) withObject:nil afterDelay:2];
}

- (void)signInSuccess{
    
    signIn = NO;
    
    [UIView transitionFromView:signInView
                        toView:doneView
                      duration:1.0
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    completion:nil];
    
}


- (void)makeDoneUIWithAmount:(NSString *)amount{
    
    doneView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 277, 356)];
    doneView.backgroundColor = [UIColor clearColor];
    doneView.image = [UIImage imageNamed:@"SR_white_img"];
    doneView.userInteractionEnabled = YES;
    [backgroundView addSubview:doneView];
    
    UIImageView *adImgView = [[UIImageView alloc] initWithFrame:CGRectMake((doneView.frame.size.width - 60)/2 + 3, 15, 60, 55)];
    adImgView.image = [UIImage imageNamed:@"SR_qianba_img"];
    [adImgView setBackgroundColor:[UIColor clearColor]];
    [doneView addSubview:adImgView];
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, adImgView.frame.origin.y + adImgView.frame.size.height + 5,
                                                                  doneView.frame.size.width, 21)];
    titleLbl.text = @"恭喜您获得签到鼓励金";
    [titleLbl setBackgroundColor:[UIColor clearColor]];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.font = [UIFont systemFontOfSize:14.0f];
    titleLbl.textColor = [UIColor blackColor];
    [doneView addSubview:titleLbl];
    
    
    NSString *contentStr = [NSString stringWithFormat:@"2.0"];
    //NSMutableAttributedString *amountStr = [[NSMutableAttributedString alloc]initWithString:contentStr];
    //NSRange numRange = NSMakeRange(0, amountStr.length - 1);
    //NSRange yuanRange = NSMakeRange(amountStr.length - 1, 1);
    //[amountStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:50] range:numRange];
    //[amountStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:yuanRange];
    
    UILabel *amountLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLbl.frame.origin.y + titleLbl.frame.size.height,
                                                                   doneView.frame.size.width, 50)];
    amountLbl.text = contentStr;
    amountLbl.font = [UIFont boldSystemFontOfSize:50];
    amountLbl.textAlignment = NSTextAlignmentCenter;
    amountLbl.textColor = [UIColor blackColor];
    [doneView addSubview:amountLbl];
    
    
    UILabel *contentLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, amountLbl.frame.origin.y + amountLbl.frame.size.height,
                                                                    doneView.frame.size.width, 21)];
    contentLbl.text = @"已经存入鼓励金账户";
    contentLbl.textAlignment = NSTextAlignmentCenter;
    contentLbl.font = [UIFont systemFontOfSize:13.f];
    contentLbl.textColor = [UIColor blackColor];
    [doneView addSubview:contentLbl];
    
    
    UIButton *adWebView = [[UIButton alloc] init];
    adWebView.frame = CGRectMake(3, doneView.frame.size.height - 20 - doneView.frame.size.width / 270 * 108,
                                 doneView.frame.size.width - 6, doneView.frame.size.width / 270 * 108);
    [adWebView setBackgroundColor:[UIColor clearColor]];
    [doneView addSubview:adWebView];

    
    UIButton *signInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    signInBtn.frame = CGRectMake(25, adWebView.frame.origin.y -35 -15 ,
                                 doneView.frame.size.width - 25*2, 35);
    signInBtn.backgroundColor = [UIColor clearColor];
    [signInBtn setBackgroundImage:[UIImage imageNamed:@"blue_btn_nor"] forState:UIControlStateNormal];
    [signInBtn setTitle:@"完成" forState:UIControlStateNormal];
    [signInBtn addTarget:self action:@selector(hiddenView) forControlEvents:UIControlEventTouchUpInside];
    [doneView addSubview:signInBtn];
    
    
}

- (void)openAD{
    
    [self hiddenView];
    if (self.SignInAlertViewClick) {
        _SignInAlertViewClick(@"openAD");
    }
    
}


- (void)hiddenView {
    
    if (signIn == YES) {
        return;
    }
    if (self.completeClick) {
        _completeClick();
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self removeFromSuperview];
    });
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return (touch.view == self);
    
}


- (void)requestSignIn{    

            if (self.SignInAlertViewClick) {
                self.SignInAlertViewClick(nil);
            }
            
            [self successAnimation];
            
//            self->signIn = NO;
//            [self hiddenView];
//
//            if (self.SignInAlertViewClick) {
//                self->_SignInAlertViewClick(model.errMsg?:@"网络异常，请稍后再试 code.1006");
//            }
                
}


@end
