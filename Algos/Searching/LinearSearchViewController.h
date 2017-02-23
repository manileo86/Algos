//
//  LinearSearchViewController.h
//  Algos
//
//  Created by Manigandan Parthasarathi on 06/07/13.
//  Copyright (c) 2013 Manigandan Parthasarathi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NumberSelectionView.h"

@interface LinearSearchViewController : UIViewController<NumberSelectionDelegate>

@property(nonatomic, strong) NSMutableArray *numbers;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *comparisonsLabel;
@property (weak, nonatomic) IBOutlet UILabel *comparisonsCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *comparisonTextLabel;
@property (weak, nonatomic) IBOutlet NumberSelectionView *numberSelectionView;
@property (weak, nonatomic) IBOutlet UILabel *searchForLabel;


-(IBAction)backButtonPressed:(id)sender;

@end
