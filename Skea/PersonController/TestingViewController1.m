//
//  TestingViewController1.m
//  Skea
//
//  Created by yuyang on 14/11/15.
//  Copyright (c) 2014年 com.dlnu.*. All rights reserved.
//

#import "TestingViewController1.h"
#import "SkeaSliderButtonView.h"
#import "PersonLoginedViewController.h"
#import "SkeaUser.h"
#import "HealthTestViewController.h"

@interface TestingViewController1 ()<UITableViewDelegate,UITableViewDataSource,SkeaSliderButtonViewDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@end

@implementation TestingViewController1
{
    UITextField * _ageTextField;
    UITextField * _heightTextField;
    UITextField * _weightTextField;
    
    UIDatePicker * _ageDatePicker;
    UIPickerView * _heightPicker;
    UIPickerView * _weightPicker;
    
    NSMutableArray * _heightArray;
    NSMutableArray * _weightArray;
    NSString * _result;
    NSMutableDictionary * _resultDict;
    NSInteger _age;
    NSInteger _score;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _age = 34;
    _score = 0;
    
    _ageTextField = [[UITextField alloc] init];
    _heightTextField = [[UITextField alloc] init];
    _weightTextField = [[UITextField alloc] init];
    
    _heightPicker = [[UIPickerView alloc] init];
    _heightPicker.delegate = self;
    _heightPicker.dataSource = self;
    
    _weightPicker = [[UIPickerView alloc] init];
    _weightPicker.delegate = self;
    _weightPicker.dataSource = self;
    
    _resultDict = [[NSMutableDictionary alloc] init];
    [_resultDict setObject:@"NO" forKey:@"Seeing/Feeling Bulge"];
    [_resultDict setObject:@"NO" forKey:@"Menopausal Status"];
    [_resultDict setObject:@"0" forKey:@"Children"];
    [_resultDict setObject:@"NO" forKey:@"Smoking"];
    [_resultDict setObject:@"NO" forKey:@"Pelvic Floor Surgery"];
    [_resultDict setObject:@"NO" forKey:@"Current Heavy Work"];
    [_resultDict setObject:@"NO" forKey:@"Pelvic Floor Problems (POP or UI) during Gestation"];
    [_resultDict setObject:@"NO" forKey:@"Mother with POP or UI"];
    _result = [_resultDict JSONString];
    
    _heightArray = [[NSMutableArray alloc] init];
    for(int i=100;i<240;i++)
    {
        [_heightArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    _weightArray = [[NSMutableArray alloc] init];
    for(int i=30;i<120;i++)
    {
        [_weightArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    self.navigationItem.titleView = [[Theam currentTheam] navigationTitleViewWithTitle:NSLocalizedString(@"风险评估", nil)];
    if(!self._isRegisterPush)
        self.navigationItem.leftBarButtonItem = [[Theam currentTheam] navigationBarLeftButtonItemWithImage:IMG(@"menu_action_back_white.png") Title:nil Target:self Selector:@selector(btBack_DisModal:)];
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.view.frame.size.height - 40) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
        return 60.f;
    if(indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5)
        return 40.f;
    return 135.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellIdentifier = [NSString stringWithFormat:@"cell_%ld",(long)indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.backgroundColor = [UIColor colorWithRed:249/255.f green:249/255.f blue:249/255.f alpha:1.f];
        cell.contentView.backgroundColor = [UIColor colorWithRed:249/255.f green:249/255.f blue:249/255.f alpha:1.f];
    }
    if(indexPath.row == 0)
    {
        cell.textLabel.text = NSLocalizedString(@"请填写问卷以帮助评估您的盆底肌的健康风险", nil);
        [cell.textLabel setTextColor:[UIColor colorWithRed:139/255.f green:220/255.f blue:222/255.f alpha:1.f]];
        cell.textLabel.numberOfLines = 4;
        cell.textLabel.font = [UIFont systemFontOfSize:12.f];
    }
    if(indexPath.row == 1)
    {
        [cell.contentView addSubview:[self createTitleViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40.f) title:NSLocalizedString(@"基本信息", nil)]];
    }
    if(indexPath.row == 2)
    {
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake(10, 5, 100, 30);
        label.backgroundColor = [UIColor clearColor];
        label.text = NSLocalizedString(@"生日", nil);
        [cell.contentView addSubview:label];
        
        _ageTextField.frame = CGRectMake(10 + 100, 5, ScreenWidth - 10 - 100 - 10, 30);
        _ageTextField.textAlignment = NSTextAlignmentRight;
        _ageTextField.inputView = _ageDatePicker;
        _ageTextField.delegate = self;
        _ageTextField.text = [SkeaUser defaultUser].birthday.length?[SkeaUser defaultUser].birthday:@"1980-01-01";
        if([_ageTextField.text isEqualToString:@"1980-01-01"])
        {
            _age = 34;
        }
        _ageTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [cell.contentView addSubview:_ageTextField];
    }
    if(indexPath.row == 3)
    {
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake(10, 5, 100, 30);
        label.backgroundColor = [UIColor clearColor];
        label.text = NSLocalizedString(@"身高", nil);
        [cell.contentView addSubview:label];
        
        _heightTextField.frame = CGRectMake(10 + 100, 5, ScreenWidth - 10 - 100 - 10, 30);
        _heightTextField.textAlignment = NSTextAlignmentRight;
        _heightTextField.inputView = _heightPicker;
        _heightTextField.delegate = self;
//        _heightTextField.text = ![[SkeaUser defaultUser].height isEqualToString:@"0"]?[SkeaUser defaultUser].height:@"160cm";
        _heightTextField.text = @"160cm";
        _heightTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [cell.contentView addSubview:_heightTextField];
    }
    if(indexPath.row == 4)
    {
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake(10, 5, 100, 30);
        label.backgroundColor = [UIColor clearColor];
        label.text = NSLocalizedString(@"体重", nil);
        [cell.contentView addSubview:label];
        
        _weightTextField.frame = CGRectMake(10 + 100, 5, ScreenWidth - 10 - 100 - 10, 30);
        _weightTextField.textAlignment = NSTextAlignmentRight;
        _weightTextField.inputView = _weightPicker;
        _weightTextField.delegate = self;
//        _weightTextField.text = ![[SkeaUser defaultUser].weight isEqualToString:@"0"]?[SkeaUser defaultUser].weight:@"50kg";
        _weightTextField.text = @"50kg";
        _weightTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [cell.contentView addSubview:_weightTextField];
    }
    if(indexPath.row == 5)
    {
        [cell.contentView addSubview:[self createTitleViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40.f) title:NSLocalizedString(@"健康信息", nil)]];
    }
    if(indexPath.row == 6)
    {
        SkeaSliderButtonView * sview = [[SkeaSliderButtonView alloc] init];
        sview.frame = CGRectMake(0, 0, self.view.frame.size.width, 135);
        sview.tager = indexPath.row;
        sview.title = NSLocalizedString(@"看到或感到阴道有肿物脱出", nil);
        sview.selectedStringsArray = [NSArray arrayWithObjects:@"NO",@"YES", nil];
        sview.selectedIndex = 0;
        sview.delegate = self;
        sview.notice = NSLocalizedString(@"看到或感到阴道有肿物脱出，是评估盆底健康的重要相关信息", nil);
        [cell.contentView addSubview:sview];
    }
    if(indexPath.row == 7)
    {
        SkeaSliderButtonView * sview = [[SkeaSliderButtonView alloc] init];
        sview.frame = CGRectMake(0, 0, self.view.frame.size.width, 135);
        sview.tager = indexPath.row;
        sview.title = NSLocalizedString(@"目前绝经状态", nil);
        sview.selectedStringsArray = [NSArray arrayWithObjects:@"NO",@"YES", nil];
        sview.selectedIndex = 0;
        sview.delegate = self;
        sview.notice = NSLocalizedString(@"目前绝经状态，是评估盆底健康的重要相关信息", nil);
        [cell.contentView addSubview:sview];
    }
    if(indexPath.row == 8)
    {
        SkeaSliderButtonView * sview = [[SkeaSliderButtonView alloc] init];
        sview.frame = CGRectMake(0, 0, self.view.frame.size.width, 135);
        sview.tager = indexPath.row;
        sview.title = NSLocalizedString(@"生育数量", nil);
        sview.selectedStringsArray = [NSArray arrayWithObjects:@"0",@"1",@"2",@">=3", nil];
        sview.selectedIndex = 0;
        sview.delegate = self;
        sview.notice = NSLocalizedString(@"生育孩子的数量，是评估盆底健康的重要相关信息", nil);
        [cell.contentView addSubview:sview];
    }
    if(indexPath.row == 9)
    {
        SkeaSliderButtonView * sview = [[SkeaSliderButtonView alloc] init];
        sview.frame = CGRectMake(0, 0, self.view.frame.size.width, 135);
        sview.tager = indexPath.row;
        sview.title = NSLocalizedString(@"是否吸烟", nil);
        sview.selectedStringsArray = [NSArray arrayWithObjects:@"NO",@"YES", nil];
        sview.selectedIndex = 0;
        sview.delegate = self;
        sview.notice = NSLocalizedString(@"是否吸烟，是评估盆底健康的重要相关信息", nil);
        [cell.contentView addSubview:sview];
    }
    if(indexPath.row == 10)
    {
        SkeaSliderButtonView * sview = [[SkeaSliderButtonView alloc] init];
        sview.frame = CGRectMake(0, 0, self.view.frame.size.width, 135);
        sview.tager = indexPath.row;
        sview.title = NSLocalizedString(@"是否经历过盆底手术", nil);
        sview.selectedStringsArray = [NSArray arrayWithObjects:@"NO",@"YES", nil];
        sview.selectedIndex = 0;
        sview.delegate = self;
        sview.notice = NSLocalizedString(@"是否经历过盆底手术，是评估盆底健康的重要相关信息", nil);
        [cell.contentView addSubview:sview];
    }
    if(indexPath.row == 11)
    {
        SkeaSliderButtonView * sview = [[SkeaSliderButtonView alloc] init];
        sview.frame = CGRectMake(0, 0, self.view.frame.size.width, 135);
        sview.tager = indexPath.row;
        sview.title = NSLocalizedString(@"目前从事重体力劳动", nil);
        sview.selectedStringsArray = [NSArray arrayWithObjects:@"NO",@"YES", nil];
        sview.selectedIndex = 0;
        sview.delegate = self;
        sview.notice = NSLocalizedString(@"是否目前从事重体力劳动，是评估盆底健康的重要相关信息", nil);
        [cell.contentView addSubview:sview];
    }
    if(indexPath.row == 12)
    {
        SkeaSliderButtonView * sview = [[SkeaSliderButtonView alloc] init];
        sview.frame = CGRectMake(0, 0, self.view.frame.size.width, 135);
        sview.tager = indexPath.row;
        sview.title = NSLocalizedString(@"孕期有过盆底疾病", nil);
        sview.selectedStringsArray = [NSArray arrayWithObjects:@"NO",@"YES", nil];
        sview.selectedIndex = 0;
        sview.delegate = self;
        sview.notice = NSLocalizedString(@"是否在孕期有过盆底疾病？例如盆底器官脱垂或尿失禁", nil);
        [cell.contentView addSubview:sview];
    }
    if(indexPath.row == 13)
    {
        SkeaSliderButtonView * sview = [[SkeaSliderButtonView alloc] init];
        sview.frame = CGRectMake(0, 0, self.view.frame.size.width, 135);
        sview.tager = indexPath.row;
        sview.title = NSLocalizedString(@"母亲有过盆底疾病", nil);
        sview.selectedStringsArray = [NSArray arrayWithObjects:@"NO",@"YES", nil];
        sview.selectedIndex = 0;
        sview.delegate = self;
        sview.notice = NSLocalizedString(@"您的母亲是否有或有过盆底器官脱垂或尿失禁", nil);
        [cell.contentView addSubview:sview];
    }
    if(indexPath.row == 14)
    {
        UIButton * submitButtn = [UIButton buttonWithType:UIButtonTypeCustom];
        submitButtn.frame = CGRectMake(8, 30, self.view.frame.size.width - 16, 44);
        [submitButtn setBackgroundImage:[UIImage imageNamed:@"button-cyan.png"] forState:UIControlStateNormal];
        [submitButtn setTitle:NSLocalizedString(@"提交", nil) forState:UIControlStateNormal];
        [submitButtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [submitButtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:submitButtn];
    }
    return cell;
}

-(void)submit
{
    //    [self btBack_DisModal:nil];
    
    NSString * email = [SkeaUser defaultUser].email;
    NSString * birthday = _ageTextField.text;
    NSString * height = _heightTextField.text;
    NSString * weight = _weightTextField.text;
    NSString * date = [self stringFromDate:[NSDate date]];
    
    [self calculateScore];
    
    if(_score <= 60)
        [SkeaUser defaultUser].level = 1;
    else if (_score <= 90)
        [SkeaUser defaultUser].level = 2;
    else if (_score <= 120)
        [SkeaUser defaultUser].level = 3;
    else
        [SkeaUser defaultUser].level = 4;

    
    [SkeaUser defaultUser].selectLevel = 0;
    
#if 1
    
    
    IMP_BLOCK_SELF(TestingViewController1) //作为一个self的弱引用,在block里面调用
    
    showIndicator(YES, @"正在加载中");  ///弹一个正在加载的菊花
    ///path 在URL.h里面找对就的宏
    ///[@{@"email":email,@"password":pwd} mutableCopy] 这是一个要post内容的可扩展字面
    [[BaseEngine sharedEngine] RunRequest:[@{@"email":email,@"birthday":birthday,@"height":height,@"weight":weight,@"date":date,@"result":_result,@"score":[NSString stringWithFormat:@"%ld",_score]} mutableCopy] path:SK_SAVE_QUS completionHandler:^(id responseObject) {
        ///请求成功
        showCustomAlertMessage(@"提交成功");
        [SkeaUser defaultUser].birthday = _ageTextField.text;
        [SkeaUser defaultUser].weight = _weightTextField.text;
        [SkeaUser defaultUser].height = _heightTextField.text;
        if(self._isRegisterPush)
        {
            HealthTestViewController * pvc = [[HealthTestViewController alloc] init];
            pvc.isRegister = YES;
//            UINavigationController * nvc = [[UINavigationController alloc] initWithRootViewController:pvc];
            [block_self presentViewController:pvc animated:YES completion:nil];
        }
        else
        {
            [block_self btBack_DisModal:nil];
        }
        
        showIndicator(NO, nil);
        
    } errorHandler:^(NSError *error) {
        ///网络失败
        showAlertMessage(@"网络不给力");
        showIndicator(NO, nil);
    } finishHandler:^(id responseObject) {
        ///请求结束，如果请求返回的status不为100，判断如下
        showIndicator(NO, nil);
        if (responseObject!=nil) {
            int statusCode = [[responseObject objectForKey:@"status"] intValue];
            if (statusCode>100) {
                NSString *errMsg = @"服务器错误";
                switch (statusCode) {
                    case 101:
                        errMsg = @"参数错误";
                        break;
                    case 102:
                        errMsg = @"该用户已被注册";
                        break;
                    case 103:
                        errMsg = @"用户名或密码错误";
                        break;
                    case 104:
                        errMsg = @"结果未找到";
                        break;
                    default:
                        break;
                }
                showCustomAlertMessage(errMsg);
            }
        }
        
    }];
    
#endif
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    [[self.view viewWithTag:10086] removeFromSuperview];
    [[self.view viewWithTag:10087] removeFromSuperview];
    [[self.view viewWithTag:10088] removeFromSuperview];
    if(textField == _ageTextField)
    {
        UIView * view = [[UIView alloc] init];
        view.frame = CGRectMake(0, ScreenHeight - 216 - 40 - 64, ScreenWidth, 40 + 216);
        view.tag = 10086;
        view.backgroundColor = [UIColor whiteColor];
        view.userInteractionEnabled = YES;
        [self.view addSubview:view];
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(ScreenWidth - 50, 0, 50, 40);
        [btn setTitle:NSLocalizedString(@"确定", nil) forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:107/255.f green:201/255.f blue:222/255.f alpha:1.f] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(datePickerBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        
        UIView * line = [[UIView alloc] init];
        line.frame = CGRectMake(0, 39.5, view.frame.size.width, 0.5);
        line.backgroundColor = [UIColor grayColor];
        [view addSubview:line];
        
        _ageDatePicker = [ [ UIDatePicker alloc] initWithFrame:CGRectMake(0,40,ScreenWidth,216)];
        _ageDatePicker.backgroundColor = [UIColor whiteColor];
        _ageDatePicker.datePickerMode = UIDatePickerModeDate;
        _ageDatePicker.userInteractionEnabled = YES;
        NSDateFormatter *formatter_minDate = [[NSDateFormatter alloc] init];
        [formatter_minDate setDateFormat:@"yyyy-MM-dd"];
        NSDate *minDate = [formatter_minDate dateFromString:@"1940-01-01"];
        [_ageDatePicker setMinimumDate:minDate];
        [_ageDatePicker setMaximumDate:[NSDate date]];
        [_ageDatePicker setDate:[formatter_minDate dateFromString:@"1980-01-01"]];
//        _ageDatePicker.date = [NSDate dateWithString:@"1980-01-01"];
        [view addSubview:_ageDatePicker];
    }
    if(textField == _heightTextField)
    {
        UIView * view = [[UIView alloc] init];
        view.frame = CGRectMake(0, ScreenHeight - 216 - 40 - 64, ScreenWidth, 40 + 216);
        view.tag = 10087;
        view.backgroundColor = [UIColor whiteColor];
        view.userInteractionEnabled = YES;
        [self.view addSubview:view];
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(ScreenWidth - 50, 0, 50, 40);
        [btn setTitle:NSLocalizedString(@"确定", nil) forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:107/255.f green:201/255.f blue:222/255.f alpha:1.f] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(heightPickerBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        
        UIView * line = [[UIView alloc] init];
        line.frame = CGRectMake(0, 39.5, view.frame.size.width, 0.5);
        line.backgroundColor = [UIColor grayColor];
        [view addSubview:line];
        NSString * str = [NSString stringWithFormat:@"%ld",[[[_heightTextField.text componentsSeparatedByString:@"cm"] objectAtIndex:0] integerValue]];
        [_heightPicker selectRow:[_heightArray indexOfObject:str] inComponent:0 animated:YES];
        _heightPicker.frame = CGRectMake(0,40,ScreenWidth,216);
        _heightPicker.backgroundColor = [UIColor whiteColor];
        [view addSubview:_heightPicker];
    }
    if(textField == _weightTextField)
    {
        UIView * view = [[UIView alloc] init];
        view.frame = CGRectMake(0, ScreenHeight - 216 - 40 - 64, ScreenWidth, 40 + 216);
        view.tag = 10088;
        view.backgroundColor = [UIColor whiteColor];
        view.userInteractionEnabled = YES;
        [self.view addSubview:view];
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(ScreenWidth - 50, 0, 50, 40);
        [btn setTitle:NSLocalizedString(@"确定", nil) forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:107/255.f green:201/255.f blue:222/255.f alpha:1.f] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(weightPickerBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        
        UIView * line = [[UIView alloc] init];
        line.frame = CGRectMake(0, 39.5, view.frame.size.width, 0.5);
        line.backgroundColor = [UIColor grayColor];
        [view addSubview:line];
        
        NSString * str = [NSString stringWithFormat:@"%ld",[[[_weightTextField.text componentsSeparatedByString:@"kg"] objectAtIndex:0] integerValue]];
        [_weightPicker selectRow:[_weightArray indexOfObject:str] inComponent:0 animated:YES];
        _weightPicker.frame = CGRectMake(0,40,ScreenWidth,216);
        _weightPicker.backgroundColor = [UIColor whiteColor];
        [view addSubview:_weightPicker];
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(pickerView == _heightPicker)
        _heightTextField.text = [NSString stringWithFormat:@"%@cm",[_heightArray objectAtIndex:row]];
    if(pickerView == _weightPicker)
        _weightTextField.text = [NSString stringWithFormat:@"%@kg",[_weightArray objectAtIndex:row]];
    
    [self calculateScore];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(pickerView == _heightPicker)
        return _S(@"%dcm",[[_heightArray objectAtIndex:row] intValue]);
    return _S(@"%dkg",[[_weightArray objectAtIndex:row] intValue]);
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(pickerView == _heightPicker)
        return _heightArray.count;
    return _weightArray.count;
}

-(void)datePickerBtnClick
{
    _ageTextField.text = [self stringFromDate:_ageDatePicker.date];
    _age = [self fromDateToAge:_ageDatePicker.date];
    NSLog(@"%@",[self stringFromDate:_ageDatePicker.date]);
    [[self.view viewWithTag:10086] removeFromSuperview];
    [self calculateScore];
}

-(void)heightPickerBtnClick
{
    [[self.view viewWithTag:10087] removeFromSuperview];
}

-(void)weightPickerBtnClick
{
    [[self.view viewWithTag:10088] removeFromSuperview];
}

- (NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

-(UIImageView *)createTitleViewWithFrame:(CGRect)rect title:(NSString *)title
{
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.image = [UIImage imageNamed:@"title-background.png"];
    UILabel * label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.frame = CGRectMake(20, 0, imageView.frame.size.width - 20, imageView.frame.size.height);
    label.textColor = [UIColor blackColor];
    label.text = title.length?title:@"";
    [imageView addSubview:label];
    return imageView;
}

-(void)sliderClickWithTag:(NSInteger)tag index:(NSInteger)index
{
    NSLog(@"第%ld行，第%ld个按钮",tag,index);
    if(tag == 6)
    {
        [_resultDict setObject:[NSString stringWithFormat:@"%@",index?@"YES":@"NO"] forKey:@"Seeing/Feeling Bulge"];
    }
    
    if(tag == 7)
    {
        [_resultDict setObject:[NSString stringWithFormat:@"%@",index?@"YES":@"NO"] forKey:@"Menopausal Status"];
    }
    
    if(tag == 8)
    {
        [_resultDict setObject:[NSString stringWithFormat:@"%ld",index] forKey:@"Children"];
    }
    
    if(tag == 9)
    {
        [_resultDict setObject:[NSString stringWithFormat:@"%@",index?@"YES":@"NO"] forKey:@"Smoking"];
    }
    
    if(tag == 10)
    {
        [_resultDict setObject:[NSString stringWithFormat:@"%@",index?@"YES":@"NO"] forKey:@"Pelvic Floor Surgery"];
    }
    
    if(tag == 11)
    {
        [_resultDict setObject:[NSString stringWithFormat:@"%@",index?@"YES":@"NO"] forKey:@"Current Heavy Work"];
    }
    
    if(tag == 12)
    {
        [_resultDict setObject:[NSString stringWithFormat:@"%@",index?@"YES":@"NO"] forKey:@"Pelvic Floor Problems (POP or UI) during Gestation"];
    }
    
    if(tag == 13)
    {
        [_resultDict setObject:[NSString stringWithFormat:@"%@",index?@"YES":@"NO"] forKey:@"Mother with POP or UI"];
    }
    
    _result = [_resultDict JSONString];
    
    [self calculateScore];
    
}

-(void)calculateScore
{
    _score = 0;
    NSInteger BMI = [_weightTextField.text floatValue] / [_heightTextField.text floatValue] * [_heightTextField.text floatValue];
    _score += BMI;
    ////////////////////////////////////
    if(_age <= 49)
        _score+=0;
    else if (_age <= 54)
        _score += 3;
    else if (_age <= 59)
        _score += 6;
    else if (_age <= 64)
        _score += 9;
    else if (_age <= 69)
        _score += 13;
    else if (_age <= 74)
        _score += 16;
    else if (_age <= 79)
        _score += 19;
    else if (_age <= 84)
        _score += 22;
    else
        _score += 25;
    ////////////////////////////////////
    if([[_resultDict objectForKey:@"Seeing/Feeling Bulge"] isEqualToString:@"YES"])
        _score += 24;
    if([[_resultDict objectForKey:@"Menopausal Status"] isEqualToString:@"YES"])
        _score += 15;
    if([[_resultDict objectForKey:@"Children"] isEqualToString:@"0"])
        _score += 0;
    if([[_resultDict objectForKey:@"Children"] isEqualToString:@"1"])
        _score += 3;
    if([[_resultDict objectForKey:@"Children"] isEqualToString:@"2"])
        _score += 19;
    if([[_resultDict objectForKey:@"Children"] isEqualToString:@"3"])
        _score += 17;
    if([[_resultDict objectForKey:@"Smoking"] isEqualToString:@"YES"])
        _score += 8;
    if([[_resultDict objectForKey:@"Pelvic Floor Surgery"] isEqualToString:@"YES"])
        _score += 14;
    if([[_resultDict objectForKey:@"Current Heavy Work"] isEqualToString:@"YES"])
        _score += 8;
    if([[_resultDict objectForKey:@"Pelvic Floor Problems (POP or UI) during Gestation"] isEqualToString:@"YES"])
        _score += 6;
    if([[_resultDict objectForKey:@"Mother with POP or UI"] isEqualToString:@"YES"])
        _score += 12;
    
    [SkeaUser defaultUser].score = _score;
    NSLog(@"分数---->%ld",[SkeaUser defaultUser].score);
}

//计算年龄
-(NSInteger)fromDateToAge:(NSDate*)date
{
    NSDate *myDate = date;
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned int unitFlags = NSYearCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:myDate toDate:nowDate options:0];
    long year = [comps year];
    return year;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
