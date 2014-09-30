
#import "CustomTabbar.h"


@implementation CustomTabbar
@synthesize delegate;
@synthesize imageNames;


- (id)initWithCustom:(CGRect)frame imageNames:(NSArray*)names titles:(NSArray*)titles{
	if ((self = [super initWithFrame:frame])) {
        // Initialization code
		self.backgroundColor = [UIColor whiteColor];
		//[self.layer setContents:(id)[[UIImage imageNamed:@"bottombar.png"] CGImage]];
		
		index_ = 0;
		
		float x = 1.0;
		float y = 0.0;
		float w = 320/3.0;
		float h = frame.size.height;
		
		int baseTag = 100;
		
		self.imageNames = names;
    
		for(int i = 0; i < [names count]; i++){
			NSString *normalName = [NSString stringWithFormat:@"%@.png",[names objectAtIndex:i]];
			NSString *downName = [NSString stringWithFormat:@"%@_s.png", [names objectAtIndex:i]];
			
			UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
			btn.frame = CGRectMake(x, y, w, h);
           // btn.contentEdgeInsets = UIEdgeInsetsMake(2,0,3,0);
            
            x+=w;
			
			btn.tag = baseTag+i;
			btn.exclusiveTouch = YES;
			[btn setImage:[UIImage imageNamed:normalName] forState:UIControlStateNormal];
			[btn setImage:[UIImage imageNamed:downName] forState:UIControlStateHighlighted];
			//btn.showsTouchWhenHighlighted = YES;
			[btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            if (i==1) {
                [btn addTarget:self action:@selector(buttonDoubleAction:) forControlEvents:UIControlEventTouchDownRepeat];
            }
			[self addSubview:btn];
	
		}
        ///增加了新消息的角标
        self.badgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(165, 2, 19, 19)];
        self.badgeLabel.backgroundColor = [UIColor redColor];
        self.badgeLabel.textColor = [UIColor whiteColor];
        self.badgeLabel.font = [UIFont CustomFontGBKSize:14];
        self.badgeLabel.layer.cornerRadius = 10;
        self.badgeLabel.layer.masksToBounds = YES;
        self.badgeLabel.textAlignment = NSTextAlignmentCenter;
		[self addSubview:self.badgeLabel];
        self.badgeLabel.hidden = YES;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		self.backgroundColor = [UIColor clearColor];
		index_ = 0;
    }
    return self;
}

- (void)setBadgeNum:(int)count
{
    self.badgeLabel.hidden = NO;
    self.badgeLabel.text = _S(@"%d",count);
    if (count>99) {
        self.badgeLabel.width = 33;
        self.badgeLabel.text = @"99+";
    }
    else if (count>9){
        self.badgeLabel.width = 25;
    }
    else if(count>0){
        self.badgeLabel.width = 19;
    }
    else{
        self.badgeLabel.hidden = YES;
    }
}
- (int)getBadgeLabelNum{
    if ([self.badgeLabel.text isEqualToString:@"99+"]) {
        return 100;
    }else{
        return [self.badgeLabel.text intValue];
    }
}

- (void) buttonAction:(id)sender{
	if([sender isKindOfClass:[UIButton class]]){
		
		UIButton *btn = sender;
		
		long itag = btn.tag;
		
		int index = itag-100;
		
		NSString *downName = [NSString stringWithFormat:@"%@_s.png",[imageNames objectAtIndex:index]];
		[btn setImage:[UIImage imageNamed:downName] forState:UIControlStateNormal];
		
		
		if(index_ > -1){
			if(index_+100 != itag){
				UIButton *btnPrev = (UIButton*)[self viewWithTag:index_+100];
				NSString *normalName = [NSString stringWithFormat:@"%@.png",[imageNames objectAtIndex:index_]];
				[btnPrev setImage:[UIImage imageNamed:normalName] forState:UIControlStateNormal];
			}
		}
		
		index_ = index;
		
		if(delegate && [delegate respondsToSelector:@selector(didSelectedIndex:)]){
			[delegate didSelectedIndex:index_];
		}
	}
}

- (void) setIndex:(int)index
{
	UIButton *btn = (UIButton*)[self viewWithTag:index+100];
	[self buttonAction:btn];
}

- (void) selectNone
{
	if(index_==-1)return;
	
	UIButton *btnPrev = (UIButton*)[self viewWithTag:index_+100];
	NSString *normalName = [NSString stringWithFormat:@"%@_s.png",[imageNames objectAtIndex:index_]];
	[btnPrev setImage:[UIImage imageNamed:normalName] forState:UIControlStateNormal];
	
	index_ = -1;
}


- (void)buttonDoubleAction:(id)sender
{
    UIButton *btn = sender;
    
    int itag = btn.tag;
    int index = itag-100;
    
    if (delegate && [delegate respondsToSelector:@selector(didDoubleTapIndex:)]) {
        [delegate didDoubleTapIndex:index];///目前只有联系人在用
    }
}



- (void)dealloc {
    imageNames = nil;
}


@end
