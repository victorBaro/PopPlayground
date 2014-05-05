//
//  ViewController.m
//  PopPlayground
//
//  Created by Victor Baro on 30/04/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addLabels];
    [self addCircleSubviews];
}

- (void) addLabels {
    NSArray *textArray = @[@"CABasic animation - EaseInOut",@"Pop Basic Animation - EaseInOut",@"UIView animation system spring", @"Pop Spring Animation", @"Pop Decay animation"];
    for (int i=1; i < 6; i++) {
        CGRect frame = CGRectMake(0, 120*i, 500, 75);
        UILabel *label = [[UILabel alloc]initWithFrame:frame];
        label.font = [UIFont fontWithName:@"Heiti SC Light" size:24];
        label.textColor = [UIColor flatWetAsphaltColor];
        label.alpha = 0.5;
        label.text = textArray[i-1];
        label.textAlignment = NSTextAlignmentCenter;
        label.center = CGPointMake(self.view.center.y, label.center.y);
        [self.view addSubview:label];
    }
}

- (void) addCircleSubviews {
    for (int i=1; i < 6; i++) {
        CGFloat diameter = 75;
        CGRect frame = CGRectMake(50, 120*i, diameter, diameter);
        UIView *view = [[UIView alloc]initWithFrame:frame];
        view.layer.cornerRadius = diameter/2;
        view.backgroundColor = [UIColor flatRandomColor];
        view.tag = i;
        if (i != 5) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTapped:)];
            [view addGestureRecognizer:tap];
        } else {
            UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(viewDragged:)];
            [view addGestureRecognizer:pan];
        }
        
        [self.view addSubview:view];
    }
}

- (void) viewTapped:(UITapGestureRecognizer *)tap {
    UIView *tappedView = tap.view;

    switch (tap.view.tag) {
        case 1:
            [self addBasicEaseAnimationToView:tappedView];
            break;
        case 2:
            [self addPopBasicAnimationToView:tappedView];
            break;
        case 3:
            [self addSystemSpringAnimationToView:tappedView];
            break;
        case 4:
            [self addPopSpringAnimationToView:tappedView];
            break;
        case 5:
            
            break;
        default:
            break;
    }
}

- (void) addBasicEaseAnimationToView:(UIView *)view {
    [UIView animateWithDuration:0.8
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         CGFloat amount = 700;
                         
                         if (view.frame.origin.x == 50) {
                             view.frame = CGRectOffset(view.frame, amount, 0);
                         } else {
                             view.frame = CGRectOffset(view.frame, -amount, 0);
                         }
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (void) addPopBasicAnimationToView:(UIView *)view {
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.duration = 0.8;
    if (view.frame.origin.x == 50) {
        anim.toValue = @(view.center.x + 700);
    } else {
        anim.toValue = @(view.center.x - 700);
    }
    [view pop_addAnimation:anim forKey:@"positionX"];
}

- (void) addSystemSpringAnimationToView:(UIView *)view {
    [UIView animateWithDuration:1.0
                          delay:0.0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         CGFloat amount = 700;
                         
                         if (view.frame.origin.x == 50) {
                             view.frame = CGRectOffset(view.frame, amount, 0);
                         } else {
                             view.frame = CGRectOffset(view.frame, -amount, 0);
                         }
                     } completion:^(BOOL finished) {
                         
                     }];
    
}

- (void) addPopSpringAnimationToView:(UIView *)view {
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    anim.springBounciness = 10;
    anim.springSpeed = 10;
    if (view.frame.origin.x == 50) {
        anim.toValue = @(view.center.x + 700);
    } else {
        anim.toValue = @(view.center.x - 700);
    }
    [view.layer pop_addAnimation:anim forKey:@"postionX"];
}


- (void) viewDragged:(UIPanGestureRecognizer *) pan {

    if (pan.state == UIGestureRecognizerStateEnded) {
        
        POPDecayAnimation *anim = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPositionX];
        anim.velocity = @([pan velocityInView:self.view].x);
        anim.deceleration = 0.99;
        [pan.view pop_addAnimation:anim forKey:@"slide"];
        
        
    } else {
        CGPoint translation = [pan translationInView:self.view];
        
        pan.view.center = CGPointMake(pan.view.center.x + translation.x, pan.view.center.y);
        
        [pan setTranslation:CGPointZero inView:self.view];
    }
    
   

}


@end
