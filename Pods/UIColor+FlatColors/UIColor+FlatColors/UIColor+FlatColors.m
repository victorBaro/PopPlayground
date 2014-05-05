
#import "UIColor+FlatColors.h"

@implementation UIColor (FlatColors)

+ (UIColor *)flatRandomColor {
    NSUInteger random = arc4random() % 20;
    switch (random) {
        case 0:
            return [UIColor flatTurquoiseColor];
            break;
        case 1:
            return [UIColor flatGreenSeaColor];
            break;
        case 2:
            return [UIColor flatEmeraldColor];
            break;
        case 3:
            return [UIColor flatNephritisColor];
            break;
        case 4:
            return [UIColor flatPeterRiverColor];
            break;
        case 5:
            return [UIColor flatBelizeHoleColor];
            break;
        case 6:
            return [UIColor flatAmethystColor];
            break;
        case 7:
            return [UIColor flatWisteriaColor];
            break;
        case 8:
            return [UIColor flatWetAsphaltColor];
            break;
        case 9:
            return [UIColor flatMidnightBlueColor];
            break;
        case 10:
            return [UIColor flatSunFlowerColor];
            break;
        case 11:
            return [UIColor flatOrangeColor];
            break;
        case 12:
            return [UIColor flatCarrotColor];
            break;
        case 13:
            return [UIColor flatPumpkinColor];
            break;
        case 14:
            return [UIColor flatAlizarinColor];
            break;
        case 15:
            return [UIColor flatPomegranateColor];
            break;
        case 16:
            return [UIColor flatCloudsColor];
            break;
        case 17:
            return [UIColor flatSilverColor];
            break;
        case 18:
            return [UIColor flatConcreteColor];
            break;
        case 19:
            return [UIColor flatAsbestosColor];
            break;
            
        default:
            return [UIColor whiteColor];
            break;
    }
}

+ (UIColor *)flatTurquoiseColor {
    return [UIColor colorWithRed:0.10196078431372549 green:0.7372549019607844 blue:0.611764705882353 alpha:1.0];
}

+ (UIColor *)flatGreenSeaColor {
    return [UIColor colorWithRed:0.08627450980392157 green:0.6274509803921569 blue:0.5215686274509804 alpha:1.0];
}

+ (UIColor *)flatEmeraldColor {
    return [UIColor colorWithRed:0.1803921568627451 green:0.8 blue:0.44313725490196076 alpha:1.0];
}

+ (UIColor *)flatNephritisColor {
    return [UIColor colorWithRed:0.15294117647058825 green:0.6823529411764706 blue:0.3764705882352941 alpha:1.0];
}

+ (UIColor *)flatPeterRiverColor {
    return [UIColor colorWithRed:0.20392156862745098 green:0.596078431372549 blue:0.8588235294117647 alpha:1.0];
}

+ (UIColor *)flatBelizeHoleColor {
    return [UIColor colorWithRed:0.1607843137254902 green:0.5019607843137255 blue:0.7254901960784313 alpha:1.0];
}

+ (UIColor *)flatAmethystColor {
    return [UIColor colorWithRed:0.6078431372549019 green:0.34901960784313724 blue:0.7137254901960784 alpha:1.0];
}

+ (UIColor *)flatWisteriaColor {
    return [UIColor colorWithRed:0.5568627450980392 green:0.26666666666666666 blue:0.6784313725490196 alpha:1.0];
}

+ (UIColor *)flatWetAsphaltColor {
    return [UIColor colorWithRed:0.20392156862745098 green:0.28627450980392155 blue:0.3686274509803922 alpha:1.0];
}

+ (UIColor *)flatMidnightBlueColor {
    return [UIColor colorWithRed:0.17254901960784313 green:0.24313725490196078 blue:0.3137254901960784 alpha:1.0];
}

+ (UIColor *)flatSunFlowerColor {
    return [UIColor colorWithRed:0.9450980392156862 green:0.7686274509803922 blue:0.058823529411764705 alpha:1.0];
}

+ (UIColor *)flatOrangeColor {
    return [UIColor colorWithRed:0.9529411764705882 green:0.611764705882353 blue:0.07058823529411765 alpha:1.0];
}

+ (UIColor *)flatCarrotColor {
    return [UIColor colorWithRed:0.9019607843137255 green:0.49411764705882355 blue:0.13333333333333333 alpha:1.0];
}

+ (UIColor *)flatPumpkinColor {
    return [UIColor colorWithRed:0.8274509803921568 green:0.32941176470588235 blue:0 alpha:1.0];
}

+ (UIColor *)flatAlizarinColor {
    return [UIColor colorWithRed:0.9058823529411765 green:0.2980392156862745 blue:0.23529411764705882 alpha:1.0];
}

+ (UIColor *)flatPomegranateColor {
    return [UIColor colorWithRed:0.7529411764705882 green:0.2235294117647059 blue:0.16862745098039217 alpha:1.0];
}

+ (UIColor *)flatCloudsColor {
    return [UIColor colorWithRed:0.9254901960784314 green:0.9411764705882353 blue:0.9450980392156862 alpha:1.0];
}

+ (UIColor *)flatSilverColor {
    return [UIColor colorWithRed:0.7411764705882353 green:0.7647058823529411 blue:0.7803921568627451 alpha:1.0];
}

+ (UIColor *)flatConcreteColor {
    return [UIColor colorWithRed:0.5843137254901961 green:0.6470588235294118 blue:0.6509803921568628 alpha:1.0];
}

+ (UIColor *)flatAsbestosColor {
    return [UIColor colorWithRed:0.4980392156862745 green:0.5490196078431373 blue:0.5529411764705883 alpha:1.0];
}

@end