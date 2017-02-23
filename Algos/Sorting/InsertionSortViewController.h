//
//  InsertionSortViewController.h
//  Algos
//
//  Created by Manigandan Parthasarathi on 06/07/13.
//  Copyright (c) 2013 Manigandan Parthasarathi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InsertionSortViewController : UIViewController

@property(nonatomic, strong) NSMutableArray *numbers;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *sortLeftButton;
@property (weak, nonatomic) IBOutlet UIButton *sortRightButton;
@property (weak, nonatomic) IBOutlet UILabel *comparisonsLabel;
@property (weak, nonatomic) IBOutlet UILabel *comparisonsCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *speedButton;
@property (weak, nonatomic) IBOutlet UIButton *dataSetButton;

-(IBAction)backButtonPressed:(id)sender;
-(IBAction)dataSetPressed:(id)sender;
-(IBAction)sortLeft:(id)sender;
-(IBAction)sortRight:(id)sender;
-(IBAction)speedButtonPressed:(id)sender;

@end
