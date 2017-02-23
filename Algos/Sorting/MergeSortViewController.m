//
//  MergeSortViewController.m
//  Algos
//
//  Created by Manigandan Parthasarathi on 06/07/13.
//  Copyright (c) 2013 Manigandan Parthasarathi. All rights reserved.
//

#import "MergeSortViewController.h"
#import "ElementLabel.h"
#import "Utils.h"
#import <QuartzCore/QuartzCore.h>

#define ELEMENT_BASE_TAG                    100
#define NEW_ELEMENT_BASE_TAG                200
#define INVALID_INDEX                       999
#define SNAP1_TAG                           401
#define SNAP2_TAG                           402

#define ELEMENT_FRAME                       CGRectMake(237, 150, 60, 60)
#define ELEMENT_FRAME_PHONE_5               CGRectMake(129, 60, 30, 30)
#define ELEMENT_FRAME_PHONE                 CGRectMake(85, 60, 30, 30)
#define ELEMENT_SECOND_ROW_FRAME            CGRectMake(207, 355, 60, 60)
#define ELEMENT_SECOND_ROW_FRAME_PHONE_5    CGRectMake(114, 127, 30, 30)
#define ELEMENT_SECOND_ROW_FRAME_PHONE      CGRectMake(70, 127, 30, 30)
#define ELEMENT_THIRD_ROW_FRAME             CGRectMake(237, 534, 60, 60)
#define ELEMENT_THIRD_ROW_FRAME_PHONE_5     CGRectMake(129, 193, 30, 30)
#define ELEMENT_THIRD_ROW_FRAME_PHONE       CGRectMake(85, 193, 30, 30)

@interface MergeSortViewController ()
{
    NSUInteger iterationNumber;
    NSUInteger comparisonCount;
    CGFloat animationSpeed;
    UIColor *themeColor;
    BOOL bDescending;
}
@end

@implementation MergeSortViewController

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
    bDescending = NO;
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
    
    _numbers = [[NSMutableArray alloc] initWithCapacity:8];
    
    for (int index = 0; index < 8; ++index)
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

-(IBAction)sortLeft:(id)sender
{
    _sortLeftButton.backgroundColor = themeColor;
    _sortRightButton.backgroundColor = [UIColor blackColor];
    
    bDescending = NO;
    
    [self enableControls:NO];
    
    _comparisonsCountLabel.text = @"0";
    UIImageView *imgView = (UIImageView*)[self.view viewWithTag:SNAP1_TAG];
    if(imgView)
    {
        [imgView removeFromSuperview];
        imgView = nil;
    }
    imgView = (UIImageView*)[self.view viewWithTag:SNAP2_TAG];
    if(imgView)
    {
        [imgView removeFromSuperview];
        imgView = nil;
    }
    
    for(int i=0; i<8; i++)
    {
        [self removeHighlightColorAtIndex:i];
    }
    
    for(int index=0; index<_numbers.count; index++)
    {
        NSUInteger tag = index + ELEMENT_BASE_TAG;
        ElementLabel *label = (ElementLabel*)[self.view viewWithTag:tag];
        CGRect elementFrame = IS_IPAD?ELEMENT_FRAME:IS_IPHONE_5?ELEMENT_FRAME_PHONE_5:ELEMENT_FRAME_PHONE;
        elementFrame.origin.x += index*(IS_IPAD?70:40);
        label.frame = elementFrame;
    }

    iterationNumber = 0;
    comparisonCount = 0;
    
    [self firstStepAnimation];
}

-(IBAction)sortRight:(id)sender
{
    _sortRightButton.backgroundColor = themeColor;
    _sortLeftButton.backgroundColor = [UIColor blackColor];
    
    bDescending = YES;
    
    [self enableControls:NO];
    
    _comparisonsCountLabel.text = @"0";
    UIImageView *imgView = (UIImageView*)[self.view viewWithTag:SNAP1_TAG];
    if(imgView)
    {
        [imgView removeFromSuperview];
        imgView = nil;
    }
    
    imgView = (UIImageView*)[self.view viewWithTag:SNAP2_TAG];
    if(imgView)
    {
        [imgView removeFromSuperview];
        imgView = nil;
    }
    
    for(int i=0; i<8; i++)
    {
        [self removeHighlightColorAtIndex:i];
    }
        
    for(int index=0; index<_numbers.count; index++)
    {
        NSUInteger tag = index + ELEMENT_BASE_TAG;
        ElementLabel *label = (ElementLabel*)[self.view viewWithTag:tag];
        CGRect elementFrame = IS_IPAD?ELEMENT_FRAME:IS_IPHONE_5?ELEMENT_FRAME_PHONE_5:ELEMENT_FRAME_PHONE;
        elementFrame.origin.x += index*(IS_IPAD?70:40);
        label.frame = elementFrame;
    }

    iterationNumber = 0;
    comparisonCount = 0;
    
    [self firstStepAnimation];
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
            [self bestCase];    }
    else
    {
        [_dataSetButton setTitle:@"Average Case" forState:UIControlStateNormal];
        [self averageCase];
    }
}

-(void)bestCase
{
    _comparisonsCountLabel.text = @"0";
    UIImageView *imgView = (UIImageView*)[self.view viewWithTag:SNAP1_TAG];
    if(imgView)
    {
        [imgView removeFromSuperview];
        imgView = nil;
    }
    
    imgView = (UIImageView*)[self.view viewWithTag:SNAP2_TAG];
    if(imgView)
    {
        [imgView removeFromSuperview];
        imgView = nil;
    }
    
    for(int i=0; i<8; i++)
    {
        [self removeHighlightColorAtIndex:i];
    }
    
    [_numbers removeAllObjects];
    
    for (int index = 0; index < 8; ++index)
    {
        [_numbers addObject:[NSNumber numberWithInt:index+1]];
    }
    
    for(int index=0; index<_numbers.count; index++)
    {
        NSUInteger number = [[_numbers objectAtIndex:index] intValue];
        NSUInteger tag = index + ELEMENT_BASE_TAG;
        ElementLabel *label = (ElementLabel*)[self.view viewWithTag:tag];
        label.text = [NSString stringWithFormat:@"%d",number];
        CGRect elementFrame = IS_IPAD?ELEMENT_FRAME:IS_IPHONE_5?ELEMENT_FRAME_PHONE_5:ELEMENT_FRAME_PHONE;
        elementFrame.origin.x += index*(IS_IPAD?70:40);
        label.frame = elementFrame;
    }
}

-(void)averageCase
{
    _comparisonsCountLabel.text = @"0";
    UIImageView *imgView = (UIImageView*)[self.view viewWithTag:SNAP1_TAG];
    if(imgView)
    {
        [imgView removeFromSuperview];
        imgView = nil;
    }
    
    imgView = (UIImageView*)[self.view viewWithTag:SNAP2_TAG];
    if(imgView)
    {
        [imgView removeFromSuperview];
        imgView = nil;
    }
    
    for(int i=0; i<8; i++)
    {
        [self removeHighlightColorAtIndex:i];
    }
    
    [_numbers removeAllObjects];
    
    for (int index = 0; index < 8; ++index)
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
        CGRect elementFrame = IS_IPAD?ELEMENT_FRAME:IS_IPHONE_5?ELEMENT_FRAME_PHONE_5:ELEMENT_FRAME_PHONE;
        elementFrame.origin.x += index*(IS_IPAD?70:40);
        label.frame = elementFrame;
    }
}

-(void)worstCase
{
    _comparisonsCountLabel.text = @"0";
    UIImageView *imgView = (UIImageView*)[self.view viewWithTag:SNAP1_TAG];
    if(imgView)
    {
        [imgView removeFromSuperview];
        imgView = nil;
    }
    
    imgView = (UIImageView*)[self.view viewWithTag:SNAP2_TAG];
    if(imgView)
    {
        [imgView removeFromSuperview];
        imgView = nil;
    }
    
    for(int i=0; i<8; i++)
    {
        [self removeHighlightColorAtIndex:i];
    }
    
    [_numbers removeAllObjects];
    
    for (int index = 8; index > 0; index--)
    {
        [_numbers addObject:[NSNumber numberWithInt:index]];
    }
    
    for(int index=0; index<_numbers.count; index++)
    {
        NSUInteger number = [[_numbers objectAtIndex:index] intValue];
        NSUInteger tag = index + ELEMENT_BASE_TAG;
        ElementLabel *label = (ElementLabel*)[self.view viewWithTag:tag];
        label.text = [NSString stringWithFormat:@"%d",number];
        CGRect elementFrame = IS_IPAD?ELEMENT_FRAME:IS_IPHONE_5?ELEMENT_FRAME_PHONE_5:ELEMENT_FRAME_PHONE;
        elementFrame.origin.x += index*(IS_IPAD?70:40);
        label.frame = elementFrame;
    }
}

#pragma mark - Logics

-(void)firstStepAnimation
{
    [UIView animateWithDuration:0.25
                     animations:^{
                         
                         for(int index=0; index<8; index++)
                         {
                             CGFloat xPos = 0;
                             switch (index) {
                                 case 0:
                                 case 1:
                                 {
                                     xPos = -50.0f;
                                 }
                                     break;
                                 case 2:
                                 case 3:
                                 {
                                     xPos = -20.0f;
                                 }
                                     break;
                                 case 4:
                                 case 5:
                                 {
                                     xPos = 20.0f;
                                 }
                                     break;
                                 case 6:
                                 case 7:
                                 {
                                     xPos = 50.0f;
                                 }
                                     break;
                                 default:
                                     break;
                             }
                             
                             NSUInteger tag = index + ELEMENT_BASE_TAG;
                             ElementLabel *label = (ElementLabel*)[self.view viewWithTag:tag];
                             label.frame = CGRectOffset(label.frame, xPos, 0);
                         }
                     }
                     completion:^(BOOL finished) {
                         [self compareFirstStep:0];
                     }];
}

-(void)compareFirstStep:(NSUInteger)index
{
    [self highlightColorAtIndex:index];
    [self highlightColorAtIndex:index+1];
    
    [UIView animateWithDuration:animationSpeed
                          delay:0.5
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         comparisonCount++;
                         _comparisonsCountLabel.text = [NSString stringWithFormat:@"%d", comparisonCount];
                         
                         if(!bDescending)
                         {
                             if([self elementAtIndex:index+1] < [self elementAtIndex:index])
                             {
                                 [self swapElementAtIndex:index with:index+1];
                             }
                             else
                             {
                                 // added for time elapse - otherwise highlight is not working
                                 static CGFloat val = 1;
                                 _dummyView.frame = CGRectOffset(_dummyView.frame, 0, val++);
                             }
                         }
                         else
                         {
                             if([self elementAtIndex:index+1] > [self elementAtIndex:index])
                             {
                                 [self swapElementAtIndex:index with:index+1];
                             }
                             else
                             {
                                 // added for time elapse - otherwise highlight is not working
                                 static CGFloat val = 1;
                                 _dummyView.frame = CGRectOffset(_dummyView.frame, 0, val++);
                             }
                         }
                     }
                     completion:^(BOOL finished) {
                         [self removeHighlightColorAtIndex:index];
                         [self removeHighlightColorAtIndex:index+1];
                         if(index<7)
                         {
                             [self compareFirstStep:index+2];
                         }
                         else
                         {
                             CGRect cropRect = IS_IPAD?ELEMENT_FRAME:IS_IPHONE_5?ELEMENT_FRAME_PHONE_5:ELEMENT_FRAME_PHONE;
                             CGRect imageRect = CGRectMake(0, cropRect.origin.y, self.view.bounds.size.width, cropRect.size.height);
                             UIImage *image = [self imageFromFrame:imageRect];
                             CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], imageRect);
                             
                             UIImageView *imgView = [[UIImageView alloc] initWithFrame:imageRect];
                             imgView.tag = SNAP1_TAG;
                             imgView.image = [UIImage imageWithCGImage:imageRef];
                             image = [UIImage imageWithCGImage:imageRef];
                             imgView.alpha = 0.3;
                             CGImageRelease(imageRef);
                             
                             [self.view insertSubview:imgView aboveSubview:[self.view viewWithTag:99]];
                             
                             [self compareSecondStep];
                         }
                     }];
}


-(UIImage*)imageFromFrame:(CGRect)frame
{
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

-(void)compareSecondStep
{
    [self compareLeftBlock:0 with:2 andMoveTo:0];
}

-(void)compareLeftBlock:(NSUInteger)firstIndex with:(NSUInteger)secondIndex andMoveTo:(NSUInteger)newIndex
{
    if(firstIndex!=INVALID_INDEX && secondIndex!= INVALID_INDEX)
    {
        [self highlightColorAtIndex:firstIndex];
        [self highlightColorAtIndex:secondIndex];
        
        NSUInteger numberAtFirstIndex = [self elementAtIndex:bDescending?secondIndex:firstIndex];
        NSUInteger numberAtSecondIndex = [self elementAtIndex:bDescending?firstIndex:secondIndex];
        
        [UIView animateWithDuration:animationSpeed
                              delay:0.5
                            options:UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             if(newIndex<3)
                             {
                                 comparisonCount++;
                                 _comparisonsCountLabel.text = [NSString stringWithFormat:@"%d", comparisonCount];
                                 if(numberAtFirstIndex < numberAtSecondIndex)
                                 {
                                     [self moveElementForSecondStep:firstIndex toIndex:newIndex];
                                 }
                                 else
                                 {
                                     [self moveElementForSecondStep:secondIndex toIndex:newIndex];
                                 }
                             }
                         }
                         completion:^(BOOL finished) {
                             
                             for(id eL in self.view.subviews)
                             {
                                 if([eL isKindOfClass:[ElementLabel class]])
                                 {
                                     ElementLabel *label = (ElementLabel*)eL;
                                     label.backgroundColor = [UIColor whiteColor];
                                     label.textColor = [UIColor blackColor];
                                 }
                             }
                             
                             if(newIndex<3)
                             {
                                 if(numberAtFirstIndex < numberAtSecondIndex)
                                 {
                                     NSUInteger fI = firstIndex<1 ? firstIndex+1 : INVALID_INDEX;
                                     [self compareLeftBlock:fI with:secondIndex andMoveTo:newIndex+1];
                                 }
                                 else
                                 {
                                     NSUInteger sI = secondIndex<3 ? secondIndex+1 : INVALID_INDEX;
                                     [self compareLeftBlock:firstIndex with:sI andMoveTo:newIndex+1];
                                 }
                             }
                             else
                             {
                                 [self performSelector:@selector(comapreRightBlock) withObject:nil afterDelay:1.0f];
                             }
                         }];
    }
    else
    {
        if(firstIndex==INVALID_INDEX)
        {
            [UIView animateWithDuration:animationSpeed
                                  delay:0.5
                                options:UIViewAnimationOptionAllowUserInteraction
                             animations:^{
                                 [self moveElementForSecondStep:secondIndex toIndex:newIndex];
                                 if(secondIndex<3)
                                     [self moveElementForSecondStep:secondIndex+1 toIndex:newIndex+1];
                             }
                             completion:^(BOOL finished) {
                                 [self performSelector:@selector(comapreRightBlock) withObject:nil afterDelay:1.0f];
                             }];
        }
        else
        {
            [UIView animateWithDuration:animationSpeed
                                  delay:0.5
                                options:UIViewAnimationOptionAllowUserInteraction
                             animations:^{
                                 [self moveElementForSecondStep:firstIndex toIndex:newIndex];
                                 if(firstIndex<1)
                                     [self moveElementForSecondStep:firstIndex+1 toIndex:newIndex+1];
                             }
                             completion:^(BOOL finished) {
                                 [self performSelector:@selector(comapreRightBlock) withObject:nil afterDelay:1.0f];
                             }];
        }
    }
}

-(void)comapreRightBlock
{
    [self compareRightBlock:4 with:6 andMoveTo:4];
}

-(void)compareRightBlock:(NSUInteger)firstIndex with:(NSUInteger)secondIndex andMoveTo:(NSUInteger)newIndex
{
    if(firstIndex!=INVALID_INDEX && secondIndex!= INVALID_INDEX)
    {
        [self highlightColorAtIndex:firstIndex];
        [self highlightColorAtIndex:secondIndex];
        
        NSUInteger numberAtFirstIndex = [self elementAtIndex:bDescending?secondIndex:firstIndex];
        NSUInteger numberAtSecondIndex = [self elementAtIndex:bDescending?firstIndex:secondIndex];
        
        [UIView animateWithDuration:animationSpeed
                              delay:0.5
                            options:UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             if(newIndex<7)
                             {
                                 comparisonCount++;
                                 _comparisonsCountLabel.text = [NSString stringWithFormat:@"%d", comparisonCount];
                                 if(numberAtFirstIndex < numberAtSecondIndex)
                                 {
                                     [self moveElementForSecondStep:firstIndex toIndex:newIndex];
                                 }
                                 else
                                 {
                                     [self moveElementForSecondStep:secondIndex toIndex:newIndex];
                                 }
                             }
                         }
                         completion:^(BOOL finished) {
                             
                             for(id eL in self.view.subviews)
                             {
                                 if([eL isKindOfClass:[ElementLabel class]])
                                 {
                                     ElementLabel *label = (ElementLabel*)eL;
                                     label.backgroundColor = [UIColor whiteColor];
                                     label.textColor = [UIColor blackColor];
                                 }
                             }
                             
                             if(newIndex<7)
                             {
                                 if(numberAtFirstIndex < numberAtSecondIndex)
                                 {
                                     NSUInteger fI = firstIndex<5 ? firstIndex+1 : INVALID_INDEX;
                                     [self compareRightBlock:fI with:secondIndex andMoveTo:newIndex+1];
                                 }
                                 else
                                 {
                                     NSUInteger sI = secondIndex<7 ? secondIndex+1 : INVALID_INDEX;
                                     [self compareRightBlock:firstIndex with:sI andMoveTo:newIndex+1];
                                 }
                             }
                             else
                             {
                                 // reset the tags
                                 for(int i=0; i<8; i++)
                                 {
                                     ElementLabel *eL = (ElementLabel*)[self.view viewWithTag:i+NEW_ELEMENT_BASE_TAG];
                                     eL.tag = i+ELEMENT_BASE_TAG;
                                 }
                                 
                                 CGRect cropRect = IS_IPAD?ELEMENT_SECOND_ROW_FRAME:IS_IPHONE_5? ELEMENT_SECOND_ROW_FRAME_PHONE_5:ELEMENT_SECOND_ROW_FRAME_PHONE;
                             CGRect imageRect = CGRectMake(0, cropRect.origin.y, self.view.bounds.size.width, cropRect.size.height);
                                 UIImage *image = [self imageFromFrame:imageRect];
                                 CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], imageRect);
                                 
                                 UIImageView *imgView = [[UIImageView alloc] initWithFrame:imageRect];
                                 imgView.tag = SNAP2_TAG;
                                 imgView.image = [UIImage imageWithCGImage:imageRef];
                                 image = [UIImage imageWithCGImage:imageRef];
                                 imgView.alpha = 0.3;
                                 CGImageRelease(imageRef);
                                 
                                 [self.view insertSubview:imgView aboveSubview:[self.view viewWithTag:99]];
                                 [self performSelector:@selector(compareThirdStep) withObject:nil afterDelay:1.0f];
                             }
                         }];
    }
    else
    {
        if(firstIndex==INVALID_INDEX)
        {
            [UIView animateWithDuration:animationSpeed
                                  delay:0.5
                                options:UIViewAnimationOptionAllowUserInteraction
                             animations:^{
                                 [self moveElementForSecondStep:secondIndex toIndex:newIndex];
                                 if(secondIndex<7)
                                     [self moveElementForSecondStep:secondIndex+1 toIndex:newIndex+1];
                             }
                             completion:^(BOOL finished) {
                                 // reset the tags
                                 for(int i=0; i<8; i++)
                                 {
                                     ElementLabel *eL = (ElementLabel*)[self.view viewWithTag:i+NEW_ELEMENT_BASE_TAG];
                                     eL.tag = i+ELEMENT_BASE_TAG;
                                 }
                                 
                                 CGRect cropRect = IS_IPAD?ELEMENT_SECOND_ROW_FRAME:IS_IPHONE_5? ELEMENT_SECOND_ROW_FRAME_PHONE_5:ELEMENT_SECOND_ROW_FRAME_PHONE;
                             CGRect imageRect = CGRectMake(0, cropRect.origin.y, self.view.bounds.size.width, cropRect.size.height);
                                 UIImage *image = [self imageFromFrame:imageRect];
                                 CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], imageRect);
                                 
                                 UIImageView *imgView = [[UIImageView alloc] initWithFrame:imageRect];
                                 imgView.tag = SNAP2_TAG;
                                 imgView.image = [UIImage imageWithCGImage:imageRef];
                                 image = [UIImage imageWithCGImage:imageRef];
                                 imgView.alpha = 0.3;
                                 CGImageRelease(imageRef);
                                 
                                 [self.view insertSubview:imgView aboveSubview:[self.view viewWithTag:99]];
                                 [self performSelector:@selector(compareThirdStep) withObject:nil afterDelay:1.0f];
                             }];
        }
        else
        {
            [UIView animateWithDuration:animationSpeed
                                  delay:0.5
                                options:UIViewAnimationOptionAllowUserInteraction
                             animations:^{
                                 [self moveElementForSecondStep:firstIndex toIndex:newIndex];
                                 if(firstIndex<5)
                                     [self moveElementForSecondStep:firstIndex+1 toIndex:newIndex+1];
                             }
                             completion:^(BOOL finished) {
                                 // reset the tags
                                 for(int i=0; i<8; i++)
                                 {
                                     ElementLabel *eL = (ElementLabel*)[self.view viewWithTag:i+NEW_ELEMENT_BASE_TAG];
                                     eL.tag = i+ELEMENT_BASE_TAG;
                                 }
                                 
                                 CGRect cropRect = IS_IPAD?ELEMENT_SECOND_ROW_FRAME:IS_IPHONE_5? ELEMENT_SECOND_ROW_FRAME_PHONE_5:ELEMENT_SECOND_ROW_FRAME_PHONE;
                             CGRect imageRect = CGRectMake(0, cropRect.origin.y, self.view.bounds.size.width, cropRect.size.height);
                                 UIImage *image = [self imageFromFrame:imageRect];
                                 CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], imageRect);
                                 
                                 UIImageView *imgView = [[UIImageView alloc] initWithFrame:imageRect];
                                 imgView.tag = SNAP2_TAG;
                                 imgView.image = [UIImage imageWithCGImage:imageRef];
                                 image = [UIImage imageWithCGImage:imageRef];
                                 imgView.alpha = 0.3;
                                 CGImageRelease(imageRef);
                                 
                                 [self.view insertSubview:imgView aboveSubview:[self.view viewWithTag:99]];
                                 [self performSelector:@selector(compareThirdStep) withObject:nil afterDelay:1.0f];
                             }];
        }
    }
    
}

-(void)compareThirdStep
{
    [self step3CompareBlocks:0 with:4 andMoveTo:0];
}

-(void)step3CompareBlocks:(NSUInteger)firstIndex with:(NSUInteger)secondIndex andMoveTo:(NSUInteger)newIndex
{
    if(firstIndex!=INVALID_INDEX && secondIndex!= INVALID_INDEX)
    {
        [self highlightColorAtIndex:firstIndex];
        [self highlightColorAtIndex:secondIndex];
        
        NSUInteger numberAtFirstIndex = [self elementAtIndex:bDescending?secondIndex:firstIndex];
        NSUInteger numberAtSecondIndex = [self elementAtIndex:bDescending?firstIndex:secondIndex];
        
        [UIView animateWithDuration:animationSpeed
                              delay:0.5
                            options:UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             if(newIndex<8)
                             {
                                 comparisonCount++;
                                 _comparisonsCountLabel.text = [NSString stringWithFormat:@"%d", comparisonCount];
                                 if(numberAtFirstIndex < numberAtSecondIndex)
                                 {
                                     [self moveElementForThirdStep:firstIndex toIndex:newIndex];
                                 }
                                 else
                                 {
                                     [self moveElementForThirdStep:secondIndex toIndex:newIndex];
                                 }
                             }
                         }
                         completion:^(BOOL finished) {
                             
                             for(id eL in self.view.subviews)
                             {
                                 if([eL isKindOfClass:[ElementLabel class]])
                                 {
                                     ElementLabel *label = (ElementLabel*)eL;
                                     label.backgroundColor = [UIColor whiteColor];
                                     label.textColor = [UIColor blackColor];
                                 }
                             }
                             
                             if(newIndex<8)
                             {
                                 if(numberAtFirstIndex < numberAtSecondIndex)
                                 {
                                     NSUInteger fI = firstIndex<3 ? firstIndex+1 : INVALID_INDEX;
                                     [self step3CompareBlocks:fI with:secondIndex andMoveTo:newIndex+1];
                                 }
                                 else
                                 {
                                     NSUInteger sI = secondIndex<7 ? secondIndex+1 : INVALID_INDEX;
                                     [self step3CompareBlocks:firstIndex with:sI andMoveTo:newIndex+1];
                                 }
                             }
                             else
                             {
                                 // reset the tags
                                 for(int i=0; i<8; i++)
                                 {
                                     ElementLabel *eL = (ElementLabel*)[self.view viewWithTag:i+NEW_ELEMENT_BASE_TAG];
                                     eL.tag = i+ELEMENT_BASE_TAG;
                                 }
                                 
                                 [self enableControls:YES];
                             }
                         }];
    }
    else
    {
        if(firstIndex==INVALID_INDEX)
        {
            [UIView animateWithDuration:animationSpeed
                                  delay:0.5
                                options:UIViewAnimationOptionAllowUserInteraction
                             animations:^{
                                 for(int i=0; i<8-secondIndex; i++)
                                 {
                                     [self moveElementForThirdStep:secondIndex+i toIndex:newIndex+i];
                                 }
                             }
                             completion:^(BOOL finished) {
                                 // reset the tags
                                 for(int i=0; i<8; i++)
                                 {
                                     ElementLabel *eL = (ElementLabel*)[self.view viewWithTag:i+NEW_ELEMENT_BASE_TAG];
                                     eL.tag = i+ELEMENT_BASE_TAG;
                                 }
                                 
                                 [self enableControls:YES];
                             }];
        }
        else
        {
            [UIView animateWithDuration:animationSpeed
                                  delay:0.5
                                options:UIViewAnimationOptionAllowUserInteraction
                             animations:^{
                                 for(int i=0; i<4-firstIndex; i++)
                                 {
                                     [self moveElementForThirdStep:firstIndex+i toIndex:newIndex+i];
                                 }
                             }
                             completion:^(BOOL finished) {
                                 // reset the tags
                                 for(int i=0; i<8; i++)
                                 {
                                     ElementLabel *eL = (ElementLabel*)[self.view viewWithTag:i+NEW_ELEMENT_BASE_TAG];
                                     eL.tag = i+ELEMENT_BASE_TAG;
                                 }
                                 
                                 [self enableControls:YES];
                             }];
        }
    }
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

-(void)swapElementAtIndex:(NSUInteger)fromIndex with:(NSUInteger)toIndex
{
    NSUInteger fromTag = fromIndex + ELEMENT_BASE_TAG;
    ElementLabel *labelAtFromindex = (ElementLabel*)[self.view viewWithTag:fromTag];
    
    NSUInteger toTag = toIndex + ELEMENT_BASE_TAG;
    ElementLabel *labelAtToindex = (ElementLabel*)[self.view viewWithTag:toTag];
    
    CGRect fromIndexFrame = labelAtFromindex.frame;
    labelAtFromindex.frame = labelAtToindex.frame;
    labelAtToindex.frame = fromIndexFrame;
    
    labelAtFromindex.tag = toTag;
    labelAtToindex.tag = fromTag;
}

-(void)moveElementForSecondStep:(NSUInteger)index toIndex:(NSUInteger)newIndex
{
    NSUInteger tag = index + ELEMENT_BASE_TAG;
    ElementLabel *label = (ElementLabel*)[self.view viewWithTag:tag];
    label.tag = newIndex + NEW_ELEMENT_BASE_TAG;
    CGRect frame = IS_IPAD?ELEMENT_SECOND_ROW_FRAME:IS_IPHONE_5? ELEMENT_SECOND_ROW_FRAME_PHONE_5:ELEMENT_SECOND_ROW_FRAME_PHONE;
    frame.origin.x += newIndex<4?(newIndex*(IS_IPAD?70:40)):(newIndex*(IS_IPAD?70:40))+(IS_IPAD?65:32);
    label.frame = frame;
}

-(void)moveElementForThirdStep:(NSUInteger)index toIndex:(NSUInteger)newIndex
{
    NSUInteger tag = index + ELEMENT_BASE_TAG;
    ElementLabel *label = (ElementLabel*)[self.view viewWithTag:tag];
    label.tag = newIndex + NEW_ELEMENT_BASE_TAG;
    CGRect frame = IS_IPAD?ELEMENT_THIRD_ROW_FRAME:IS_IPHONE_5?ELEMENT_THIRD_ROW_FRAME_PHONE_5:ELEMENT_THIRD_ROW_FRAME_PHONE;
    frame.origin.x += newIndex*(IS_IPAD?70:40);
    label.frame = frame;
}

#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
