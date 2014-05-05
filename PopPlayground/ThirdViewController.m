//
//  ThirdViewController.m
//  PopPlayground
//
//  Created by Victor Baro on 03/05/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import "ThirdViewController.h"
#import "VBFDownloadButton.h"
#import "VBFPopUpMenu.h"

@interface ThirdViewController ()
@property (nonatomic, strong) NSMutableArray *subviews;
@end

@implementation ThirdViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self add2Divisions];
    [self addControls];

}

- (void) add2Divisions {
    for (int i=0; i < 2; i++) {
        CGSize subviewSize = CGSizeMake(CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(self.view.frame));
        UIView *subScreen = [[UIView alloc]initWithFrame:CGRectMake(i*subviewSize.width,
                                                                    0,
                                                                    subviewSize.width,
                                                                    subviewSize.height)];
        subScreen.backgroundColor = [UIColor flatMidnightBlueColor];
        subScreen.layer.borderColor = [UIColor flatWetAsphaltColor].CGColor;
        subScreen.layer.borderWidth = 1.0;
        [self.view addSubview:subScreen];
        if (!self.subviews) {
            self.subviews = [[NSMutableArray alloc]initWithObjects:subScreen, nil];
        } else {
            [self.subviews addObject:subScreen];
        }
    }
}

- (void) addControls {
    //Download control
    UIView *firstView = self.subviews[0];
    


    VBFDownloadButton *downloadButton = [[VBFDownloadButton alloc]initWithButtonDiameter:60
                                                                                      center:firstView.center
                                                                                       color:[UIColor flatSunFlowerColor]
                                                                           progressLineColor:[UIColor flatCloudsColor]
                                                                            downloadIcon:[UIImage imageNamed:@"downloadCloud"]
                                                                          progressViewLength:200];
    [self.view addSubview:downloadButton];
    
    UIView *secondView = self.subviews[1];
    NSArray *icons = @[[UIImage imageNamed:@"twitterIcon"],[UIImage imageNamed:@"facebookIcon"],[UIImage imageNamed:@"dribbbleIcon"],[UIImage imageNamed:@"downloadIcon"]];
    
    VBFPopUpMenu *popUp = [[VBFPopUpMenu alloc]initWithFrame:secondView.frame
                                                   direction:M_PI
                                                   iconArray:icons];
    [self.view addSubview:popUp];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
}

@end
