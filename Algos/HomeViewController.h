//
//  HomeViewController.h
//  Algos
//
//  Created by Manigandan Parthasarathi on 06/07/13.
//  Copyright (c) 2013 Manigandan Parthasarathi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsView.h"
#import <MessageUI/MessageUI.h>
#import <Social/Social.h>

@interface HomeViewController : UIViewController<SettingsDelegate, MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titlePart1;
@property (weak, nonatomic) IBOutlet UILabel *titlePart2;
@property (weak, nonatomic) IBOutlet UILabel *titlePart3;
@property (weak, nonatomic) IBOutlet UILabel *titlePart4;
@property (weak, nonatomic) IBOutlet UILabel *titlePart5;
@property (weak, nonatomic) IBOutlet UILabel *randomLabel1;
@property (weak, nonatomic) IBOutlet UILabel *randomLabel2;
@property (weak, nonatomic) IBOutlet UILabel *randomLabel3;
@property (weak, nonatomic) IBOutlet UILabel *randomLabel4;
@property (weak, nonatomic) IBOutlet UILabel *randomLabel5;

@property (weak, nonatomic) IBOutlet UILabel *searchingLabel;
@property (weak, nonatomic) IBOutlet UIButton *linearSearchButton;
@property (weak, nonatomic) IBOutlet UIButton *binarySearchButton;

@property (weak, nonatomic) IBOutlet UILabel *sortingLabel;
@property (weak, nonatomic) IBOutlet UIButton *insertionSortButton;
@property (weak, nonatomic) IBOutlet UIButton *bubbleSortButton;
@property (weak, nonatomic) IBOutlet UIButton *selectionSortButton;
@property (weak, nonatomic) IBOutlet UIButton *mergeSortButton;

@property (weak, nonatomic) IBOutlet UIView *vericalLine1;
@property (weak, nonatomic) IBOutlet UIView *vericalLine2;
@property (weak, nonatomic) IBOutlet UIView *horizontalLine1;
@property (weak, nonatomic) IBOutlet UIView *horizontalLine2;
@property (weak, nonatomic) IBOutlet UIView *horizontalLine3;
@property (weak, nonatomic) IBOutlet UIView *horizontalLine4;
@property (weak, nonatomic) IBOutlet UIView *horizontalLine5;
@property (weak, nonatomic) IBOutlet UIView *horizontalLine6;

@property (weak, nonatomic) IBOutlet UIButton *orangeButton;
@property (weak, nonatomic) IBOutlet UIButton *blueButton;
@property (weak, nonatomic) IBOutlet UIButton *redButton;
@property (weak, nonatomic) IBOutlet UIButton *greenButton;

@property (weak, nonatomic) IBOutlet UIButton *settingsButton;

@property (weak, nonatomic) IBOutlet UIView *controlsView;

-(IBAction)settingsButtonPressed:(id)sender;
-(IBAction)linearSearchButtonPressed:(id)sender;
-(IBAction)binarySearchButtonPressed:(id)sender;
-(IBAction)insertionSortButtonPressed:(id)sender;
-(IBAction)bubbleSortButtonPressed:(id)sender;
-(IBAction)selectionSortButtonPressed:(id)sender;
-(IBAction)mergeSortButtonPressed:(id)sender;
-(IBAction)orangeButtonPressed:(id)sender;
-(IBAction)blueButtonPressed:(id)sender;
-(IBAction)redButtonPressed:(id)sender;
-(IBAction)greenButtonPressed:(id)sender;

@end
