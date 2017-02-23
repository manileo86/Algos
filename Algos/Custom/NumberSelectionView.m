//
//  NumberSelectionView.m
//  Algos
//
//  Created by Manigandan Parthasarathi on 10/07/13.
//  Copyright (c) 2013 Manigandan Parthasarathi. All rights reserved.
//

#import "NumberSelectionView.h"
#import "Utils.h"
#import <QuartzCore/QuartzCore.h>

@interface NumberSelectionView ()
{
    UIView *bgView;
}

@end

@implementation NumberSelectionView

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
    UIColor *color = [Utils themeColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:IS_IPAD?CGRectMake(150, 116, 60, 60):CGRectMake(75, 58, 30, 30)];
    label.tag = 200;
    label.backgroundColor = color;
    label.text = @"?";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:IS_IPAD?35.0f:18.0f];
    label.shadowColor = [UIColor blackColor];
    label.shadowOffset = CGSizeMake(-1.0, -1.0);
    label.layer.cornerRadius = 5.0f;
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    
    bgView = [[UIView alloc] initWithFrame:IS_IPAD?CGRectMake(0, 0, 360, 120):CGRectMake(0, 0, 180, 60)];
    bgView.backgroundColor = color;
    bgView.layer.cornerRadius = 5.0f;
    bgView.hidden = YES;
    bgView.clipsToBounds = YES;
    [self addSubview:bgView];
    
    NSUInteger counter = 1;
    CGFloat side = (IS_IPAD?60.0f:30.0f);
    for(int i=0; i<12; i++)
    {
        if(i!=5 && i!=11)
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((i%6)*side, ((i/6)*side), side, side)];
            label.tag = 100+i;
            label.backgroundColor = [UIColor clearColor];
            label.text = [NSString stringWithFormat:@"%d",counter++];
            label.font = [UIFont boldSystemFontOfSize:IS_IPAD?35.0f:18.0f];
            label.textColor = [UIColor whiteColor];
            label.shadowColor = [UIColor blackColor];
            label.shadowOffset = CGSizeMake(-1.0, -1.0);
            label.textAlignment = NSTextAlignmentCenter;
            [bgView addSubview:label];
        }
        else
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((i%6)*side, ((i/6)*side), side, side)];
            label.tag = 100+i;
            label.backgroundColor = [UIColor lightGrayColor];
            CGFloat low_bound = 11;
            CGFloat high_bound = 99;
            NSUInteger rndValue = (((CGFloat)arc4random()/0x100000000)*(high_bound-low_bound)+low_bound);
            label.text = [NSString stringWithFormat:@"%d",rndValue];
            label.font = [UIFont boldSystemFontOfSize:IS_IPAD?35.0f:20.0f];
            label.textColor = [UIColor whiteColor];
            label.shadowColor = [UIColor blackColor];
            label.shadowOffset = CGSizeMake(-1.0, -1.0);
            label.textAlignment = NSTextAlignmentCenter;
            [bgView addSubview:label];
        }
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    UILabel *mLabel = (UILabel*)[self viewWithTag:200];
    
    if(CGRectContainsPoint(mLabel.frame, touchPoint))
    {
        bgView.hidden = NO;
        mLabel.text = @"?";
        if(_delegate && [_delegate respondsToSelector:@selector(numberViewTouched)])
        {
            [_delegate numberViewTouched];
        }
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    for(int i=0; i<12; i++)
    {
        UILabel *label = (UILabel*)[self viewWithTag:100+i];
        if(CGRectContainsPoint(label.frame, touchPoint))
        {
            label.backgroundColor = [UIColor whiteColor];
            label.textColor = [UIColor blackColor];
            label.shadowOffset = CGSizeMake(0,0);
        }
        else
        {
            label.backgroundColor = (i==5 || i==11)?[UIColor lightGrayColor]:[UIColor clearColor];
            label.textColor = [UIColor whiteColor];
            label.shadowOffset = CGSizeMake(-1.0, -1.0);
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    for(int i=0; i<12; i++)
    {
        UILabel *label = (UILabel*)[self viewWithTag:100+i];
        label.backgroundColor = (i==5 || i==11)?[UIColor lightGrayColor]:[UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.shadowOffset = CGSizeMake(-1.0, -1.0);
        if(CGRectContainsPoint(label.frame, touchPoint) && !bgView.hidden)
        {
            if(_delegate && [_delegate respondsToSelector:@selector(numberSelected:)])
            {
                [_delegate numberSelected:[label.text intValue]];
            }
            
            UILabel *mLabel = (UILabel*)[self viewWithTag:200];
            mLabel.text = label.text;
        }
    }
    
    bgView.hidden = YES;
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    bgView.hidden = YES;
}

@end
