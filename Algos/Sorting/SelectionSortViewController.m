//
//  SelectionSortViewController.m
//  Algos
//
//  Created by Manigandan Parthasarathi on 06/07/13.
//  Copyright (c) 2013 Manigandan Parthasarathi. All rights reserved.
//

#import "SelectionSortViewController.h"
#import "ElementLabel.h"
#import "Utils.h"
#import <QuartzCore/QuartzCore.h>

#define ELEMENT_BASE_TAG            100
#define BAR_BASE_TAG                200
#define ELEMENT_FRAME               CGRectMake(167, 500, 60, 60)
#define ELEMENT_FRAME_PHONE_5       CGRectMake(89, 193, 30, 30)
#define ELEMENT_FRAME_PHONE         CGRectMake(45, 193, 30, 30)
#define BAR_FRAME                   CGRectMake(197, 110, 20, 300)
#define BAR_FRAME_PHONE_5           CGRectMake(89, 80, 20, 80)
#define BAR_FRAME_PHONE             CGRectMake(45, 80, 20, 80)

@interface SelectionSortViewController ()
{
    NSUInteger iterationNumber;
    NSUInteger comparisonCount;
    BOOL bSwapped;
    CGFloat animationSpeed;
    UIColor *themeColor;
}
@end

@implementation SelectionSortViewController

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
    themeColor = [Utils themeColor];
    [self updateTheme];
    iterationNumber = 0;
    comparisonCount = 0;
    animationSpeed = 0.75f;
    
    UIImage *bgimage = [UIImage imageNamed:@"btn_highlighted.png"];
    bgimage = [bgimage stretchableImageWithLeftCapWidth:bgimage.size.width/2 topCapHeight:bgimage.size.height/2];
    [_speedButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_speedButton setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_speedButton setBackgroundImage:bgimage forState:UIControlStateHighlighted];
    [_dataSetButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_dataSetButton setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_dataSetButton setBackgroundImage:bgimage forState:UIControlStateHighlighted];
    [_sortLeftButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_sortLeftButton setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_sortLeftButton setBackgroundImage:bgimage forState:UIControlStateHighlighted];
    [_sortRightButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_sortRightButton setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_sortRightButton setBackgroundImage:bgimage forState:UIControlStateHighlighted];

    _sortLeftButton.exclusiveTouch = YES;
    _sortRightButton.exclusiveTouch = YES;
    _dataSetButton.exclusiveTouch = YES;
    
    _numbers = [[NSMutableArray alloc] initWithCapacity:10];
    
    for (int index = 0; index < 10; ++index)
    {
        [_numbers addObject:[NSNumber numberWithInt:index+1]];
    }
    
    [self shuffleArray:_numbers];
    
    for(int index=0; index<_numbers.count; index++)
    {
        NSUInteger number = [[_numbers objectAtIndex:index] intValue];
        CGRect elementFrame = IS_IPAD?ELEMENT_FRAME:IS_IPHONE_5?ELEMENT_FRAME_PHONE_5:ELEMENT_FRAME_PHONE;
        elementFrame.origin.x += index*(IS_IPAD?70:40);
        ElementLabel *element = [[ElementLabel alloc] initWithFrame:elementFrame];
        element.tag = index+ELEMENT_BASE_TAG;
        element.text = [NSString stringWithFormat:@"%d",number];
        [self.view addSubview:element];
        
        CGRect barFrame = IS_IPAD?BAR_FRAME:IS_IPHONE_5?BAR_FRAME_PHONE_5:BAR_FRAME_PHONE;
        barFrame.origin.x = element.frame.origin.x + (IS_IPAD?20:5);
        barFrame.origin.y = (IS_IPAD?110:60) + ((IS_IPAD?300:80) - (number*(IS_IPAD?30:10)));
        barFrame.size.height = number*(IS_IPAD?30:10);
        UIView *view = [[UIView alloc]initWithFrame:barFrame];
        view.tag = index+BAR_BASE_TAG;
        view.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.25];
        [self.view insertSubview:view belowSubview:element];
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
    _comparisonsLabel.frame = CGRectMake(362.0f, 2.0f, 70.0f, 25.0f);
    _comparisonsCountLabel.frame = CGRectMake(438.0f, 2.0f, 30.0f, 25.0f);
    _sortLeftButton.frame = CGRectMake(160.0f, 270.0f, 80.0f, 30.0f);
    _sortRightButton.frame = CGRectMake(240.0f, 270.0f, 80.0f, 30.0f);
    _dataSetButton.frame = CGRectMake(400.0f, 270.0f, 80.0f, 30.0f);
    _messageLabel.frame = CGRectMake(0, 240.0f, 480.0f, 21.0f);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

-(void)updateTheme
{
    _sortLeftButton.backgroundColor = themeColor;
    _dataSetButton.backgroundColor = themeColor;
    _speedButton.backgroundColor = themeColor;
    _comparisonsCountLabel.textColor = themeColor;
    _lineView.backgroundColor = themeColor;
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

-(IBAction)dataSetPressed:(id)sender
{
    BOOL isAscending = (_sortLeftButton.backgroundColor==themeColor);
    
    NSString *text = _dataSetButton.titleLabel.text;
    if([text isEqualToString:@"Average Case"])
    {
        [_dataSetButton setTitle:@"Best Case" forState:UIControlStateNormal];
        if(isAscending)
            [self bestCase];
        else
            [self worstCase];
    }
    else if([text isEqualToString:@"Best Case"])
    {
        [_dataSetButton setTitle:@"Worst Case" forState:UIControlStateNormal];
        if(isAscending)
            [self worstCase];
        else
            [self bestCase];
    }
    else
    {
        [_dataSetButton setTitle:@"Average Case" forState:UIControlStateNormal];
        [self averageCase];
    }
}

-(void)bestCase
{
    _comparisonsCountLabel.text = @"0";
    
    for(int i=0; i<10; i++)
    {
        [self removeHighlightColorAtIndex:i];
    }
    
    [_numbers removeAllObjects];
    
    for (int index = 0; index < 10; ++index)
    {
        [_numbers addObject:[NSNumber numberWithInt:index+1]];
    }
        
    for(int index=0; index<_numbers.count; index++)
    {
        NSUInteger number = [[_numbers objectAtIndex:index] intValue];
        NSUInteger tag = index + ELEMENT_BASE_TAG;
        ElementLabel *label = (ElementLabel*)[self.view viewWithTag:tag];
        label.text = [NSString stringWithFormat:@"%d",number];
        
        tag = index + BAR_BASE_TAG;
        CGRect barFrame = IS_IPAD?BAR_FRAME:IS_IPHONE_5?BAR_FRAME_PHONE_5:BAR_FRAME_PHONE;
        barFrame.origin.x = label.frame.origin.x + (IS_IPAD?20:5);
        barFrame.origin.y = (IS_IPAD?110:60) + ((IS_IPAD?300:80) - (number*(IS_IPAD?30:10)));
        barFrame.size.height = number*(IS_IPAD?30:10);
        
        UIView *viewAtIndex = [self.view viewWithTag:tag];
        viewAtIndex.frame = barFrame;
    }
}

-(void)averageCase
{
    _comparisonsCountLabel.text = @"0";
    
    for(int i=0; i<10; i++)
    {
        [self removeHighlightColorAtIndex:i];
    }
    
    [_numbers removeAllObjects];
    
    for (int index = 0; index < 10; ++index)
    {
        [_numbers addObject:[NSNumber numberWithInt:index+1]];
    }
    
    [self shuffleArray:_numbers];
    
    for(int index=0; index<_numbers.count; index++)
    {
        NSUInteger number = [[_numbers objectAtIndex:index] intValue];
        NSUInteger tag = index + ELEMENT_BASE_TAG;
        ElementLabel *label = (ElementLabel*)[self.view viewWithTag:tag];
        label.text = [NSString stringWithFormat:@"%d",number];
        
        tag = index + BAR_BASE_TAG;
        CGRect barFrame = IS_IPAD?BAR_FRAME:IS_IPHONE_5?BAR_FRAME_PHONE_5:BAR_FRAME_PHONE;
        barFrame.origin.x = label.frame.origin.x + (IS_IPAD?20:5);
        barFrame.origin.y = (IS_IPAD?110:60) + ((IS_IPAD?300:80) - (number*(IS_IPAD?30:10)));
        barFrame.size.height = number*(IS_IPAD?30:10);
        
        UIView *viewAtIndex = [self.view viewWithTag:tag];
        viewAtIndex.frame = barFrame;
    }
}

-(void)worstCase
{
    _comparisonsCountLabel.text = @"0";
    
    for(int i=0; i<10; i++)
    {
        [self removeHighlightColorAtIndex:i];
    }
    
    [_numbers removeAllObjects];
    
    for (int index = 10; index > 0; index--)
    {
        [_numbers addObject:[NSNumber numberWithInt:index]];
    }
        
    for(int index=0; index<_numbers.count; index++)
    {
        NSUInteger number = [[_numbers objectAtIndex:index] intValue];
        NSUInteger tag = index + ELEMENT_BASE_TAG;
        ElementLabel *label = (ElementLabel*)[self.view viewWithTag:tag];
        label.text = [NSString stringWithFormat:@"%d",number];
        
        tag = index + BAR_BASE_TAG;
        CGRect barFrame = IS_IPAD?BAR_FRAME:IS_IPHONE_5?BAR_FRAME_PHONE_5:BAR_FRAME_PHONE;
        barFrame.origin.x = label.frame.origin.x + (IS_IPAD?20:5);
        barFrame.origin.y = (IS_IPAD?110:60) + ((IS_IPAD?300:80) - (number*(IS_IPAD?30:10)));
        barFrame.size.height = number*(IS_IPAD?30:10);
        
        UIView *viewAtIndex = [self.view viewWithTag:tag];
        viewAtIndex.frame = barFrame;
    }
}

-(IBAction)speedButtonPressed:(id)sender
{
    NSString *text = _speedButton.titleLabel.text;
    if([text isEqualToString:@"1X"])
    {
        animationSpeed = 0.5f;
        [_speedButton setTitle:@"2X" forState:UIControlStateNormal];
    }
    else if([text isEqualToString:@"2X"])
    {
        animationSpeed = 0.2f;
        [_speedButton setTitle:@"4X" forState:UIControlStateNormal];
    }
    else
    {
        animationSpeed = 0.75f;
        [_speedButton setTitle:@"1X" forState:UIControlStateNormal];
    }
}

-(IBAction)sortLeft:(id)sender
{
    _sortLeftButton.backgroundColor = themeColor;
    _sortRightButton.backgroundColor = [UIColor blackColor];
    
    [self enableControls:NO];
    
    for(int i=0; i<10; i++)
    {
        [self removeHighlightColorAtIndex:i];
    }
    iterationNumber = 0;
    comparisonCount = 0;

    [self startAscendingSorting];
}

-(IBAction)sortRight:(id)sender
{
    _sortRightButton.backgroundColor = themeColor;
    _sortLeftButton.backgroundColor = [UIColor blackColor];
    
    [self enableControls:NO];

    for(int i=0; i<10; i++)
    {
        [self removeHighlightColorAtIndex:i];
    }
    iterationNumber = 0;
    comparisonCount = 0;
    [self startDescendingSorting];
}

#pragma mark - Logics

-(void)startAscendingSorting
{
    if(iterationNumber<9)
    {
        CGRect elementFrame = IS_IPAD?ELEMENT_FRAME:IS_IPHONE_5?ELEMENT_FRAME_PHONE_5:ELEMENT_FRAME_PHONE;
        
        CGRect lineFrame = _lineView.frame;
        lineFrame.origin.x = elementFrame.origin.x + (iterationNumber*(IS_IPAD?70:40));
        lineFrame.size.width = (IS_IPAD?690:390)-(iterationNumber*(IS_IPAD?70:40));
        _lineView.frame = lineFrame;
        _messageLabel.text = [NSString stringWithFormat: @"Find Minimum & Swap with number at position %d", iterationNumber+1];
        
        [UIView animateWithDuration:animationSpeed
                         animations:^{
                             _lineView.alpha = 1.0f;
                             _messageLabel.alpha = 1.0f;
                         }
                         completion:^(BOOL finished) {
                             [UIView animateWithDuration:animationSpeed
                                              animations:^{
                                                  [self raiseElementAtIndex:iterationNumber animated:NO];
                                              }
                                              completion:^(BOOL finished) {
                                                  [self findAscendingMinimum:iterationNumber :iterationNumber+1];
                                                  iterationNumber++;
                                              }];
                         }];
    }
    else
    {
        [self highlightColorAtIndex:9];
        [self enableControls:YES];
    }
}

-(void)startDescendingSorting
{
    if(iterationNumber<9)
    {
        CGRect elementFrame = IS_IPAD?ELEMENT_FRAME:IS_IPHONE_5?ELEMENT_FRAME_PHONE_5:ELEMENT_FRAME_PHONE;

        CGRect lineFrame = _lineView.frame;
        lineFrame.origin.x = elementFrame.origin.x + (iterationNumber*(IS_IPAD?70:40));
        lineFrame.size.width = (IS_IPAD?690:390)-(iterationNumber*(IS_IPAD?70:40));
        _lineView.frame = lineFrame;
        _messageLabel.text = [NSString stringWithFormat: @"Find Maximum & Swap with number at position %d", iterationNumber+1];
        
        [UIView animateWithDuration:animationSpeed
                         animations:^{
                             _lineView.alpha = 1.0f;
                             _messageLabel.alpha = 1.0f;
                         }
                         completion:^(BOOL finished) {
                             
                             [UIView animateWithDuration:animationSpeed
                                              animations:^{
                                                  [self raiseElementAtIndex:iterationNumber animated:NO];
                                              }
                                              completion:^(BOOL finished) {
                                                  [self findDescendingMaximum:iterationNumber :iterationNumber+1];
                                                  iterationNumber++;
                                              }];
                         }];
    }
    else
    {
        [self highlightColorAtIndex:9];
        [self enableControls:YES];
    }
}

-(void)findAscendingMinimum:(NSUInteger)currentMinimum :(NSUInteger)index
{
    [UIView animateWithDuration:animationSpeed
                     animations:^{
                         [self raiseElementAtIndex:index animated:NO];
                     }
                     completion:^(BOOL finished) {
                         
                         NSUInteger indexToLower = index;
                         NSUInteger newMinimum = currentMinimum;
                         
                         comparisonCount++;
                         _comparisonsCountLabel.text = [NSString stringWithFormat:@"%d", comparisonCount];
                         
                         if([self elementAtIndex:index] < [self elementAtIndex:currentMinimum])
                         {
                             indexToLower = currentMinimum;
                             newMinimum = index;
                         }
                         
                         [UIView animateWithDuration:animationSpeed
                                          animations:^{
                                              [self lowerElementAtIndex:indexToLower animated:NO];
                                          }
                                          completion:^(BOOL finished) {
                                              if(index < 9)
                                              {
                                                  [self findAscendingMinimum:newMinimum :index+1];
                                              }
                                              else
                                              {
                                                  [UIView animateWithDuration:animationSpeed
                                                                   animations:^{
                                                                       [self raiseElementAtIndex:iterationNumber-1 animated:NO];
                                                                   }
                                                                   completion:^(BOOL finished) {
                                                                       
                                                                       [UIView animateWithDuration:animationSpeed+0.5f
                                                                                        animations:^{
                                                                                            [self swapElementAtIndex:iterationNumber-1 with:newMinimum];
                                                                                        }
                                                                                        completion:^(BOOL finished) {
                                                                                           
                                                                                            [UIView animateWithDuration:animationSpeed
                                                                                                             animations:^{
                                                                                                                 [self lowerElementAtIndex:iterationNumber-1 animated:NO];
                                                                                                                 [self lowerElementAtIndex:newMinimum animated:NO];
                                                                                                             }
                                                                                                             completion:^(BOOL finished) {
                                                                                                                 [self highlightColorAtIndex:iterationNumber-1];                 _lineView.alpha = 0;             _messageLabel.alpha = 0;                           [self performSelector:@selector(startAscendingSorting) withObject:nil afterDelay:0.75f];
                                                                                                             }];
                                                                                        }];
                                                                   }];

                                              }
                                          }];
                     }];
}

-(void)findDescendingMaximum:(NSUInteger)currentMaximum :(NSUInteger)index
{
    [UIView animateWithDuration:animationSpeed
                     animations:^{
                         [self raiseElementAtIndex:index animated:NO];
                     }
                     completion:^(BOOL finished) {
                         
                         NSUInteger indexToLower = index;
                         NSUInteger newMaximum = currentMaximum;
                         
                         comparisonCount++;
                         _comparisonsCountLabel.text = [NSString stringWithFormat:@"%d", comparisonCount];
                         
                         if([self elementAtIndex:index] > [self elementAtIndex:currentMaximum])
                         {
                             indexToLower = currentMaximum;
                             newMaximum = index;
                         }
                         
                         [UIView animateWithDuration:animationSpeed
                                          animations:^{
                                              [self lowerElementAtIndex:indexToLower animated:NO];
                                          }
                                          completion:^(BOOL finished) {
                                              if(index < 9)
                                              {
                                                  [self findDescendingMaximum:newMaximum :index+1];
                                              }
                                              else
                                              {
                                                  [UIView animateWithDuration:animationSpeed
                                                                   animations:^{
                                                                       [self raiseElementAtIndex:iterationNumber-1 animated:NO];
                                                                   }
                                                                   completion:^(BOOL finished) {
                                                                       
                                                                       [UIView animateWithDuration:animationSpeed+0.5f
                                                                                        animations:^{
                                                                                            [self swapElementAtIndex:iterationNumber-1 with:newMaximum];
                                                                                        }
                                                                                        completion:^(BOOL finished) {
                                                                                            
                                                                                            [UIView animateWithDuration:animationSpeed
                                                                                                             animations:^{
                                                                                                                 [self lowerElementAtIndex:iterationNumber-1 animated:NO];
                                                                                                                 [self lowerElementAtIndex:newMaximum animated:NO];
                                                                                                             }
                                                                                                             completion:^(BOOL finished) {
                                                                                                                 [self highlightColorAtIndex:iterationNumber-1];                        _lineView.alpha = 0;             _messageLabel.alpha = 0;                        [self performSelector:@selector(startDescendingSorting) withObject:nil afterDelay:0.75f];
                                                                                                             }];
                                                                                        }];
                                                                   }];
                                                  
                                              }
                                          }];
                     }];
}

#pragma mark - Helper Methods

-(void)enableControls:(BOOL)enable
{
    _sortLeftButton.userInteractionEnabled = enable;
    _sortRightButton.userInteractionEnabled = enable;
    _dataSetButton.userInteractionEnabled = enable;
}

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

-(void)raiseElementAtIndex:(NSUInteger)index animated:(BOOL)anim
{
    NSUInteger tag = index + ELEMENT_BASE_TAG;
    ElementLabel *label = (ElementLabel*)[self.view viewWithTag:tag];
    
    tag = index + BAR_BASE_TAG;
    UIView *view = [self.view viewWithTag:tag];
    
    if(anim)
    {
        [UIView animateWithDuration:anim?animationSpeed:0
                         animations:^{
                             CGRect labelFrame = label.frame;
                             labelFrame.origin.y = IS_IPAD?426:150;
                             label.frame = labelFrame;
                             
                             view.backgroundColor = [UIColor whiteColor];
                         }];
    }
    else
    {
        CGRect labelFrame = label.frame;
        labelFrame.origin.y = IS_IPAD?426:150;
        label.frame = labelFrame;
        
        view.backgroundColor = [UIColor whiteColor];
    }
}

-(void)lowerElementAtIndex:(NSUInteger)index animated:(BOOL)anim
{
    NSUInteger tag = index + ELEMENT_BASE_TAG;
    ElementLabel *label = (ElementLabel*)[self.view viewWithTag:tag];
    
    tag = index + BAR_BASE_TAG;
    UIView *view = [self.view viewWithTag:tag];
    
    if(anim)
    {
        [UIView animateWithDuration:anim?animationSpeed:0
                         animations:^{
                             CGRect labelFrame = label.frame;
                             labelFrame.origin.y = IS_IPAD?500:193;
                             label.frame = labelFrame;
                             
                             view.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.25];

                         }];
    }
    else
    {
        CGRect labelFrame = label.frame;
        labelFrame.origin.y = IS_IPAD?500:193;
        label.frame = labelFrame;
        
        view.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.25];
    }
}

-(void)swapElementAtIndex:(NSUInteger)fromIndex with:(NSUInteger)toIndex
{
    NSUInteger fromTag = fromIndex + ELEMENT_BASE_TAG;
    ElementLabel *labelAtFromindex = (ElementLabel*)[self.view viewWithTag:fromTag];
    
    NSUInteger toTag = toIndex + ELEMENT_BASE_TAG;
    ElementLabel *labelAtToindex = (ElementLabel*)[self.view viewWithTag:toTag];
    
    CGRect labelFrame = IS_IPAD?ELEMENT_FRAME:IS_IPHONE_5?ELEMENT_FRAME_PHONE_5:ELEMENT_FRAME_PHONE;
    labelFrame.origin.x += toIndex*(IS_IPAD?70:40);
    labelFrame.origin.y = IS_IPAD?426:150;
    labelAtFromindex.frame = labelFrame;
    
    labelFrame = IS_IPAD?ELEMENT_FRAME:IS_IPHONE_5?ELEMENT_FRAME_PHONE_5:ELEMENT_FRAME_PHONE;
    labelFrame.origin.x += fromIndex*(IS_IPAD?70:40);
    labelFrame.origin.y = IS_IPAD?426:150;
    labelAtToindex.frame = labelFrame;
    
    labelAtFromindex.tag = toTag;
    labelAtToindex.tag = fromTag;
    
    fromTag = fromIndex + BAR_BASE_TAG;
    UIView *viewAtFromindex = [self.view viewWithTag:fromTag];
    
    toTag = toIndex + BAR_BASE_TAG;
    UIView *viewAtToindex = [self.view viewWithTag:toTag];
    
    CGRect viewFrame = viewAtFromindex.frame;
    viewFrame.origin.x = labelAtFromindex.frame.origin.x + (IS_IPAD?20:5);
    viewAtFromindex.frame = viewFrame;
    
    viewFrame = viewAtToindex.frame;
    viewFrame.origin.x = labelAtToindex.frame.origin.x + (IS_IPAD?20:5);
    viewAtToindex.frame = viewFrame;
    
    viewAtFromindex.tag = toTag;
    viewAtToindex.tag = fromTag;
}

#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
