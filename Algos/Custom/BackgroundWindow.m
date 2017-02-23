#import "BackgroundWindow.h"

@implementation BackgroundWindow

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        image = [UIImage imageNamed:@"wp.jpg"];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [image drawInRect:rect];
}

@end
