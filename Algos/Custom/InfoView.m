//
//  InfoView.m
//  Algos
//
//  Created by Mani on 8/27/13.
//  Copyright (c) 2013 Manigandan Parthasarathi. All rights reserved.
//

#import "InfoView.h"
#import <QuartzCore/QuartzCore.h>

@interface  InfoView()
{
    BOOL bDismiss;
}
@end

@implementation InfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initControls];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self initControls];
}

-(void)initControls
{
    _contentView.layer.cornerRadius = 20.0f;
}

- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    if(!CGRectContainsPoint(_contentView.frame, touchPoint))
    {
        bDismiss = YES;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    bDismiss = NO;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(bDismiss)
    {
        UITouch *touch = [touches anyObject];
        CGPoint touchPoint = [touch locationInView:self];
        
        if(!CGRectContainsPoint(_contentView.frame, touchPoint))
        {
            [UIView animateWithDuration:0.25
                             animations:^{
                                 self.alpha = 0;
                             }
                             completion:^(BOOL finished){
                                 [self removeFromSuperview];
                             }];
        }
    }
}

@end
