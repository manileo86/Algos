//
//  InfoView.h
//  Algos
//
//  Created by Mani on 8/27/13.
//  Copyright (c) 2013 Manigandan Parthasarathi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoView : UIView

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@end
