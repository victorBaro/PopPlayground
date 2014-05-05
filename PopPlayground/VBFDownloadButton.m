//
//  VBFDownloadButton.m
//  PopPlayground
//
//  Created by Victor Baro on 03/05/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import "VBFDownloadButton.h"

@interface VBFDownloadButton () <POPAnimationDelegate> {
    CGFloat _progressLength;
    CGFloat _diameter;
}
@property (nonatomic, strong) UIView *mainButton;
@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UIView *progressBar;
@property (nonatomic, strong) UIColor *progressBarColor;
@end

@implementation VBFDownloadButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id) initWithButtonDiameter:(CGFloat)diameter
                       center:(CGPoint)center
                        color:(UIColor *)mainColor
            progressLineColor:(UIColor *)progressColor
                 downloadIcon:(UIImage *)icon
           progressViewLength:(CGFloat)length {
    self = [super init];
    if (self) {
        // Initialization code
        CGPoint origin = CGPointMake(center.x - diameter/2, center.y - diameter/2);
        CGRect frame = CGRectMake(origin.x, origin.y, diameter, diameter);
        self.frame = frame;
        _progressLength = length;
        _diameter = diameter;
        self.progressBarColor = progressColor;
        
        self.mainButton = [[UIView alloc]initWithFrame:CGRectMake(0, 0, diameter, diameter)];
        self.mainButton.layer.cornerRadius = diameter/2;
        self.mainButton.backgroundColor = mainColor;
        
        if (icon) {
            self.icon = icon;
            [self addIconToMainButton:icon];
        }
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTapped:)];
        [self addGestureRecognizer:tap];
        
        [self addSubview:self.mainButton];
        
        
    }
    return self;
}

-(void)addIconToMainButton:(UIImage *)icon{
    UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _diameter, _diameter)];
    iconView.image = icon;
    [iconView sizeToFit];
    iconView.center = CGPointMake(_diameter/2, _diameter/2);
    [self.mainButton addSubview:iconView];
    
}


- (void) viewTapped:(UITapGestureRecognizer *)tapGesture {
    NSLog(@"Tapped");
    self.userInteractionEnabled = NO;
    
    if ([self.mainButton.subviews count]) {
        UIImageView *iconView = self.mainButton.subviews[0];
        [iconView removeFromSuperview];
    }
    CGFloat height = 20;
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
    anim.toValue = [NSValue valueWithCGRect:CGRectMake(self.mainButton.center.x - _progressLength/2,
                                                       self.mainButton.center.y - height/2,
                                                       _progressLength,
                                                       height)];
    anim.springBounciness = 8;
    [anim setValue:@"stretchRound" forKey:@"animName"];
    anim.delegate = self;
    [self.mainButton.layer pop_addAnimation:anim forKey:@"stretchRound"];
    
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
    cornerRad.toValue = @(height/2);
    
    [self.mainButton.layer pop_addAnimation:cornerRad forKey:@"cornerRadius"];
}


- (void)pop_animationDidStop:(POPAnimation *)anim finished:(BOOL)finished {
    
    if (finished) {
        if ([[anim valueForKey:@"animName"] isEqualToString:@"stretchRound"]) {
            [self addProgressBar];
        } else if ([[anim valueForKey:@"animName"] isEqualToString:@"progressBar"]){
            [self flipToGreenTick];
        }else if ([[anim valueForKey:@"animName"] isEqualToString:@"toGreen"]){
            NSLog(@"To green");
            [self addIconToMainButton:[UIImage imageNamed:@"Tick"]];
        }
    }
}

- (void)addProgressBar {
    self.progressBar = [[UIView alloc]initWithFrame:CGRectInset(self.mainButton.frame, 2, 2)];
    self.progressBar.layer.cornerRadius = 8;
    self.progressBar.backgroundColor = self.progressBarColor;
    self.progressBar.alpha = 0.0;
    [self.mainButton addSubview:self.progressBar];
    
    POPBasicAnimation *alpha = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    alpha.duration = 0.2;
    alpha.toValue = @(0.6);
    [self.progressBar pop_addAnimation:alpha forKey:@"alpha"];
    
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerBounds];
    anim.fromValue = [NSValue valueWithCGRect:CGRectMake(self.progressBar.frame.origin.x,
                                                         self.progressBar.frame.origin.y,
                                                         0,
                                                         self.progressBar.frame.size.height)];
    anim.toValue = [NSValue valueWithCGRect:self.progressBar.frame];
    [anim setValue:@"progressBar" forKey:@"animName"];
    anim.delegate = self;
    anim.duration = 3;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.progressBar.layer pop_addAnimation:anim forKey:@"progressBar"];
    
    POPBasicAnimation *trans = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerTranslationX];
    trans.fromValue = @(-self.progressBar.frame.size.width/2);
    trans.toValue = @(0);
    trans.duration = anim.duration;
    trans.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.progressBar.layer pop_addAnimation:trans forKey:@"translation"];
}


-(void) flipToGreenTick {
    [self.progressBar removeFromSuperview];
    
    POPSpringAnimation *roundIt = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
    roundIt.toValue = [NSValue valueWithCGRect:CGRectMake(self.mainButton.center.x - _diameter/2,
                                                          self.mainButton.center.y - _diameter/2,
                                                          _diameter,
                                                          _diameter)];
    [self.mainButton.layer pop_addAnimation:roundIt forKey:@"backToRound"];
    
    
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
    cornerRad.duration = 0.5;
    cornerRad.toValue = @(_diameter/2);
    
    [self.mainButton.layer pop_addAnimation:cornerRad forKey:@"cornerRadius"];
    
    //Half way we turn the layer color to green
    POPBasicAnimation *toGreen = [POPBasicAnimation animationWithPropertyNamed:kPOPViewBackgroundColor];
    toGreen.beginTime = CACurrentMediaTime()+0.45;
    toGreen.duration = 0.3;
    toGreen.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    toGreen.delegate = self;
    [toGreen setValue:@"toGreen" forKey:@"animName"];
    toGreen.toValue = [UIColor flatEmeraldColor];
    [self.mainButton pop_addAnimation:toGreen forKey:@"toGreen"];

}

@end
