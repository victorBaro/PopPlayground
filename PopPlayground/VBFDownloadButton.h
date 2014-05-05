//
//  VBFDownloadButton.h
//  PopPlayground
//
//  Created by Victor Baro on 03/05/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VBFDownloadButton : UIControl
//DESIGNATED INITIALIZER
- (id) initWithButtonDiameter:(CGFloat)diameter
                       center:(CGPoint)center
                        color:(UIColor *)mainColor
            progressLineColor:(UIColor *)progressColor
                 downloadIcon:(UIImage *)icon
           progressViewLength:(CGFloat)length;
@end
