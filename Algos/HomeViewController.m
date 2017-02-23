//
//  HomeViewController.m
//  Algos
//
//  Created by Manigandan Parthasarathi on 06/07/13.
//  Copyright (c) 2013 Manigandan Parthasarathi. All rights reserved.
//


#import "HomeViewController.h"
#import "LinearSearchViewController.h"
#import "BinarySearchViewController.h"
#import "InsertionSortViewController.h"
#import "BubbleSortViewController.h"
#import "MergeSortViewController.h"
#import "SelectionSortViewController.h"
#import "Utils.h"
#import <QuartzCore/QuartzCore.h>

@interface HomeViewController ()
{
    NSTimer *animationTimer;
    NSTimer *themeOptionsHider;
    UITapGestureRecognizer *dismissSettingsTap;
    BOOL bShowingSettings;
}
@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self updateTheme];
    
	// Do any additional setup after loading the view, typically from a nib.
    [self showControls:NO];
    bShowingSettings = NO;
    
    _linearSearchButton.layer.cornerRadius = 5.0f;
    _linearSearchButton.layer.masksToBounds = YES;
    _binarySearchButton.layer.cornerRadius = 5.0f;
    _binarySearchButton.layer.masksToBounds = YES;
    _insertionSortButton.layer.cornerRadius = 5.0f;
    _insertionSortButton.layer.masksToBounds = YES;
    _bubbleSortButton.layer.cornerRadius = 5.0f;
    _bubbleSortButton.layer.masksToBounds = YES;
    _selectionSortButton.layer.cornerRadius = 5.0f;
    _selectionSortButton.layer.masksToBounds = YES;
    _mergeSortButton.layer.cornerRadius = 5.0f;
    _mergeSortButton.layer.masksToBounds = YES;
    _orangeButton.layer.cornerRadius = 5.0f;
    _blueButton.layer.cornerRadius = 5.0f;
    _redButton.layer.cornerRadius = 5.0f;
    _greenButton.layer.cornerRadius = 5.0f;
    
    _orangeButton.backgroundColor = ORANGE_COLOR;
    _blueButton.backgroundColor = BLUE_COLOR;
    _redButton.backgroundColor = RED_COLOR;
    _greenButton.backgroundColor = GREEN_COLOR;
    
    [_titlePart1 setFont:[UIFont fontWithName:@"threed" size:IS_IPAD?80:40]];
    [_titlePart2 setFont:[UIFont fontWithName:@"threed" size:IS_IPAD?80:40]];
    [_titlePart3 setFont:[UIFont fontWithName:@"threed" size:IS_IPAD?80:40]];
    [_titlePart4 setFont:[UIFont fontWithName:@"threed" size:IS_IPAD?80:40]];
    [_titlePart5 setFont:[UIFont fontWithName:@"threed" size:IS_IPAD?80:40]];
    
    [_randomLabel1 setFont:[UIFont fontWithName:@"threed" size:IS_IPAD?150:80]];
    [_randomLabel2 setFont:[UIFont fontWithName:@"threed" size:IS_IPAD?150:80]];
    [_randomLabel3 setFont:[UIFont fontWithName:@"threed" size:IS_IPAD?150:80]];
    [_randomLabel4 setFont:[UIFont fontWithName:@"threed" size:IS_IPAD?150:80]];
    [_randomLabel5 setFont:[UIFont fontWithName:@"threed" size:IS_IPAD?150:80]];
    
    UIImage *bgimage = [UIImage imageNamed:@"btn_highlighted.png"];
    bgimage = [bgimage stretchableImageWithLeftCapWidth:bgimage.size.width/2 topCapHeight:bgimage.size.height/2];
    [_linearSearchButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_linearSearchButton setBackgroundImage:bgimage forState:UIControlStateHighlighted];
    [_linearSearchButton setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_binarySearchButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_binarySearchButton setBackgroundImage:bgimage forState:UIControlStateHighlighted];
    [_binarySearchButton setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_insertionSortButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_insertionSortButton setBackgroundImage:bgimage forState:UIControlStateHighlighted];
    [_insertionSortButton setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_bubbleSortButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_bubbleSortButton setBackgroundImage:bgimage forState:UIControlStateHighlighted];
    [_bubbleSortButton setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_mergeSortButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_mergeSortButton setBackgroundImage:bgimage forState:UIControlStateHighlighted];
    [_mergeSortButton setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_selectionSortButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_selectionSortButton setBackgroundImage:bgimage forState:UIControlStateHighlighted];
    [_selectionSortButton setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed)];
    [self.view addGestureRecognizer:longPress];
    
    if([Utils shouldShowLoadingAnimation])
    {
        [self performSelector:@selector(titleAnimation) withObject:nil afterDelay:1.5];
    }
    else
    {
        [self showDashboard];
    }
}

-(void)updateTheme
{
    UIColor *color = [Utils themeColor];
    
    [_titlePart1 setTextColor:color];
    [_titlePart2 setTextColor:color];
    [_titlePart3 setTextColor:color];
    [_titlePart4 setTextColor:color];
    [_titlePart5 setTextColor:color];
    
    _linearSearchButton.backgroundColor = color;
    _binarySearchButton.backgroundColor = color;
    _insertionSortButton.backgroundColor = color;
    _bubbleSortButton.backgroundColor = color;
    _selectionSortButton.backgroundColor = color;
    _mergeSortButton.backgroundColor = color;
}

-(void)titleAnimation
{
    [UIView animateWithDuration:0.5
                     animations:^{
                         _titlePart1.frame = CGRectOffset(_titlePart1.frame, 0, IS_IPAD?-100:-50);
                     }
                     completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:0.75
                                          animations:^{
                                              _titlePart1.frame = CGRectOffset(_titlePart1.frame, IS_IPAD?680:347, 0);
                                              _titlePart2.frame = CGRectOffset(_titlePart2.frame, IS_IPAD?-80:-40, 0);
                                              _titlePart3.frame = CGRectOffset(_titlePart3.frame, IS_IPAD?-80:-40, 0);
                                              _titlePart4.frame = CGRectOffset(_titlePart4.frame, IS_IPAD?-80:-40, 0);
                                              _titlePart5.frame = CGRectOffset(_titlePart5.frame, IS_IPAD?-80:-40, 0);
                                          }
                                          completion:^(BOOL finished) {
                                              
                                              [UIView animateWithDuration:0.5
                                                               animations:^{
                                                                   _titlePart1.frame = CGRectOffset(_titlePart1.frame, 0, IS_IPAD?100:50);
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   
                                                                   [UIView animateWithDuration:0.5
                                                                                    animations:^{
                                                                                        _titlePart4.frame = CGRectOffset(_titlePart4.frame, 0, IS_IPAD?-100:-50);
                                                                                    }
                                                                                    completion:^(BOOL finished) {
                                                                                        
                                                                                        [UIView animateWithDuration:0.75
                                                                                                         animations:^{
                                                                                                             _titlePart3.frame = CGRectOffset(_titlePart3.frame, IS_IPAD?95:49, 0);
                                                                                                             _titlePart4.frame = CGRectOffset(_titlePart4.frame, IS_IPAD?-95:-50, 0);
                                                                                                         }
                                                                                                         completion:^(BOOL finished) {
                                                                                                             
                                                                                                             [UIView animateWithDuration:0.5
                                                                                                                              animations:^{
                                                                                                                                  _titlePart4.frame = CGRectOffset(_titlePart4.frame, 0, IS_IPAD?100:50);
                                                                                                                              }
                                                                                                                              completion:^(BOOL finished) {
                                                                                                                                  [self performSelector:@selector(showDashboard) withObject:nil afterDelay:1.0];
                                                                                                                                  
                                                                                                                              }];
                                                                                                             
                                                                                                         }];
                                                                                        
                                                                                        
                                                                                    }];
                                                                   
                                                                   
                                                                   
                                                               }];
                                              
                                          }];
                         
                         
                     }];
}

-(void)showDashboard
{
    [UIView animateWithDuration:[Utils shouldShowLoadingAnimation]?0.3:0
                     animations:^{
                         _titlePart1.alpha = 0;
                         _titlePart2.alpha = 0;
                         _titlePart3.alpha = 0;
                         _titlePart4.alpha = 0;
                         _titlePart5.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:0.25
                                          animations:^{
                                              [self showControls:YES];
                                          }];
                     }];
}

-(void)showControls:(BOOL)bShow
{
    CGFloat fullAlpha = bShow?1.0f:0;
    CGFloat partialAlpha = bShow?0.35f:0;
    _settingsButton.alpha = fullAlpha;
    _searchingLabel.alpha = fullAlpha;
    _sortingLabel.alpha = fullAlpha;
    _linearSearchButton.alpha = fullAlpha;
    _binarySearchButton.alpha = fullAlpha;
    _insertionSortButton.alpha = fullAlpha;
    _bubbleSortButton.alpha = fullAlpha;
    _selectionSortButton.alpha = fullAlpha;
    _mergeSortButton.alpha = fullAlpha;
    _vericalLine1.alpha = partialAlpha;
    _vericalLine2.alpha = partialAlpha;
    _horizontalLine1.alpha = partialAlpha;
    _horizontalLine2.alpha = partialAlpha;
    _horizontalLine3.alpha = partialAlpha;
    _horizontalLine4.alpha = partialAlpha;
    _horizontalLine5.alpha = partialAlpha;
    _horizontalLine6.alpha = partialAlpha;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    animationTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(showRandomLetter) userInfo:nil repeats:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [animationTimer invalidate];
    animationTimer = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

-(void)showRandomLetter
{
    NSString *randNum = [NSString stringWithFormat:@"%d", arc4random()%10];
    _randomLabel1.text = randNum;
    int width = self.view.bounds.size.width;
    int height = self.view.bounds.size.height;
    CGRect frame = _randomLabel1.frame;
    frame.origin = CGPointMake(arc4random()%width, arc4random()%height);
    _randomLabel1.frame = frame;
    
    randNum = [NSString stringWithFormat:@"%d", arc4random()%10];
    _randomLabel2.text = randNum;
    frame = _randomLabel2.frame;
    frame.origin = CGPointMake(arc4random()%width, arc4random()%height);
    _randomLabel2.frame = frame;
    
    randNum = [NSString stringWithFormat:@"%d", arc4random()%10];
    _randomLabel3.text = randNum;
    frame = _randomLabel3.frame;
    frame.origin = CGPointMake(arc4random()%width, arc4random()%height);
    _randomLabel3.frame = frame;
    
    randNum = [NSString stringWithFormat:@"%d", arc4random()%10];
    _randomLabel4.text = randNum;
    frame = _randomLabel4.frame;
    frame.origin = CGPointMake(arc4random()%width, arc4random()%height);
    _randomLabel4.frame = frame;
    
    randNum = [NSString stringWithFormat:@"%d", arc4random()%10];
    _randomLabel5.text = randNum;
    frame = _randomLabel5.frame;
    frame.origin = CGPointMake(arc4random()%width, arc4random()%height);
    _randomLabel5.frame = frame;
    
    [UIView animateWithDuration:0.4
                     animations:^{
                         _randomLabel1.alpha = 0.15f;
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.4
                                               delay:0.25
                                             options:UIViewAnimationOptionAllowAnimatedContent
                                          animations:^{
                                              _randomLabel1.alpha = 0;
                                          }
                                          completion:^(BOOL finished) {
                                          }];
                     }];
    
    [UIView animateWithDuration:0.25
                     animations:^{
                         _randomLabel2.alpha = 0.15f;
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.25
                                               delay:0.35
                                             options:UIViewAnimationOptionAllowAnimatedContent
                                          animations:^{
                                              _randomLabel2.alpha = 0;
                                          }
                                          completion:^(BOOL finished) {
                                          }];
                     }];
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         _randomLabel3.alpha = 0.15f;
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.3
                                               delay:0.45
                                             options:UIViewAnimationOptionAllowAnimatedContent
                                          animations:^{
                                              _randomLabel3.alpha = 0;
                                          }
                                          completion:^(BOOL finished) {
                                          }];
                     }];
    
    [UIView animateWithDuration:0.25
                     animations:^{
                         _randomLabel4.alpha = 0.15f;
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.25
                                               delay:0.5
                                             options:UIViewAnimationOptionAllowAnimatedContent
                                          animations:^{
                                              _randomLabel4.alpha = 0;
                                          }
                                          completion:^(BOOL finished) {
                                          }];
                     }];
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         _randomLabel5.alpha = 0.15f;
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.35
                                               delay:0.2
                                             options:UIViewAnimationOptionAllowAnimatedContent
                                          animations:^{
                                              _randomLabel5.alpha = 0;
                                          }
                                          completion:^(BOOL finished) {
                                          }];
                     }];
}

-(IBAction)settingsButtonPressed:(id)sender
{
    if(bShowingSettings)
    {
        [self dismissSettings];
    }
    else
    {
        [self showSettings];
    }
}

-(void)showSettings
{
    UIView *fadeView = [[UIView alloc] initWithFrame:self.view.bounds];
    fadeView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.6];
    fadeView.tag = 400;
    fadeView.alpha = 0;
    [self.view addSubview:fadeView];
    
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:IS_IPAD?@"SettingsView_iPad":@"SettingsView_iPhone" owner:self options:nil];
    SettingsView *settingsView = (SettingsView*)[topLevelObjects objectAtIndex:0];
    settingsView.center = self.view.center;
    settingsView.transform = CGAffineTransformMakeScale(0, 0);
    settingsView.tag = 500;
    settingsView.delegate = self;
    settingsView.userInteractionEnabled = YES;
    [self.view addSubview:settingsView];
    [UIView animateWithDuration:0.3f
                     animations:^{
                         fadeView.alpha = 1.0f;
                         _settingsButton.alpha = 0;
                         _controlsView.transform = CGAffineTransformMakeScale(0, 0);
                     }];
    
    [UIView animateWithDuration:0.3f
                          delay:0.1f
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         settingsView.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.15f
                                          animations:^{
                                              settingsView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                                          }];
                     }];
    
    if(!dismissSettingsTap)
        dismissSettingsTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissSettings)];
    [fadeView addGestureRecognizer:dismissSettingsTap];
    
    bShowingSettings = YES;
}

-(void)dismissSettings
{
    UIView *fadeView = [self.view viewWithTag:400];
    UIView *settingsView = [self.view viewWithTag:500];
    
    [UIView animateWithDuration:0.3f
                     animations:^{
                         settingsView.transform = CGAffineTransformMakeScale(0, 0);
                         fadeView.alpha = 0;
                         _settingsButton.alpha = 1.0f;
                     }
                     completion:^(BOOL finished) {
                         [fadeView removeFromSuperview];
                         [settingsView removeFromSuperview];
                     }];
    
    [UIView animateWithDuration:0.3f
                          delay:0.1f
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         _controlsView.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.15f
                                          animations:^{
                                              _controlsView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                                          }];
                     }];
    
    [fadeView removeGestureRecognizer:dismissSettingsTap];
    dismissSettingsTap = nil;
    
    bShowingSettings = NO;
}

-(IBAction)linearSearchButtonPressed:(id)sender
{
    [self hideThemeOptions];
    
    NSString *nibName = IS_IPAD?@"LinearSearchViewController_iPad":@"LinearSearchViewController_iPhone";
    
    LinearSearchViewController *sortVC = [[LinearSearchViewController alloc] initWithNibName:nibName bundle:nil];
    [self.navigationController pushViewController:sortVC animated:YES];
}

-(IBAction)binarySearchButtonPressed:(id)sender
{
    [self hideThemeOptions];
    
    NSString *nibName = IS_IPAD?@"BinarySearchViewController_iPad":@"BinarySearchViewController_iPhone";
    
    BinarySearchViewController *sortVC = [[BinarySearchViewController alloc] initWithNibName:nibName bundle:nil];
    [self.navigationController pushViewController:sortVC animated:YES];
}

-(IBAction)insertionSortButtonPressed:(id)sender
{
    [self hideThemeOptions];
    
    NSString *nibName = IS_IPAD?@"InsertionSortViewController_iPad": @"InsertionSortViewController_iPhone";
    
    InsertionSortViewController *sortVC = [[InsertionSortViewController alloc] initWithNibName:nibName bundle:nil];
    [self.navigationController pushViewController:sortVC animated:YES];
}

-(IBAction)bubbleSortButtonPressed:(id)sender
{
    [self hideThemeOptions];
    
    NSString *nibName = IS_IPAD?@"BubbleSortViewController_iPad": @"BubbleSortViewController_iPhone";
    
    BubbleSortViewController *sortVC = [[BubbleSortViewController alloc] initWithNibName:nibName bundle:nil];
    [self.navigationController pushViewController:sortVC animated:YES];
}

-(IBAction)selectionSortButtonPressed:(id)sender
{
    [self hideThemeOptions];
    
    NSString *nibName = IS_IPAD?@"SelectionSortViewController_iPad": @"SelectionSortViewController_iPhone";
    
    SelectionSortViewController *sortVC = [[SelectionSortViewController alloc] initWithNibName:nibName bundle:nil];
    [self.navigationController pushViewController:sortVC animated:YES];
}

-(IBAction)mergeSortButtonPressed:(id)sender
{
    [self hideThemeOptions];
    
    NSString *nibName = IS_IPAD?@"MergeSortViewController_iPad": @"MergeSortViewController_iPhone";
    
    MergeSortViewController *sortVC = [[MergeSortViewController alloc] initWithNibName:nibName bundle:nil];
    [self.navigationController pushViewController:sortVC animated:YES];
}

-(IBAction)orangeButtonPressed:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults integerForKey:THEME_KEY] == THEME_ORANGE)
    {
        [self hideThemeOptions];
        return;
    }
    
    [UIView animateWithDuration:0.25
                     animations:^{
                         [self showControls:NO];
                     }
                     completion:^(BOOL finished) {
                         [Utils setThemeColor:THEME_GREEN];
                         [self updateTheme];
                         [self hideThemeOptions];
                         [UIView animateWithDuration:0.25
                                               delay:0.2
                                             options:UIViewAnimationOptionAllowAnimatedContent
                                          animations:^{
                                              [self showControls:YES];
                                          }
                                          completion:^(BOOL finished) {
                                              
                                          }];
                     }];
}

-(IBAction)blueButtonPressed:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults integerForKey:THEME_KEY] == THEME_BLUE)
    {
        [self hideThemeOptions];
        return;
    }
    
    [UIView animateWithDuration:0.25
                     animations:^{
                         [self showControls:NO];
                     }
                     completion:^(BOOL finished) {
                         [Utils setThemeColor:THEME_BLUE];
                         [self updateTheme];
                         [self hideThemeOptions];
                         [UIView animateWithDuration:0.25
                                               delay:0.2
                                             options:UIViewAnimationOptionAllowAnimatedContent
                                          animations:^{
                                              [self showControls:YES];
                                          }
                                          completion:^(BOOL finished) {
                                              
                                          }];
                     }];
}

-(IBAction)redButtonPressed:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults integerForKey:THEME_KEY] == THEME_RED)
    {
        [self hideThemeOptions];
        return;
    }
    
    [UIView animateWithDuration:0.25
                     animations:^{
                         [self showControls:NO];
                     }
                     completion:^(BOOL finished) {
                         [Utils setThemeColor:THEME_RED];
                         [self updateTheme];
                         [self hideThemeOptions];
                         [UIView animateWithDuration:0.25
                                               delay:0.2
                                             options:UIViewAnimationOptionAllowAnimatedContent
                                          animations:^{
                                              [self showControls:YES];
                                          }
                                          completion:^(BOOL finished) {
                                              
                                          }];
                     }];
}

-(IBAction)greenButtonPressed:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults integerForKey:THEME_KEY] == THEME_GREEN)
    {
        [self hideThemeOptions];
        return;
    }
    
    [UIView animateWithDuration:0.25
                     animations:^{
                         [self showControls:NO];
                     }
                     completion:^(BOOL finished) {
                         [Utils setThemeColor:THEME_GREEN];
                         [self updateTheme];
                         [self hideThemeOptions];
                         [UIView animateWithDuration:0.25
                                               delay:0.2
                                             options:UIViewAnimationOptionAllowAnimatedContent
                                          animations:^{
                                              [self showControls:YES];
                                          }
                                          completion:^(BOOL finished) {
                                              
                                          }];
                     }];
}

-(void)addPulseAnimationTo:(UIButton*)button
{
    CABasicAnimation *pulseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulseAnimation.duration = 0.25f;
    pulseAnimation.toValue = [NSNumber numberWithFloat:1.1];
    pulseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulseAnimation.autoreverses = YES;
    pulseAnimation.repeatCount = FLT_MAX;
    
    [button.layer addAnimation:pulseAnimation forKey:@"pulseAnimation"];
}

-(void)removePulseAnimationsFrom:(UIButton*)button
{
    [button.layer removeAnimationForKey:@"pulseAnimation"];
}

-(void)longPressed
{
    if(bShowingSettings)
        return;
    
    if(themeOptionsHider)
    {
        [themeOptionsHider invalidate];
        themeOptionsHider = nil;
    }
    
    _orangeButton.hidden = NO;
    _blueButton.hidden = NO;
    _redButton.hidden = NO;
    _greenButton.hidden = NO;
    _settingsButton.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.35
                     animations:^{
                         _settingsButton.alpha = 0;
                         CGRect frame = _orangeButton.frame;
                         frame.origin.x = 10;
                         _orangeButton.frame = frame;
                         
                         frame = _blueButton.frame;
                         frame.origin.y = self.view.bounds.size.height-_blueButton.frame.size.height-10;
                         _blueButton.frame = frame;
                         
                         frame = _redButton.frame;
                         frame.origin.y = 10;
                         _redButton.frame = frame;
                         
                         frame = _greenButton.frame;
                         frame.origin.x = self.view.bounds.size.width-_greenButton.frame.size.width-10;
                         _greenButton.frame = frame;
                     }];
    
    [self addPulseAnimationTo:_orangeButton];
    [self addPulseAnimationTo:_blueButton];
    [self addPulseAnimationTo:_redButton];
    [self addPulseAnimationTo:_greenButton];
    
    themeOptionsHider = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(hideThemeOptions) userInfo:nil repeats:NO];
}

-(void)hideThemeOptions
{
    [UIView animateWithDuration:0.25
                     animations:^{
                         _settingsButton.alpha = 1.0f;
                         CGRect frame = _orangeButton.frame;
                         frame.origin.x = -_orangeButton.frame.size.width;
                         _orangeButton.frame = frame;
                         
                         frame = _blueButton.frame;
                         frame.origin.y = self.view.bounds.size.height;
                         _blueButton.frame = frame;
                         
                         frame = _redButton.frame;
                         frame.origin.y = -_redButton.frame.size.height;
                         _redButton.frame = frame;
                         
                         frame = _greenButton.frame;
                         frame.origin.x = self.view.bounds.size.width;
                         _greenButton.frame = frame;
                     }
                     completion:^(BOOL finished) {
                         _settingsButton.userInteractionEnabled = YES;
                         _orangeButton.hidden = YES;
                         _blueButton.hidden = YES;
                         _redButton.hidden = YES;
                         _greenButton.hidden = YES;
                     }];
    
    [self removePulseAnimationsFrom:_orangeButton];
    [self removePulseAnimationsFrom:_blueButton];
    [self removePulseAnimationsFrom:_redButton];
    [self removePulseAnimationsFrom:_greenButton];
}

#pragma mark - SettingsDelegate

-(void)themeChanged
{
    [self updateTheme];
}

-(void)sendEmail
{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    if (picker)
    {
        picker.mailComposeDelegate = self;
        [picker setSubject:[NSString stringWithFormat:@"Check out this app!"]];
        NSString *emailBody = @"Found this app very useful! \n Algos - itms://itunes.com/apps/toonic";
        [picker setMessageBody:emailBody isHTML:NO];
        [self presentViewController:picker animated:YES completion:^{
            
        }];
    }
}

-(void)tweet
{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        SLComposeViewControllerCompletionHandler completionBlock = ^(SLComposeViewControllerResult result){
            if (result == SLComposeViewControllerResultCancelled)
            {
                NSLog(@"Cancelled");
            }
            else
            {
                NSLog(@"Done");
            }
            
            [controller dismissViewControllerAnimated:YES completion:Nil];
        };
        
        controller.completionHandler =completionBlock;
        
        //Adding the Text to the facebook post value from iOS
        [controller setInitialText:@"Check out this useful app! \n Algos - itms://itunes.com/apps/toonic"];
        
        //Adding the URL to the facebook post value from iOS
        
        //        [controller addURL:[NSURL URLWithString:@"http://www.imaginea.com"]];
        
        //Adding the Image to the facebook post value from iOS
        
        //        [controller addImage:[UIImage imageNamed:@"fb.png"]];
        
        [self presentViewController:controller animated:YES completion:Nil];
        
    }
    else
    {
        NSLog(@"UnAvailable");
    }
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [controller dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
