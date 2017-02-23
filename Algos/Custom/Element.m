//
//  Element.m
//  Algos
//
//  Created by Manigandan Parthasarathi on 06/07/13.
//  Copyright (c) 2013 Manigandan Parthasarathi. All rights reserved.
//

#import "Element.h"
#import "Utils.h"
#import <QuartzCore/QuartzCore.h>

@implementation Element

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setUp];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setUp];
}

-(void)setUp
{
    self.backgroundColor = [UIColor clearColor];
    //self.layer.cornerRadius = IS_IPAD?7.0f:4.0f;
    
    self.textColor = [UIColor whiteColor];
    self.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:IS_IPAD?35.0f:18.0f];
    self.textAlignment = NSTextAlignmentCenter;
    
    self.shadowColor = [UIColor blackColor];
    self.shadowOffset = CGSizeMake(0, 0);
}

-(void)highlight
{
    //self.backgroundColor = [Utils themeColor];
    self.textColor = [UIColor colorWithRed:44.0f/255.0f green:159.0f/255.0f blue:197.0f/255.0f alpha:1.0f];
    self.shadowOffset = CGSizeMake(-1.0f, -1.0f);
}

-(void)removeHighlight
{
    //self.backgroundColor = [UIColor whiteColor];
    self.textColor = [UIColor whiteColor];
    self.shadowOffset = CGSizeMake(0, 0);
}

@end
