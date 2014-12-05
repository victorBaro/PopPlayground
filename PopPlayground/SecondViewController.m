//
//  SecondViewController.m
//  PopPlayground
//
//  Created by Victor Baro on 02/05/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import "SecondViewController.h"


@interface SecondViewController () <POPAnimationDelegate>

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *mainViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mainViewTap:)];
    [self.view addGestureRecognizer:mainViewTap];

}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    CGFloat diameter = 80;
    int tag = 1;
    for (int i=1; i < 4; i++) {
        for (int j=1; j<4; j++) {
            CGRect frame = CGRectMake(240*j, 180*i, diameter, diameter);
            UIView *view = [[UIView alloc]initWithFrame:frame];
            view.backgroundColor = [UIColor flatEmeraldColor];
            
            if (tag != 5) {
                //View 5 will be square
                view.layer.cornerRadius = diameter/2;
            }
            
            if (tag == 7) {
                UIImageView *cloud = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"downloadCloud"]];
                cloud.center = CGPointMake(diameter/2,diameter/2);
                [view addSubview:cloud];
            }
            
            view.tag = tag;
            
            if (tag != 6) {
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTapped:)];
                [view addGestureRecognizer:tap];
            } else {
                UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(viewDragged:)];
                [view addGestureRecognizer:pan];
            }
            
            
            if (tag < 9) {
                [self.view addSubview:view];
            }
            
            view.alpha = 0.0;
            
            //ADD APPEAR ANIMATION
            POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewAlpha];
            anim.springBounciness = 8;
            anim.springSpeed = 4;
            anim.toValue = @(1.0);
            anim.beginTime = CACurrentMediaTime()+0.1*tag;
            [view pop_addAnimation:anim forKey:@"appear"];
            tag += 1;
        }
    }
}

- (void) viewTapped:(UITapGestureRecognizer *)tapGesure {
    UIView *tappedView = tapGesure.view;
    
    switch (tappedView.tag) {
        case 1:
            [self addBckgColorBasicChangeAnimationToView:tappedView];
            break;
        case 2:
            [self addBckgColorSpringChangeAnimationToView:tappedView];
            break;
        case 3:
            [self addBoundsSpringAnimationToView:tappedView];
            break;
        case 4:
            [self addXRotationAnimationToView:tappedView];
            break;
        case 5:
            [self addJumpAndRotationToView:tappedView];
            break;
        case 6:
            //There is no case 6 for view tapped, the view 6 will be dragged
            break;
        case 7:
            [self animateRoundToProgressIndicatorToView:tappedView];
            break;
        default:
            break;
    }
}

- (void) viewDragged:(UIPanGestureRecognizer *) panGesture {
    if (panGesture.state == UIGestureRecognizerStateEnded) {
        POPDecayAnimation *decay = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerRotationY];
        decay.velocity = @([panGesture velocityInView:self.view].x/10);
        decay.deceleration = 0.99;
        [panGesture.view.layer pop_addAnimation:decay forKey:@"decay"];
        
    } else {
        CGPoint translation = [panGesture translationInView:self.view];
        
        panGesture.view.layer.transform = CATransform3DMakeRotation(translation.x/10,0.0,1.0,0.0);

    }
}

- (void) mainViewTap:(UITapGestureRecognizer *)tapGesture {
    for (UIView *view in self.view.subviews) {
        if (view.tag == 8) {

            POPSpringAnimation *anim = [POPSpringAnimation animation];
            anim = [view pop_animationForKey:@"translate"];
            CGPoint location = [tapGesture locationInView:self.view];
            
            if (anim) {
                /* update to value to new destination */
                anim.toValue = [NSValue valueWithCGPoint:location];
                //anim.duration = distance/speed;
            } else {
                /* create and start a new animation */
                anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
                anim.toValue = [NSValue valueWithCGPoint:location];
                anim.springSpeed = 3;
                anim.springBounciness = 3;
                [view pop_addAnimation:anim forKey:@"translate"];
            }
            
        }
    }
}


- (void) addBckgColorBasicChangeAnimationToView:(UIView *)view {
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewBackgroundColor];
    anim.duration = 1.0;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.toValue = (__bridge id)([UIColor flatEmeraldColor].CGColor);
    
    [view pop_addAnimation:anim forKey:@"popColorBasic"];
}

- (void) addBckgColorSpringChangeAnimationToView:(UIView *)view {
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewBackgroundColor];
    anim.toValue =  (__bridge id)([UIColor flatEmeraldColor].CGColor);
    anim.springBounciness = 20;
    
    [view pop_addAnimation:anim forKey:@"popColorSpring"];
}

- (void) addBoundsSpringAnimationToView:(UIView *)view {
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
    CGFloat amount = 80.0;
    if (CGRectGetHeight(view.frame) == CGRectGetWidth(view.frame)) {
        anim.toValue = [NSValue valueWithCGRect:CGRectInset(view.frame, -amount, 0)];
        anim.springBounciness = 18;
    } else {
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(720, 180, 80, 80)];
    }
    
    anim.springSpeed = 10;
    [view.layer pop_addAnimation:anim forKey:@"popBounds"];
}

- (void) addXRotationAnimationToView:(UIView *)view {
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotationY];
    anim.duration = 1.0;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    view.layer.anchorPoint = CGPointMake(0.5, 0.5);
    anim.toValue = @(2*M_PI);
    [view.layer pop_addAnimation:anim forKey:@"popRotationY"];
}

- (void) addJumpAndRotationToView:(UIView *)view{
    POPBasicAnimation *rot = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotationX];
    rot.duration = 1.0;
    rot.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    view.layer.anchorPoint = CGPointMake(0.5, 0.5);
    rot.toValue = @(3*M_PI);
    [view.layer pop_addAnimation:rot forKey:@"popRotationX"];

    POPBasicAnimation *scaleUp = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerSize];
    scaleUp.duration = 0.5;
    scaleUp.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    view.layer.anchorPoint = CGPointMake(0.5, 0.5);
    scaleUp.toValue = [NSValue valueWithCGSize:CGSizeMake(view.frame.size.width * 1.5, view.frame.size.height * 1.5)];
    [view.layer pop_addAnimation:scaleUp forKey:@"popScaleUp"];
    
    POPSpringAnimation *scaleD = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerSize];
    scaleD.beginTime = CACurrentMediaTime()+0.5;
    scaleD.toValue = [NSValue valueWithCGSize:CGSizeMake(view.frame.size.width, view.frame.size.height)];
    scaleD.springSpeed = 4;
    scaleD.springBounciness = 8;
    [view.layer pop_addAnimation:scaleD forKey:@"popScaleD"];
    
    /*
    POPBasicAnimation *scaleDown = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerSize];
    scaleDown.beginTime = CACurrentMediaTime()+0.5;
    scaleDown.duration = 0.5;
    scaleDown.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    scaleDown.toValue = [NSValue valueWithCGSize:CGSizeMake(view.frame.size.width, view.frame.size.height)];
    [view.layer pop_addAnimation:scaleDown forKey:@"popScaleDown"];*/
}

- (void) animateRoundToProgressIndicatorToView:(UIView *) view {
    if ([view.subviews count] > 0) {
        UIImageView *cloud = view.subviews[0];
        [cloud removeFromSuperview];
    }
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
    anim.toValue = [NSValue valueWithCGRect:CGRectInset(view.frame, -80, 25)];
    anim.springBounciness = 8;
    anim.delegate = self;
    [view.layer pop_addAnimation:anim forKey:@"popBounds"];
    
    POPBasicAnimation *cornerRad = [POPBasicAnimation animation];
    POPAnimatableProperty *cornerRadius = [POPAnimatableProperty propertyWithName:@"layer.cornerRadius"
                                                                      initializer:^(POPMutableAnimatableProperty *prop) {
        // read value
        prop.readBlock = ^(id obj, CGFloat values[]) {
            values[0] = [obj cornerRadius];
        };
        // write value
        prop.writeBlock = ^(id obj, const CGFloat values[]) {
            [obj setCornerRadius:values[0]];
        };
        // dynamics threshold
        prop.threshold = 0.01;
    }];
    
    cornerRad.property = cornerRadius;
    cornerRad.duration = 0.3;
    cornerRad.toValue = @(10);
    
    [view.layer pop_addAnimation:cornerRad forKey:@"cornerRadius"];
}


#pragma -
#pragma PopAnimation delegate methods

- (void)pop_animationDidStop:(POPAnimation *)anim finished:(BOOL)finished {
    //You should check animation key
    UIView *roundView = [[UIView alloc]init];
    for (UIView *view in self.view.subviews) {
        if (view.tag == 7) {
            roundView = view;
        }
    }
    if (finished) {
        UIView *progress = [[UIView alloc]initWithFrame:CGRectInset(roundView.frame, 2, 2)];
        progress.layer.cornerRadius = 8;
        progress.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.6];
        progress.alpha = 0.0;
        [roundView addSubview:progress];
        
        POPBasicAnimation *alpha = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
        alpha.duration = 0.2;
        alpha.toValue = @(1.0);
        [progress pop_addAnimation:alpha forKey:@"alpha"];
        
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerBounds];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(progress.frame.origin.x,
                                                             progress.frame.origin.y,
                                                             0,
                                                             progress.frame.size.height)];
        anim.toValue = [NSValue valueWithCGRect:progress.frame];
        anim.duration = 3;
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [progress.layer pop_addAnimation:anim forKey:@"progress"];
        
        POPBasicAnimation *trans = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerTranslationX];
        trans.fromValue = @(-progress.frame.size.width/2);
        trans.toValue = @(0);
        trans.duration = anim.duration;
        trans.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [progress.layer pop_addAnimation:trans forKey:@"translation"];
    }
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
}

@end
