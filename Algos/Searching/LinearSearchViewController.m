//
//  LinearSearchViewController.m
//  Algos
//
//  Created by Manigandan Parthasarathi on 06/07/13.
//  Copyright (c) 2013 Manigandan Parthasarathi. All rights reserved.
//

#import "LinearSearchViewController.h"
#import "ElementLabel.h"
#import "NumberSelectionView.h"
#import "Utils.h"
#import <QuartzCore/QuartzCore.h>

#define ELEMENT_BASE_TAG            300

#define ELEMENT_FRAME               CGRectMake(167, 400, 60, 60)
#define ELEMENT_FRAME_PHONE_5       CGRectMake(89, 193, 30, 30)
#define ELEMENT_FRAME_PHONE         CGRectMake(45, 193, 30, 30)

@interface LinearSearchViewController ()
{
    NSUInteger comparisonCount;
    CGFloat animationSpeed;
    NSUInteger numberToSearch;
}
@end

@implementation LinearSearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _comparisonsCountLabel.textColor = [Utils themeColor];
    
    comparisonCount = 0;
    animationSpeed = 0.3;
    numberToSearch = 0;
    _numberSelectionView.delegate = self;
    _numbers = [[NSMutableArray alloc] initWithCapacity:10];
    
    for (int index = 0; index < 10; ++index)
    {
        [_numbers addObject:[NSNumber numberWithInt:index+1]];
    }
    
    [self shuffleArray:_numbers];
    
    for(int index=0; index<_numbers.count; index++)
    {
        NSUInteger number = [[_numbers objectAtIndex:index] intValue];
        CGRect elementFrame = IS_IPAD ? ELEMENT_FRAME: IS_IPHONE_5 ? ELEMENT_FRAME_PHONE_5:ELEMENT_FRAME_PHONE;
        elementFrame.origin.x += index*(IS_IPAD?70:40);
        ElementLabel *element = [[ElementLabel alloc] initWithFrame:elementFrame];
        element.tag = index+ELEMENT_BASE_TAG;
        element.text = [NSString stringWithFormat:@"%d",number];
        [self.view addSubview:element];
    }

    if(!IS_IPAD && !IS_IPHONE_5)
    {
        [self screenSizeAdjustments];
    }
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swiped)];
    swipe.direction = UISwipeGestureRecognizerDirectionLeft|UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipe];
}

-(void)screenSizeAdjustments
{
    _titleLabel.frame = CGRectMake(172.0f, 0, 136.0f, 26.0f);
    _comparisonsLabel.frame = CGRectMake(352.0f, 270.0f, 91.0f, 31.0f);
    _comparisonsCountLabel.frame = CGRectMake(453.0f, 268.0f, 33.0f, 35.0f);
    _comparisonTextLabel.frame = CGRectMake(0, 237.0f, 480.0f, 32.0f);
    _numberSelectionView.frame = CGRectMake(150.0f, 40.0f, 180.0f, 90.0f);
    _searchForLabel.frame = CGRectMake(167.0f, 103.0f, 53.0f, 21.0f);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

#pragma mark - UIActions

-(void)swiped
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - NumberSelectionDelegate

-(void)numberViewTouched
{
    comparisonCount = 0;
    _comparisonsCountLabel.text = @"0";
    _comparisonTextLabel.text = @"";
    for(int i=0; i<10; i++)
    {
        [self lowerElementAtIndex:i animated:YES];
        [self removeHighlightColorAtIndex:i];
        [self removePulseAnimationAtIndex:i];
    }
}

-(void)numberSelected:(NSUInteger)number
{
    comparisonCount = 0;
    _comparisonsCountLabel.text = @"0";
    _comparisonTextLabel.text = @"";
    
    numberToSearch = number;
    
    _numberSelectionView.userInteractionEnabled = NO;
    
    [self searchAtIndex:0];
}


#pragma mark - Logics

-(void)searchAtIndex:(NSUInteger)index
{
    [UIView animateWithDuration:animationSpeed
                          delay:0.5f
                        options:UIViewAnimationOptionAllowAnimatedContent
                     animations:^{
                         [self highlightColorAtIndex:index];
                         [self raiseElementAtIndex:index animated:NO];
                     }
                     completion:^(BOOL finished) {
                         NSUInteger numberAtIndex = [self elementAtIndex:index];
                         if(numberToSearch != numberAtIndex)
                         {
                             _comparisonTextLabel.text = [NSString stringWithFormat:@"%d ≠ %d", numberToSearch, numberAtIndex];
                             comparisonCount++;
                             _comparisonsCountLabel.text = [NSString stringWithFormat:@"%d", comparisonCount];
                             [UIView animateWithDuration:animationSpeed
                                                   delay:0.5f
                                                 options:UIViewAnimationOptionAllowAnimatedContent
                                              animations:^{
                                                  [self lowerElementAtIndex:index animated:NO];
                                              }
                                              completion:^(BOOL finished) {
                                                  _comparisonTextLabel.text = @"";
                                                  [self removeHighlightColorAtIndex:index];
                                                  
                                                  if(index<10)
                                                  {
                                                      [self searchAtIndex:index+1];
                                                  }
                                                  else
                                                  {
                                                      _comparisonTextLabel.text = @"Not Found";
                                                      _numberSelectionView.userInteractionEnabled = YES;
                                                  }
                                              }];
                         }
                         else
                         {
                             _comparisonTextLabel.text = @"Found";
                             _numberSelectionView.userInteractionEnabled = YES;
                             [self addPulseAnimationAtIndex:index];
                         }
                     }];
}

#pragma mark - Helper Methods

- (void)shuffleArray:(NSMutableArray*)array
{
    for(NSUInteger i = [array count]; i > 1; i--) {
        NSUInteger j = arc4random_uniform(i);
        [array exchangeObjectAtIndex:i-1 withObjectAtIndex:j];
    }
}

-(NSUInteger)elementAtIndex:(NSUInteger)index
{
    NSUInteger tag = index + ELEMENT_BASE_TAG;
    ElementLabel *label = (ElementLabel*)[self.view viewWithTag:tag];
    return [label.text intValue];
}

-(void)raiseElementAtIndex:(NSUInteger)index animated:(BOOL)anim
{
    NSUInteger tag = index + ELEMENT_BASE_TAG;
    ElementLabel *label = (ElementLabel*)[self.view viewWithTag:tag];
    
    if(anim)
    {
        [UIView animateWithDuration:anim?animationSpeed:0
                         animations:^{
                             CGRect labelFrame = label.frame;
                             labelFrame.origin.y = IS_IPAD?326:156;
                             label.frame = labelFrame;
                         }];
    }
    else
    {
        CGRect labelFrame = label.frame;
        labelFrame.origin.y = IS_IPAD?326:156;
        label.frame = labelFrame;
    }
}

-(void)lowerElementAtIndex:(NSUInteger)index animated:(BOOL)anim
{
    NSUInteger tag = index + ELEMENT_BASE_TAG;
    ElementLabel *label = (ElementLabel*)[self.view viewWithTag:tag];
    
    if(anim)
    {
        [UIView animateWithDuration:anim?animationSpeed:0
                         animations:^{
                             CGRect labelFrame = label.frame;
                             labelFrame.origin.y = IS_IPAD?400:193;
                             label.frame = labelFrame;
                         }];
    }
    else
    {
        CGRect labelFrame = label.frame;
        labelFrame.origin.y = IS_IPAD?400:193;
        label.frame = labelFrame;
    }
}

-(void)removeHighlightColorAtIndex:(NSUInteger)index
{
    NSUInteger tag = index + ELEMENT_BASE_TAG;
    ElementLabel *label = (ElementLabel*)[self.view viewWithTag:tag];
    [label removeHighlight];
}

-(void)highlightColorAtIndex:(NSUInteger)index
{
    NSUInteger tag = index + ELEMENT_BASE_TAG;
    ElementLabel *label = (ElementLabel*)[self.view viewWithTag:tag];
    [label highlight];
}

-(void)removePulseAnimationAtIndex:(NSUInteger)index
{
    NSUInteger tag = index + ELEMENT_BASE_TAG;
    ElementLabel *label = (ElementLabel*)[self.view viewWithTag:tag];
    [label.layer removeAnimationForKey:@"pulseAnimation"];
}

-(void)addPulseAnimationAtIndex:(NSUInteger)index
{
    NSUInteger tag = index + ELEMENT_BASE_TAG;
    ElementLabel *label = (ElementLabel*)[self.view viewWithTag:tag];
    [label.layer removeAnimationForKey:@"pulseAnimation"];
    
    CABasicAnimation *pulseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulseAnimation.duration = 0.25f;
    pulseAnimation.toValue = [NSNumber numberWithFloat:1.1];
    pulseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulseAnimation.autoreverses = YES;
    pulseAnimation.repeatCount = FLT_MAX;
    
    [label.layer addAnimation:pulseAnimation forKey:@"pulseAnimation"];
}

#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
