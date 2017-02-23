//
//  Utils.h
//  Algos
//
//  Created by Manigandan Parthasarathi on 12/07/13.
//  Copyright (c) 2013 Manigandan Parthasarathi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+(UIColor*)themeColor;
+(void)setThemeColor:(NSUInteger)color;
+(BOOL)shouldShowLoadingAnimation;
+(void)showLoadingAnimation:(BOOL)bShow;
@end
