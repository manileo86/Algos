//
//  ControlsView.h
//  aires
//
//  Created by Mani on 5/7/13.
//  Copyright (c) 2013 Imaginea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <Social/Social.h>

enum AnimationSpeed
{
    SLOW_SPEED,
    FAST_SPEED
};

enum ElementsSortCase
{
    AVERAGE_CASE,
    BEST_CASE,
    WORST_CASE
};

@protocol ControlsDelegate;

@interface ControlsView : UIView

@property (assign, nonatomic) id<ControlsDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *sortButton;
@property (weak, nonatomic) IBOutlet UIButton *speedButton;
@property (weak, nonatomic) IBOutlet UILabel *speedLabel;
@property (weak, nonatomic) IBOutlet UIButton *caseButton;
@property (weak, nonatomic) IBOutlet UILabel *caseLabel;

-(IBAction)sortOrderSelected:(id)sender;
-(IBAction)speedSelected:(id)sender;
-(IBAction)caseSelected:(id)sender;

-(void)enableControls:(BOOL)enable;

@end

@protocol ControlsDelegate <NSObject>

-(void)infoPressed;
-(void)speedChanged:(CGFloat)speed;
-(void)sortAscending;
-(void)sortDescending;
-(void)caseChanged:(enum ElementsSortCase)elementCase;

@end