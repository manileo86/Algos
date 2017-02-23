//
//  SettingsView.h
//  aires
//
//  Created by Mani on 5/7/13.
//  Copyright (c) 2013 Imaginea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <Social/Social.h>

@protocol SettingsDelegate;

@interface SettingsView : UIView

@property (assign, nonatomic) id<SettingsDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *loadingAnimationOn;
@property (weak, nonatomic) IBOutlet UIButton *loadingAnimationOff;

@property (weak, nonatomic) IBOutlet UIButton *redButton;
@property (weak, nonatomic) IBOutlet UIButton *greenButton;
@property (weak, nonatomic) IBOutlet UIButton *orangeButton;
@property (weak, nonatomic) IBOutlet UIButton *blueButton;

@property (weak, nonatomic) IBOutlet UIButton *emailButton;
@property (weak, nonatomic) IBOutlet UIButton *rateButton;
@property (weak, nonatomic) IBOutlet UIButton *tweetButton;

@property (weak, nonatomic) IBOutlet UILabel *spreadUsLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

-(IBAction)animationOnPressed:(id)sender;
-(IBAction)animationOffPressed:(id)sender;
    
-(IBAction)orangeButtonPressed:(id)sender;
-(IBAction)blueButtonPressed:(id)sender;
-(IBAction)redButtonPressed:(id)sender;
-(IBAction)greenButtonPressed:(id)sender;

-(IBAction)emailPressed:(id)sender;
-(IBAction)ratePressed:(id)sender;
-(IBAction)tweetPressed:(id)sender;

@end

@protocol SettingsDelegate <NSObject>

-(void)themeChanged;
-(void)sendEmail;
-(void)tweet;

@end