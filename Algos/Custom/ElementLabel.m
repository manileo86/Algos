//
//  ElementLabel.m
//  Algos
//
//  Created by Manigandan Parthasarathi on 06/07/13.
//  Copyright (c) 2013 Manigandan Parthasarathi. All rights reserved.
//

#import "ElementLabel.h"
#import "Utils.h"
#import <QuartzCore/QuartzCore.h>

@implementation ElementLabel

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
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = IS_IPAD?7.0f:4.0f;
    self.layer.masksToBounds = YES;
    
    self.textColor = [UIColor blackColor];
    self.font = [UIFont boldSystemFontOfSize:IS_IPAD?35.0f:18.0f];
    self.textAlignment = NSTextAlignmentCenter;
    
    self.shadowColor = [UIColor blackColor];
    self.shadowOffset = CGSizeMake(0, 0);
}

-(void)highlight
{
    self.backgroundColor = [Utils themeColor];
    self.textColor = [UIColor whiteColor];
    self.shadowOffset = CGSizeMake(-1.0f, -1.0f);
}

-(void)removeHighlight
{
    self.backgroundColor = [UIColor whiteColor];
    self.textColor = [UIColor blackColor];
    self.shadowOffset = CGSizeMake(0, 0);
}

@end
