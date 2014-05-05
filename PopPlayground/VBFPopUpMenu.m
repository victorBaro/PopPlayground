//
//  VBFPopUpMenu.m
//  PopPlayground
//
//  Created by Victor Baro on 04/05/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import "VBFPopUpMenu.h"

@interface VBFPopUpMenu () <POPAnimationDelegate> {
    BOOL _isDrawingCircle;
    BOOL _isMenuPresented;
    CGFloat _direction;
    CGPoint _gesturePosition;
}
@property (nonatomic, strong) CAShapeLayer *circle;
@property (nonatomic, strong) NSArray *icons;

@end

@implementation VBFPopUpMenu

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame direction:0 iconArray:nil];
}

- (id) initWithFrame:(CGRect)frame direction:(CGFloat)directionInRadians iconArray:(NSArray *)icons{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _isDrawingCircle = NO;
        _isMenuPresented = NO;
        _direction = directionInRadians;
        self.icons = [[NSArray alloc]initWithArray:icons];
        
        UILongPressGestureRecognizer *longTap = [[UILongPressGestureRecognizer alloc]initWithTarget:self
                                                                                             action:@selector(longPress:)];
        longTap.minimumPressDuration = 0.1;
        [self addGestureRecognizer:longTap];
    }
    return self;
}



- (void) longPress:(UILongPressGestureRecognizer *)longGesture {

    switch(longGesture.state){
        case UIGestureRecognizerStateBegan:
            _gesturePosition = [longGesture locationInView:self];
            [self startCircleAnimationWithLocation:_gesturePosition];
            break;
        case UIGestureRecognizerStateChanged:
            NSLog(@"State changed");
            break;
        case UIGestureRecognizerStateEnded:
            if (_isDrawingCircle) {
                [self stopCircleAnimation];
            } else if (_isMenuPresented) {
                for (UIView*view in self.subviews) {
                    [view removeFromSuperview];
                }
                [self stopCircleAnimation];
            }
            break;
        default:
            break;
    }
}


- (void)pop_animationDidStop:(POPAnimation *)anim finished:(BOOL)finished {
    if (finished) {
        if ([[anim valueForKey:@"animName"] isEqualToString:@"draw"]) {
            //Animation drwaing the circle has finished
            _isDrawingCircle = NO;
            [self presentSubmenu];
            
        } else if ([[anim valueForKey:@"animName"] isEqualToString:@"removeCircle"]) {
            //Animation removing the circle has finished
            [self.circle removeFromSuperlayer];
        }
    }
}

- (void) startCircleAnimationWithLocation:(CGPoint)location {
    // Set up the shape of the circle
    if (!_isDrawingCircle) {
        _isDrawingCircle = YES;
        int radius = 45;
        self.circle = [CAShapeLayer layer];
        self.circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(location.x - radius,
                                                                              location.y - radius,
                                                                              radius*2,
                                                                              radius*2)
                                                      cornerRadius:radius].CGPath;
        
        
        // Configure the apperence of the circle
        self.circle.fillColor = [UIColor clearColor].CGColor;
        self.circle.strokeColor = [UIColor whiteColor].CGColor;
        self.circle.lineWidth = 2;
        
        // Add to parent layer
        [self.layer addSublayer:self.circle];
        
        POPBasicAnimation *draw = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
        draw.fromValue = @(0.0);
        draw.toValue = @(1.0);
        draw.duration = 0.8;
        draw.delegate = self;
        [draw setValue:@"draw" forKey:@"animName"];
        draw.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [self.circle pop_addAnimation:draw forKey:@"draw"];
    }
   
    
    
}

- (void) stopCircleAnimation {
    [self.circle pop_removeAllAnimations];
    POPBasicAnimation *remove = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    remove.toValue = @(0.0);
    remove.duration = 0.3;
    remove.delegate = self;
    [remove setValue:@"removeCircle" forKey:@"animName"];
    [self.circle pop_addAnimation:remove forKey:@"removeCircle"];
    _isDrawingCircle = NO;
}

- (void) presentSubmenu {
    NSMutableArray *iconViews = [[NSMutableArray alloc]init];
    _isMenuPresented = YES;
    
    for (UIImage *iconImage in self.icons) {
        UIImageView *iconView = [[UIImageView alloc]initWithImage:iconImage];
        CGFloat size = 60;

        iconView.frame = CGRectMake(_gesturePosition.x - size/2,
                                    _gesturePosition.y - size/2,
                                    size,
                                    size);
        iconView.alpha = 0.0;
        [self addSubview:iconView];
        [iconViews addObject:iconView];
    }

    int nIcons = [self.icons count];
    int iconNumber = 0;
    
    
    for (UIImageView *icon in iconViews) {
        POPBasicAnimation *alpha = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
        alpha.toValue = @(1.0);
        alpha.duration = 0.3;
        alpha.beginTime = CACurrentMediaTime() + iconNumber*0.1;
        [icon pop_addAnimation:alpha forKey:@"alpha"];
        
        POPDecayAnimation *push = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPosition];
        CGFloat angle = [self angleForIcon:iconNumber numberOfIcons:nIcons];
        CGFloat velocity = 1000;
        push.beginTime = CACurrentMediaTime() + iconNumber*0.1;
        push.deceleration = 0.991;
        push.velocity = [NSValue valueWithCGPoint:CGPointMake(velocity * cosf(angle), velocity * sinf(angle))];
        [icon pop_addAnimation:push forKey:@"push"];
        
        iconNumber += 1;
    }
}

- (CGFloat) angleForIcon:(int)iconNumber numberOfIcons:(int)nIcons {
    CGFloat interSpace = 0.8; //Number of radians between 2 icons
    CGFloat totalAngle = (nIcons -1) * interSpace;
    CGFloat startAngle = _direction - totalAngle/2;
    
    return startAngle + iconNumber*interSpace;
}

@end
