//
//  VBFPopUpMenu.h
//  PopPlayground
//
//  Created by Victor Baro on 04/05/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VBFPopUpMenu : UIControl

/*
 Direction: mid direction to where the submenu will point to
 iconArray: images array for the icons -- Works fine for 80x80px icons
 
 */
- (id) initWithFrame:(CGRect)frame
           direction:(CGFloat)directionInRadians
           iconArray:(NSArray *)icons;

@end
