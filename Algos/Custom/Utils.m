//
//  Utils.m
//  Algos
//
//  Created by Manigandan Parthasarathi on 12/07/13.
//  Copyright (c) 2013 Manigandan Parthasarathi. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+(UIColor*)themeColor
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSUInteger theme = [defaults integerForKey:THEME_KEY];
    
    if(theme == 0)
    {
        [defaults setInteger:THEME_ORANGE forKey:THEME_KEY];
        [defaults synchronize];
        return ORANGE_COLOR;
    }
    
    UIColor *color = ORANGE_COLOR;
    if(theme == THEME_ORANGE)
    {
        color = ORANGE_COLOR;
    }
    else if(theme == THEME_BLUE)
    {
        color = BLUE_COLOR;
    }
    else if(theme == THEME_RED)
    {
        color = RED_COLOR;
    }
    else if(theme == THEME_GREEN)
    {
        color = GREEN_COLOR;
    }
    
    return color;
}

+(void)setThemeColor:(NSUInteger)color
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:color forKey:THEME_KEY];
    [defaults synchronize];
}

+(BOOL)shouldShowLoadingAnimation
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSUInteger animation = [defaults integerForKey:LOAD_ANIMATION_KEY];
    
    if(animation!=LOAD_ANIMATION_ON && animation!=LOAD_ANIMATION_OFF)
    {
        [Utils showLoadingAnimation:YES];
        return YES;
    }
    else
    {
        return (animation==LOAD_ANIMATION_ON);
    }
}

+(void)showLoadingAnimation:(BOOL)bShow
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(bShow)
        [defaults setInteger:LOAD_ANIMATION_ON forKey:LOAD_ANIMATION_KEY];
    else
        [defaults setInteger:LOAD_ANIMATION_OFF forKey:LOAD_ANIMATION_KEY];
    [defaults synchronize];
}

@end
