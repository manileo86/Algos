//
//  ControlsView.m
//  aires
//
//  Created by Mani on 5/7/13.
//  Copyright (c) 2013 Imaginea. All rights reserved.
//

#import "ControlsView.h"
#import "Utils.h"
#include <netinet/in.h>
#import <SystemConfiguration/SCNetworkReachability.h>
#import <QuartzCore/QuartzCore.h>

@interface ControlsView ()
{
    enum AnimationSpeed animationSpeed;
    enum ElementsSortCase sortCase;
}

@end

@implementation ControlsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
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
    animationSpeed = FAST_SPEED;
    sortCase = AVERAGE_CASE;
}

-(void)enableControls:(BOOL)enable
{
    _sortButton.userInteractionEnabled = enable;
    _caseButton.userInteractionEnabled = enable;
}

-(IBAction)infoPressed:(id)sender
{
    if(_delegate &&[_delegate respondsToSelector:@selector(infoPressed)])
    {
        [_delegate infoPressed];
    }
}

-(IBAction)sortOrderSelected:(id)sender
{
    [self enableControls:NO];    
    if(_delegate &&[_delegate respondsToSelector:@selector(sortAscending)])
    {
        [_delegate sortAscending];
    }
}

-(IBAction)speedSelected:(id)sender
{
    if(animationSpeed == SLOW_SPEED)
    {
        animationSpeed = FAST_SPEED;
        [_speedButton setImage:[UIImage imageNamed:@"ico_speed_up_nor.png"] forState:UIControlStateNormal];
        [_speedButton setImage:[UIImage imageNamed:@"ico_speed_up_pressed.png"] forState:UIControlStateHighlighted];
        [_speedLabel setText:@"Fast"];
    }
    else if(animationSpeed == FAST_SPEED)
    {
        animationSpeed = SLOW_SPEED;
        [_speedButton setImage:[UIImage imageNamed:@"ico_speed_down_nor.png"] forState:UIControlStateNormal];
        [_speedButton setImage:[UIImage imageNamed:@"ico_speed_down_pressed.png"] forState:UIControlStateHighlighted];
        [_speedLabel setText:@"Slow"];
    }
    
    if(_delegate &&[_delegate respondsToSelector:@selector(speedChanged:)])
    {
        [_delegate speedChanged:animationSpeed==SLOW_SPEED?0.5f:0.2f];
    }
}

-(IBAction)caseSelected:(id)sender
{
    if(sortCase == BEST_CASE)
    {
        sortCase = AVERAGE_CASE;
        [_caseButton setImage:[UIImage imageNamed:@"ico_avg_nor.png"] forState:UIControlStateNormal];
        [_caseButton setImage:[UIImage imageNamed:@"ico_avg_pressed.png"] forState:UIControlStateHighlighted];
        [_caseLabel setText:@"Average"];
    }
    else if(sortCase == AVERAGE_CASE)
    {
        sortCase = WORST_CASE;
        [_caseButton setImage:[UIImage imageNamed:@"ico_worst_nor.png"] forState:UIControlStateNormal];
        [_caseButton setImage:[UIImage imageNamed:@"ico_worst_pressed.png"] forState:UIControlStateHighlighted];
        [_caseLabel setText:@"Worst"];
    }
    else if(sortCase == WORST_CASE)
    {
        sortCase = BEST_CASE;
        [_caseButton setImage:[UIImage imageNamed:@"ico_best_nor.png"] forState:UIControlStateNormal];
        [_caseButton setImage:[UIImage imageNamed:@"ico_best_pressed.png"] forState:UIControlStateHighlighted];
        [_caseLabel setText:@"Best"];
    }

    if(_delegate &&[_delegate respondsToSelector:@selector(speedChanged:)])
    {
        [_delegate caseChanged:(sortCase == AVERAGE_CASE)?AVERAGE_CASE:(sortCase == BEST_CASE)?BEST_CASE:WORST_CASE];
    }
}

@end
