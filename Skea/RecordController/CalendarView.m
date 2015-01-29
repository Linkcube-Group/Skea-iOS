
#import "CalendarView.h"

@interface CalendarView()

{
    
    NSCalendar *gregorian;
    NSInteger _selectedMonth;
    NSInteger _selectedYear;
}

@property (strong,nonatomic) NSArray *aryRecords;

@end
@implementation CalendarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.aryRecords = [AppConfig getGameRecodeDates];
//        UISwipeGestureRecognizer * swipeleft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeleft:)];
//        swipeleft.direction=UISwipeGestureRecognizerDirectionLeft;
//        [self addGestureRecognizer:swipeleft];
//        UISwipeGestureRecognizer * swipeRight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swiperight:)];
//        swipeRight.direction=UISwipeGestureRecognizerDirectionRight;
//        [self addGestureRecognizer:swipeRight];
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.size.height-100, self.bounds.size.width, 44)];
//        [label setBackgroundColor:[UIColor colorWithHexString:@"#6CC9DF"]];
//        [label setTextColor:[UIColor whiteColor]];
//        [label setText:@"swipe to change months"];
//        label.textAlignment = NSTextAlignmentCenter;
//        [self addSubview:label];
//        [UILabel beginAnimations:NULL context:nil];
//        [UILabel setAnimationDuration:2.0];
//        [label setAlpha:0];
//        [UILabel commitAnimations];
        
        
        
    }
    return self;
}

- (void)cancelAction:(id)sender
{
    self.hidden = YES;
}

- (void)drawRect:(CGRect)rect
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setTitle:@"<" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor colorWithHexString:@"#6CC9DF"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(7,0,70,45);
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:30];
    [leftBtn addTarget:self action:@selector(swiperight:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftBtn];
    
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@">" forState:UIControlStateNormal];
     [rightBtn setTitleColor:[UIColor colorWithHexString:@"#6CC9DF"] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(theApp.window.width-75,0,70,45);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:30];
    [rightBtn addTarget:self action:@selector(swipeleft:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightBtn];
    
    
    [self setCalendarParameters];
    _weekNames = @[@"Mo",@"Tu",@"We",@"Th",@"Fr",@"Sa",@"Su"];
    NSDateComponents *components = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
//    _selectedDate  =components.day;
    components.day = 1;
    NSDate *firstDayOfMonth = [gregorian dateFromComponents:components];
    NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:firstDayOfMonth];
    int weekday = (int)[comps weekday];
//      NSLog(@"components%d %d %d",_selectedDate,_selectedMonth,_selectedYear);
    weekday  = weekday - 2;
    
    if(weekday < 0)
        weekday += 7;
    
    NSCalendar *c = [NSCalendar currentCalendar];
    NSRange days = [c rangeOfUnit:NSDayCalendarUnit
                           inUnit:NSMonthCalendarUnit
                          forDate:self.calendarDate];
    
    NSInteger columns = 7;
    NSInteger width = 40;
    NSInteger originX = 20;
    NSInteger originY = 30;
    NSInteger monthLength = days.length;
    
    UILabel *titleText = [[UILabel alloc]initWithFrame:CGRectMake(0,5, self.bounds.size.width, 40)];
    titleText.textAlignment = NSTextAlignmentCenter;
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM"];
    NSString *dateString = [[format stringFromDate:self.calendarDate] uppercaseString];
    [titleText setText:dateString];
    [titleText setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15.0f]];
    [titleText setTextColor:[UIColor colorWithHexString:@"#6CC9DF"]];
    [self addSubview:titleText];
    
    for (int i =0; i<_weekNames.count; i++) {
        UIButton *weekNameLabel = [UIButton buttonWithType:UIButtonTypeCustom];
        weekNameLabel.titleLabel.text = [_weekNames objectAtIndex:i];
        [weekNameLabel setTitle:[_weekNames objectAtIndex:i] forState:UIControlStateNormal];
        [weekNameLabel setFrame:CGRectMake(originX+(width*(i%columns)), originY, width, width)];
        [weekNameLabel setTitleColor:[UIColor colorWithHexString:@"#6CC9DF"] forState:UIControlStateNormal];
        [weekNameLabel.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:15.0f]];
        weekNameLabel.userInteractionEnabled = NO;
        [self addSubview:weekNameLabel];
    }
    

    for (NSInteger i= 0; i<monthLength; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i+1;
        button.titleLabel.text = [NSString stringWithFormat:@"%d",(int)i+1];
        [button setTitle:[NSString stringWithFormat:@"%d",(int)i+1] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"#6CC9DF"] forState:UIControlStateHighlighted];
        [button.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:15.0f]];
        [button addTarget:self action:@selector(tappedDate:) forControlEvents:UIControlEventTouchUpInside];
        NSInteger offsetX = (width*((i+weekday)%columns));
        NSInteger offsetY = (width *((i+weekday)/columns));
        [button setFrame:CGRectMake(originX+offsetX, originY+40+offsetY, width, width)];
        [button.layer setBorderColor:[[UIColor colorWithHexString:@"#6CC9DF"] CGColor]];
        [button.layer setBorderWidth:2.0];
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#6CC9DF"];
        if(((i+weekday)/columns)==0)
        {
            [lineView setFrame:CGRectMake(0, 0, button.frame.size.width, 4)];
            [button addSubview:lineView];
        }

        if(((i+weekday)/columns)==((monthLength+weekday-1)/columns))
        {
            [lineView setFrame:CGRectMake(0, button.frame.size.width-4, button.frame.size.width, 4)];
            [button addSubview:lineView];
        }
        
//        UIView *columnView = [[UIView alloc]init];
//        [columnView setBackgroundColor:[UIColor colorWithHexString:@"#6CC9DF"]];
//        if((i+weekday)%7==0)
//        {
//            [columnView setFrame:CGRectMake(0, 0, 4, button.frame.size.width)];
//            [button addSubview:columnView];
//        }
//        else if((i+weekday)%7==6)
//        {
//            [columnView setFrame:CGRectMake(button.frame.size.width-4, 0, 4, button.frame.size.width)];
//            [button addSubview:columnView];
//        }
        if ([self hasRecordDay:(int)i+1 :(int)components.month :(int)components.year]) {
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor colorWithHexString:@"#6CC9DF"]];
           
        }
        if(i+1 ==_selectedDate && components.month == _selectedMonth && components.year == _selectedYear)
        {
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        
        [self addSubview:button];
    }
    
    NSDateComponents *previousMonthComponents = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
    previousMonthComponents.month -=1;
    NSDate *previousMonthDate = [gregorian dateFromComponents:previousMonthComponents];
    NSRange previousMonthDays = [c rangeOfUnit:NSDayCalendarUnit
                   inUnit:NSMonthCalendarUnit
                  forDate:previousMonthDate];
    NSInteger maxDate = previousMonthDays.length - weekday;
    
    
    for (int i=0; i<weekday; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.text = [NSString stringWithFormat:@"%d",(int)maxDate+i+1];
        [button setTitle:[NSString stringWithFormat:@"%d",(int)maxDate+i+1] forState:UIControlStateNormal];
        NSInteger offsetX = (width*(i%columns));
        NSInteger offsetY = (width *(i/columns));
        [button setFrame:CGRectMake(originX+offsetX, originY+40+offsetY, width, width)];
        [button.layer setBorderWidth:2.0];
        [button.layer setBorderColor:[[UIColor colorWithHexString:@"#6CC9DF"] CGColor]];
        UIView *columnView = [[UIView alloc]init];
        [columnView setBackgroundColor:[UIColor colorWithHexString:@"#6CC9DF"]];
        if(i==0)
        {
            [columnView setFrame:CGRectMake(0, 0, 4, button.frame.size.width)];
            [button addSubview:columnView];
        }

        UIView *lineView = [[UIView alloc]init];
        [lineView setBackgroundColor:[UIColor colorWithHexString:@"#6CC9DF"]];
        [lineView setFrame:CGRectMake(0, 0, button.frame.size.width, 4)];
        [button addSubview:lineView];
        [button setTitleColor:[UIColor colorWithRed:229.0/255.0 green:231.0/255.0 blue:233.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:15.0f]];
        [button setEnabled:NO];
        [self addSubview:button];
    }
    
    NSInteger remainingDays = (monthLength + weekday) % columns;
    if(remainingDays >0){
        for (int i=(int)remainingDays; i<columns; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.titleLabel.text = [NSString stringWithFormat:@"%d",(i+1)-(int)remainingDays];
            [button setTitle:[NSString stringWithFormat:@"%d",(i+1)-(int)remainingDays] forState:UIControlStateNormal];
            NSInteger offsetX = (width*((i) %columns));
            NSInteger offsetY = (width *((monthLength+weekday)/columns));
            [button setFrame:CGRectMake(originX+offsetX, originY+40+offsetY, width, width)];
            [button.layer setBorderWidth:2.0];
            [button.layer setBorderColor:[[UIColor colorWithHexString:@"#6CC9DF"] CGColor]];
            UIView *columnView = [[UIView alloc]init];
            [columnView setBackgroundColor:[UIColor colorWithHexString:@"#6CC9DF"]];
            if(i==columns - 1)
            {
                [columnView setFrame:CGRectMake(button.frame.size.width-4, 0, 4, button.frame.size.width)];
                [button addSubview:columnView];
            }
            UIView *lineView = [[UIView alloc]init];
            [lineView setBackgroundColor:[UIColor colorWithHexString:@"#6CC9DF"]];
            [lineView setFrame:CGRectMake(0, button.frame.size.width-4, button.frame.size.width, 4)];
            [button addSubview:lineView];
            [button setTitleColor:[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:15.0f]];
            [button setEnabled:NO];
            [self addSubview:button];

        }
    }

}
-(IBAction)tappedDate:(UIButton *)sender
{
    gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
    if(!(_selectedDate == sender.tag && _selectedMonth == [components month] && _selectedYear == [components year]))
    {
//        if(_selectedDate != -1)
//        {
//            UIButton *previousSelected =(UIButton *) [self viewWithTag:_selectedDate];
//            [previousSelected setBackgroundColor:[UIColor clearColor]];
//            [previousSelected setTitleColor:[UIColor colorWithHexString:@"#6CC9DF"] forState:UIControlStateNormal];
//            
//        }
//        
//        [sender setBackgroundColor:[UIColor colorWithHexString:@"#6CC9DF"]];
//        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _selectedDate = sender.tag;
        NSDateComponents *components = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
        components.day = _selectedDate;
        _selectedMonth = components.month;
        _selectedYear = components.year;
        NSDate *clickedDate = [gregorian dateFromComponents:components];
        [self.delegate tappedOnDate:clickedDate];
    }
}

-(void)swipeleft:(UISwipeGestureRecognizer*)gestureRecognizer
{
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSDateComponents *components = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
    components.day = 1;
    components.month += 1;
    self.calendarDate = [gregorian dateFromComponents:components];
    [UIView transitionWithView:self
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^ { [self setNeedsDisplay]; }
                    completion:nil];
    
    
}

-(void)swiperight:(UISwipeGestureRecognizer*)gestureRecognizer
{
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSDateComponents *components = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
    components.day = 1;
    components.month -= 1;
    self.calendarDate = [gregorian dateFromComponents:components];
    [UIView transitionWithView:self
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^ { [self setNeedsDisplay]; }
                    completion:nil];
}
-(void)setCalendarParameters
{
    if(gregorian == nil)
    {
        gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *components = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
        _selectedDate  = components.day;
        _selectedMonth = components.month;
        _selectedYear = components.year;
    }
}

- (BOOL)hasRecordDay:(int)day :(int)month :(int)year
{
    __block BOOL flag = NO;
    NSString *compareStr = _S(@"%d-%02d-%02d",year,month,day);
    if (self.aryRecords && [self.aryRecords count]>0) {
        if ([self.aryRecords containsString:compareStr]) {
            return YES;
        }
//        NSDate *drayDay = [NSDate dateWithString:_S(@"%d%02d%02d",year,month,day) Format:@"yyyyMMdd"];
//        
//        [self.aryRecords enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL *stop) {
//           
//            if (abs((int)[drayDay timeIntervalSince1970]/(24*60*60)-[obj intValue])<1) {
//                flag = YES;
//                *stop = YES;
//            }
//        }];
        
    }
  
    return flag;
}


@end
