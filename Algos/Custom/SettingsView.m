//
//  SettingsView.m
//  aires
//
//  Created by Mani on 5/7/13.
//  Copyright (c) 2013 Imaginea. All rights reserved.
//

#import "SettingsView.h"
#import "Utils.h"
#include <netinet/in.h>
#import <SystemConfiguration/SCNetworkReachability.h>
#import <QuartzCore/QuartzCore.h>

@implementation SettingsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initControls];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self initControls];
}

-(void)initControls
{
    // Initialization code

    self.layer.cornerRadius = IS_IPAD?10.0f:5.0f;
    
    _messageLabel.alpha = 0;
    _messageLabel.transform = CGAffineTransformMakeScale(0, 0);
    
    _orangeButton.backgroundColor = ORANGE_COLOR;
    _blueButton.backgroundColor = BLUE_COLOR;
    _redButton.backgroundColor = RED_COLOR;
    _greenButton.backgroundColor = GREEN_COLOR;
    
    _loadingAnimationOn.layer.cornerRadius = 5.0f;
    _loadingAnimationOff.layer.cornerRadius = 5.0f;
    _orangeButton.layer.cornerRadius = 5.0f;
    _blueButton.layer.cornerRadius = 5.0f;
    _redButton.layer.cornerRadius = 5.0f;
    _greenButton.layer.cornerRadius = 5.0f;
    _emailButton.layer.cornerRadius = 5.0f;
    _rateButton.layer.cornerRadius = 5.0f;
    _tweetButton.layer.cornerRadius = 5.0f;
    _emailButton.layer.masksToBounds = YES;
    _rateButton.layer.masksToBounds = YES;
    _tweetButton.layer.masksToBounds = YES;
    
    UIImage *bgimage = [UIImage imageNamed:@"btn_highlighted.png"];
    bgimage = [bgimage stretchableImageWithLeftCapWidth:bgimage.size.width/2 topCapHeight:bgimage.size.height/2];
    [_emailButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_emailButton setBackgroundImage:bgimage forState:UIControlStateHighlighted];
    [_emailButton setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_rateButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_rateButton setBackgroundImage:bgimage forState:UIControlStateHighlighted];
    [_rateButton setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_tweetButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_tweetButton setBackgroundImage:bgimage forState:UIControlStateHighlighted];
    [_tweetButton setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    _loadingAnimationOn.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    _loadingAnimationOn.layer.shadowOffset = CGSizeMake(0, 10);
    _loadingAnimationOn.layer.shadowRadius = 10;
    _loadingAnimationOn.layer.shadowOpacity = 0;
    _loadingAnimationOn.layer.shadowPath = [UIBezierPath bezierPathWithRect:_orangeButton.bounds].CGPath;
    
    _loadingAnimationOff.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    _loadingAnimationOff.layer.shadowOffset = CGSizeMake(0, 10);
    _loadingAnimationOff.layer.shadowRadius = 10;
    _loadingAnimationOff.layer.shadowOpacity = 0;
    _loadingAnimationOff.layer.shadowPath = [UIBezierPath bezierPathWithRect:_orangeButton.bounds].CGPath;
    
    _orangeButton.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    _orangeButton.layer.shadowOffset = CGSizeMake(0, 10);
    _orangeButton.layer.shadowRadius = 10;
    _orangeButton.layer.shadowOpacity = 0;
    _orangeButton.layer.shadowPath = [UIBezierPath bezierPathWithRect:_orangeButton.bounds].CGPath;
    
    _blueButton.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    _blueButton.layer.shadowOffset = CGSizeMake(0, 10);
    _blueButton.layer.shadowRadius = 10;
    _blueButton.layer.shadowOpacity = 0;
    _blueButton.layer.shadowPath = [UIBezierPath bezierPathWithRect:_blueButton.bounds].CGPath;
    
    _redButton.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    _redButton.layer.shadowOffset = CGSizeMake(0, 10);
    _redButton.layer.shadowRadius = 10;
    _redButton.layer.shadowOpacity = 0;
    _redButton.layer.shadowPath = [UIBezierPath bezierPathWithRect:_redButton.bounds].CGPath;
    
    _greenButton.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    _greenButton.layer.shadowOffset = CGSizeMake(0, 10);
    _greenButton.layer.shadowRadius = 10;
    _greenButton.layer.shadowOpacity = 0;
    _greenButton.layer.shadowPath = [UIBezierPath bezierPathWithRect:_greenButton.bounds].CGPath;
    
    [self updateTheme];
}

-(void)updateTheme
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSUInteger theme = [defaults integerForKey:THEME_KEY];
    
    _orangeButton.layer.shadowOpacity = 0;
    _blueButton.layer.shadowOpacity = 0;
    _redButton.layer.shadowOpacity = 0;
    _greenButton.layer.shadowOpacity = 0;
    
    UIColor *color = ORANGE_COLOR;
    if(theme == THEME_ORANGE)
    {
        color = ORANGE_COLOR;
        [UIView animateWithDuration:0.2
                         animations:^{
                             _orangeButton.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                             _blueButton.transform = CGAffineTransformMakeScale(0.75f, 0.75f);
                             _redButton.transform = CGAffineTransformMakeScale(0.75f, 0.75f);
                             _greenButton.transform = CGAffineTransformMakeScale(0.75f, 0.75f);
                             _orangeButton.layer.shadowOpacity = 1.0f;
                         }];
    }
    else if(theme == THEME_BLUE)
    {
        color = BLUE_COLOR;
        [UIView animateWithDuration:0.2
                         animations:^{
                             _blueButton.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                             _orangeButton.transform = CGAffineTransformMakeScale(0.75f, 0.75f);
                             _redButton.transform = CGAffineTransformMakeScale(0.75f, 0.75f);
                             _greenButton.transform = CGAffineTransformMakeScale(0.75f, 0.75f);
                             _blueButton.layer.shadowOpacity = 1.0f;
                         }];
    }
    else if(theme == THEME_RED)
    {
        color = RED_COLOR;
        [UIView animateWithDuration:0.2
                         animations:^{
                             _redButton.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                             _orangeButton.transform = CGAffineTransformMakeScale(0.75f, 0.75f);
                             _blueButton.transform = CGAffineTransformMakeScale(0.75f, 0.75f);
                             _greenButton.transform = CGAffineTransformMakeScale(0.75f, 0.75f);
                             _redButton.layer.shadowOpacity = 1.0f;
                         }];
    }
    else if(theme == THEME_GREEN)
    {
        color = GREEN_COLOR;
        [UIView animateWithDuration:0.2
                         animations:^{
                             _greenButton.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                             _orangeButton.transform = CGAffineTransformMakeScale(0.75f, 0.75f);
                             _blueButton.transform = CGAffineTransformMakeScale(0.75f, 0.75f);
                             _redButton.transform = CGAffineTransformMakeScale(0.75f, 0.75f);
                             _greenButton.layer.shadowOpacity = 1.0f;
                         }];
    }
    else
    {
        // new colors
    }
    
    _loadingAnimationOn.layer.shadowOpacity = 0;
    _loadingAnimationOff.layer.shadowOpacity = 0;
    
    if([Utils shouldShowLoadingAnimation])
    {
        [UIView animateWithDuration:0.2
                         animations:^{
                             _loadingAnimationOn.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                             _loadingAnimationOff.transform = CGAffineTransformMakeScale(0.75f, 0.75f);
                             _loadingAnimationOn.layer.shadowOpacity = 1.0f;
                         }];
    }
    else
    {
        [UIView animateWithDuration:0.2
                         animations:^{
                             _loadingAnimationOff.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                             _loadingAnimationOn.transform = CGAffineTransformMakeScale(0.75f, 0.75f);
                             _loadingAnimationOff.layer.shadowOpacity = 1.0f;
                         }];
    }
    
    /*CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha =0.0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    self.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:0.25f];*/
}

-(IBAction)animationOnPressed:(id)sender
{
    _loadingAnimationOn.layer.shadowOpacity = 0;
    _loadingAnimationOff.layer.shadowOpacity = 0;
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         _loadingAnimationOn.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                         _loadingAnimationOff.transform = CGAffineTransformMakeScale(0.75f, 0.75f);
                         _loadingAnimationOn.layer.shadowOpacity = 1.0f;
                     }];
    
    [Utils showLoadingAnimation:YES];
}

-(IBAction)animationOffPressed:(id)sender
{
    _loadingAnimationOn.layer.shadowOpacity = 0;
    _loadingAnimationOff.layer.shadowOpacity = 0;
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         _loadingAnimationOff.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                         _loadingAnimationOn.transform = CGAffineTransformMakeScale(0.75f, 0.75f);
                         _loadingAnimationOff.layer.shadowOpacity = 1.0f;
                     }];
    
    [Utils showLoadingAnimation:NO];
}

-(IBAction)orangeButtonPressed:(id)sender
{
    [Utils setThemeColor:THEME_ORANGE];
    [self updateTheme];
    if(_delegate && [_delegate respondsToSelector:@selector(themeChanged)])
    {
        [_delegate themeChanged];
    }
}

-(IBAction)blueButtonPressed:(id)sender
{
    [Utils setThemeColor:THEME_BLUE];
    [self updateTheme];
    if(_delegate && [_delegate respondsToSelector:@selector(themeChanged)])
    {
        [_delegate themeChanged];
    }
}

-(IBAction)redButtonPressed:(id)sender
{
    [Utils setThemeColor:THEME_RED];
    [self updateTheme];
    if(_delegate && [_delegate respondsToSelector:@selector(themeChanged)])
    {
        [_delegate themeChanged];
    }
}

-(IBAction)greenButtonPressed:(id)sender
{
    [Utils setThemeColor:THEME_GREEN];
    [self updateTheme];
    if(_delegate && [_delegate respondsToSelector:@selector(themeChanged)])
    {
        [_delegate themeChanged];
    }
}

-(IBAction)emailPressed:(id)sender
{
    if([SettingsView isConnectedToNetwork])
    {
        if([MFMailComposeViewController canSendMail])
        {
            if(_delegate && [_delegate respondsToSelector:@selector(sendEmail)])
            {
                [_delegate sendEmail];
            }
        }
        else
        {
            _messageLabel.text = @"Email account not configured!";
            [self showAlertMessage];
        }
    }
    else
    {
        _messageLabel.text = @"Network not available!";
        [self showAlertMessage];
    }
}

-(IBAction)ratePressed:(id)sender
{
    if([SettingsView isConnectedToNetwork])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms://itunes.com/apps/toonic"]];
    }
    else
    {
        _messageLabel.text = @"Network not available!";
        [self showAlertMessage];
    }
}

-(IBAction)tweetPressed:(id)sender
{
    if([SettingsView isConnectedToNetwork])
    {
        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
        {
            if(_delegate && [_delegate respondsToSelector:@selector(tweet)])
            {
                [_delegate tweet];
            }
        }
        else
        {
            _messageLabel.text = @"Twitter account not configured!";
            [self showAlertMessage];
        }
    }
    else
    {
        _messageLabel.text = @"Network not available!";
        [self showAlertMessage];
    }
}

-(void)showAlertMessage
{
    _emailButton.userInteractionEnabled = NO;
    _rateButton.userInteractionEnabled = NO;
    _tweetButton.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.2f
                     animations:^{
                         _spreadUsLabel.frame = CGRectOffset(_spreadUsLabel.frame, 0, IS_IPAD?-20:-15);
                         _messageLabel.alpha = 1.0f;
                         _messageLabel.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.2f
                                               delay:1.0f
                                             options:UIViewAnimationOptionBeginFromCurrentState
                                          animations:^{
                                              _spreadUsLabel.frame = CGRectOffset(_spreadUsLabel.frame, 0, IS_IPAD?20:15);
                                              _messageLabel.alpha = 0;
                                              _messageLabel.transform = CGAffineTransformMakeScale(0, 0);
                                          }
                                          completion:^(BOOL finished) {
                                              _emailButton.userInteractionEnabled = YES;
                                              _rateButton.userInteractionEnabled = YES;
                                              _tweetButton.userInteractionEnabled = YES;
                                          }];
                     }];
}

+ (BOOL)isConnectedToNetwork
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr*)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    if (!didRetrieveFlags)
    {
        NSLog(@"Error. Could not recover network reachability flags");
        return 0;
    }
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    
    BOOL nonWiFi = flags & kSCNetworkReachabilityFlagsTransientConnection;
    NSURL *testURL = [NSURL URLWithString:@"http://www.apple.com/"];
    NSURLRequest *testRequest = [NSURLRequest requestWithURL:testURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20.0];
    NSURLConnection *testConnection = [[NSURLConnection alloc] initWithRequest:testRequest delegate:nil];
    
    return ((isReachable && !needsConnection) || nonWiFi) ? (testConnection ? YES : NO) : NO;
}

@end
