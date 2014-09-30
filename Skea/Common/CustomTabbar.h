#import <UIKit/UIKit.h>

@protocol CustomTabbarDelegate
@optional

- (void)didSelectedIndex:(int)index;
- (void)didDoubleTapIndex:(int)index;
@end

@interface CustomTabbar : UIView {
	
    __weak	id   delegate;


	NSArray  *imageNames;
	
	int      index_;
}

@property (strong,nonatomic) UILabel   *badgeLabel;
@property (nonatomic,weak) id <CustomTabbarDelegate> delegate;
@property (nonatomic, retain) NSArray *imageNames;

- (id)initWithCustom:(CGRect)frame imageNames:(NSArray*)names titles:(NSArray*)titles;

- (void) setIndex:(int)index;

- (void) selectNone;

- (void)setBadgeNum:(int)count;

- (int)getBadgeLabelNum;
@end
