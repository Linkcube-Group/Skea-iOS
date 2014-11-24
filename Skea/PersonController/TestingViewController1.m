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
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    [_resultDict setObject:@"no" forKey:@"Seeing/Feeling Bulge"];
    [_resultDict setObject:@"no" forKey:@"Menopausal Status"];
    [_resultDict setObject:@"0" forKey:@"Children"];
    [_resultDict setObject:@"no" forKey:@"Smoking"];
    [_resultDict setObject:@"no" forKey:@"Pelvic Floor Surgery"];
    [_resultDict setObject:@"no" forKey:@"Current Heavy Work"];
    [_resultDict setObject:@"no" forKey:@"Pelvic Floor Problems (POP or UI) during Gestation"];
    [_resultDict setObject:@"no" forKey:@"Mother with POP or UI"];
    _result = [_resultDict JSONString];
    
    _heightArray = [[NSMutableArray alloc] init];
    for(int i=150;i<250;i++)
    {
        [_heightArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    _weightArray = [[NSMutableArray alloc] init];
    for(int i=60;i<300;i++)
    {
        [_weightArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    self.navigationItem.titleView = [[Theam currentTheam] navigationTitleViewWithTitle:@"Risk Evaluation"];
    self.navigationItem.leftBarButtonItem = [[Theam currentTheam] navigationBarLeftButtonItemWithImage:IMG(@"menu_action_back_white.png") Title:nil Target:self Selector:@selector(btBack_DisModal:)];
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.view.frame.size.height - 40) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
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
        cell.textLabel.text = @"Please fill in the questionnaire in order that we can evaluate the health risk of your pelvic floor muscle.";
        [cell.textLabel setTextColor:[UIColor colorWithRed:139/255.f green:220/255.f blue:222/255.f alpha:1.f]];
        cell.textLabel.numberOfLines = 4;
        cell.textLabel.font = [UIFont systemFontOfSize:12.f];
    }
    if(indexPath.row == 1)
    {
        [cell.contentView addSubview:[self createTitleViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40.f) title:@"Basic information"]];
    }
    if(indexPath.row == 2)
    {
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake(10, 5, 60, 30);
        label.backgroundColor = [UIColor clearColor];
        label.text = NSLocalizedString(@"生日", nil);
        [cell.contentView addSubview:label];
        
        _ageTextField.frame = CGRectMake(10 + 60, 5, ScreenWidth - 10 - 60 - 10, 30);
        _ageTextField.textAlignment = NSTextAlignmentRight;
        _ageTextField.inputView = _ageDatePicker;
        _ageTextField.delegate = self;
        _ageTextField.text = [SkeaUser defaultUser].birthday.length?[SkeaUser defaultUser].birthday:@"1980-01-01";
        _ageTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [cell.contentView addSubview:_ageTextField];
    }
    if(indexPath.row == 3)
    {
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake(10, 5, 60, 30);
        label.backgroundColor = [UIColor clearColor];
        label.text = NSLocalizedString(@"身高", nil);
        [cell.contentView addSubview:label];
        
        _heightTextField.frame = CGRectMake(10 + 60, 5, ScreenWidth - 10 - 60 - 10, 30);
        _heightTextField.textAlignment = NSTextAlignmentRight;
        _heightTextField.inputView = _heightPicker;
        _heightTextField.delegate = self;
        _heightTextField.text = [SkeaUser defaultUser].height.length?[SkeaUser defaultUser].height:@"180";
        _heightTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [cell.contentView addSubview:_heightTextField];
    }
    if(indexPath.row == 4)
    {
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake(10, 5, 60, 30);
        label.backgroundColor = [UIColor clearColor];
        label.text = NSLocalizedString(@"体重", nil);
        [cell.contentView addSubview:label];
        
        _weightTextField.frame = CGRectMake(10 + 60, 5, ScreenWidth - 10 - 60 - 10, 30);
        _weightTextField.textAlignment = NSTextAlignmentRight;
        _weightTextField.inputView = _weightPicker;
        _weightTextField.delegate = self;
        _weightTextField.text = [SkeaUser defaultUser].weight.length?[SkeaUser defaultUser].weight:@"60";
        _weightTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [cell.contentView addSubview:_weightTextField];
    }
    if(indexPath.row == 5)
    {
        [cell.contentView addSubview:[self createTitleViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40.f) title:@"Health information"]];
    }
    if(indexPath.row == 6)
    {
        SkeaSliderButtonView * sview = [[SkeaSliderButtonView alloc] init];
        sview.frame = CGRectMake(0, 0, self.view.frame.size.width, 135);
        sview.tager = indexPath.row;
        sview.title = @"Seeing/Feeling Bulge";
        sview.selectedStringsArray = [NSArray arrayWithObjects:@"yes",@"no", nil];
        sview.selectedIndex = 1;
        sview.delegate = self;
        sview.notice = @"Sexual activity is a key variable related to the risk factor of pelvic floor muscle dysfunction.";
        [cell.contentView addSubview:sview];
    }
    if(indexPath.row == 7)
    {
        SkeaSliderButtonView * sview = [[SkeaSliderButtonView alloc] init];
        sview.frame = CGRectMake(0, 0, self.view.frame.size.width, 135);
        sview.tager = indexPath.row;
        sview.title = @"Menopausal Status";
        sview.selectedStringsArray = [NSArray arrayWithObjects:@"(Pre) menopausal",@"Postmenopausal", nil];
        sview.selectedIndex = 0;
        sview.delegate = self;
        sview.notice = @"Sexual activity is a key variable related to the risk factor of pelvic floor muscle dysfunction.";
        [cell.contentView addSubview:sview];
    }
    if(indexPath.row == 8)
    {
        SkeaSliderButtonView * sview = [[SkeaSliderButtonView alloc] init];
        sview.frame = CGRectMake(0, 0, self.view.frame.size.width, 135);
        sview.tager = indexPath.row;
        sview.title = @"Children";
        sview.selectedStringsArray = [NSArray arrayWithObjects:@"0",@"1",@"2",@">=3", nil];
        sview.selectedIndex = 0;
        sview.delegate = self;
        sview.notice = @"Sexual activity is a key variable related to the risk factor of pelvic floor muscle dysfunction.";
        [cell.contentView addSubview:sview];
    }
    if(indexPath.row == 9)
    {
        SkeaSliderButtonView * sview = [[SkeaSliderButtonView alloc] init];
        sview.frame = CGRectMake(0, 0, self.view.frame.size.width, 135);
        sview.tager = indexPath.row;
        sview.title = @"Smoking";
        sview.selectedStringsArray = [NSArray arrayWithObjects:@"yes",@"no", nil];
        sview.selectedIndex = 1;
        sview.delegate = self;
        sview.notice = @"Sexual activity is a key variable related to the risk factor of pelvic floor muscle dysfunction.";
        [cell.contentView addSubview:sview];
    }
    if(indexPath.row == 10)
    {
        SkeaSliderButtonView * sview = [[SkeaSliderButtonView alloc] init];
        sview.frame = CGRectMake(0, 0, self.view.frame.size.width, 135);
        sview.tager = indexPath.row;
        sview.title = @"Pelvic Floor Surgery";
        sview.selectedStringsArray = [NSArray arrayWithObjects:@"yes",@"no", nil];
        sview.selectedIndex = 1;
        sview.delegate = self;
        sview.notice = @"Sexual activity is a key variable related to the risk factor of pelvic floor muscle dysfunction.";
        [cell.contentView addSubview:sview];
    }
    if(indexPath.row == 11)
    {
        SkeaSliderButtonView * sview = [[SkeaSliderButtonView alloc] init];
        sview.frame = CGRectMake(0, 0, self.view.frame.size.width, 135);
        sview.tager = indexPath.row;
        sview.title = @"Current Heavy Work";
        sview.selectedStringsArray = [NSArray arrayWithObjects:@"yes",@"no", nil];
        sview.selectedIndex = 1;
        sview.delegate = self;
        sview.notice = @"Sexual activity is a key variable related to the risk factor of pelvic floor muscle dysfunction.";
        [cell.contentView addSubview:sview];
    }
    if(indexPath.row == 12)
    {
        SkeaSliderButtonView * sview = [[SkeaSliderButtonView alloc] init];
        sview.frame = CGRectMake(0, 0, self.view.frame.size.width, 135);
        sview.tager = indexPath.row;
        sview.title = @"Pelvic Floor Problems (POP or UI) during Gestation";
        sview.selectedStringsArray = [NSArray arrayWithObjects:@"yes",@"no", nil];
        sview.selectedIndex = 1;
        sview.delegate = self;
        sview.notice = @"Sexual activity is a key variable related to the risk factor of pelvic floor muscle dysfunction.";
        [cell.contentView addSubview:sview];
    }
    if(indexPath.row == 13)
    {
        SkeaSliderButtonView * sview = [[SkeaSliderButtonView alloc] init];
        sview.frame = CGRectMake(0, 0, self.view.frame.size.width, 135);
        sview.tager = indexPath.row;
        sview.title = @"Mother with POP or UI";
        sview.selectedStringsArray = [NSArray arrayWithObjects:@"yes",@"no", nil];
        sview.selectedIndex = 1;
        sview.delegate = self;
        sview.notice = @"Sexual activity is a key variable related to the risk factor of pelvic floor muscle dysfunction.";
        [cell.contentView addSubview:sview];
    }
    if(indexPath.row == 14)
    {
        UIButton * submitButtn = [UIButton buttonWithType:UIButtonTypeCustom];
        submitButtn.frame = CGRectMake(8, 30, self.view.frame.size.width - 16, 44);
        [submitButtn setBackgroundImage:[UIImage imageNamed:@"button-cyan.png"] forState:UIControlStateNormal];
        [submitButtn setTitle:NSLocalizedString(@"Submit", nil) forState:UIControlStateNormal];
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
    
#if 1
    
    
    IMP_BLOCK_SELF(TestingViewController1) //作为一个self的弱引用,在block里面调用
    
    showIndicator(YES, @"正在加载中");  ///弹一个正在加载的菊花
    ///path 在URL.h里面找对就的宏
    ///[@{@"email":email,@"password":pwd} mutableCopy] 这是一个要post内容的可扩展字面
    [[BaseEngine sharedEngine] RunRequest:[@{@"email":email,@"birthday":birthday,@"height":height,@"weight":weight,@"date":date,@"result":_result} mutableCopy] path:SK_SAVE_QUS completionHandler:^(id responseObject) {
        ///请求成功
        showCustomAlertMessage(@"提交成功");
        [SkeaUser defaultUser].birthday = _ageTextField.text;
        [SkeaUser defaultUser].weight = _weightTextField.text;
        [SkeaUser defaultUser].height = _heightTextField.text;
        if(self._isRegisterPush)
        {
            PersonLoginedViewController * pvc = [[PersonLoginedViewController alloc] init];
            UINavigationController * nvc = [[UINavigationController alloc] initWithRootViewController:pvc];
            [block_self presentViewController:nvc animated:YES completion:nil];
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
    if(textField == _ageTextField)
    {
        UIView * view = [[UIView alloc] init];
        view.frame = CGRectMake(0, ScreenHeight - 216 - 40, ScreenWidth, 40 + 216);
        view.tag = 10086;
        view.backgroundColor = [UIColor whiteColor];
        view.userInteractionEnabled = YES;
        [self.view addSubview:view];
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(ScreenWidth - 50, 0, 50, 40);
        [btn setTitle:NSLocalizedString(@"确定", nil) forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(datePickerBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        
        _ageDatePicker = [ [ UIDatePicker alloc] initWithFrame:CGRectMake(0,40,ScreenWidth,216)];
        _ageDatePicker.backgroundColor = [UIColor whiteColor];
        _ageDatePicker.datePickerMode = UIDatePickerModeDate;
        _ageDatePicker.userInteractionEnabled = YES;
        [view addSubview:_ageDatePicker];
    }
    if(textField == _heightTextField)
    {
        UIView * view = [[UIView alloc] init];
        view.frame = CGRectMake(0, ScreenHeight - 216 - 40, ScreenWidth, 40 + 216);
        view.tag = 10087;
        view.backgroundColor = [UIColor whiteColor];
        view.userInteractionEnabled = YES;
        [self.view addSubview:view];
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(ScreenWidth - 50, 0, 50, 40);
        [btn setTitle:NSLocalizedString(@"确定", nil) forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(heightPickerBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        
        _heightPicker.frame = CGRectMake(0,40,ScreenWidth,216);
        _heightPicker.backgroundColor = [UIColor whiteColor];
        [view addSubview:_heightPicker];
    }
    if(textField == _weightTextField)
    {
        UIView * view = [[UIView alloc] init];
        view.frame = CGRectMake(0, ScreenHeight - 216 - 40, ScreenWidth, 40 + 216);
        view.tag = 10088;
        view.backgroundColor = [UIColor whiteColor];
        view.userInteractionEnabled = YES;
        [self.view addSubview:view];
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(ScreenWidth - 50, 0, 50, 40);
        [btn setTitle:NSLocalizedString(@"确定", nil) forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(weightPickerBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        
        _weightPicker.frame = CGRectMake(0,40,ScreenWidth,216);
        _weightPicker.backgroundColor = [UIColor whiteColor];
        [view addSubview:_weightPicker];
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(pickerView == _heightPicker)
        _heightTextField.text = [_heightArray objectAtIndex:row];
    if(pickerView == _weightPicker)
        _weightTextField.text = [_weightArray objectAtIndex:row];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(pickerView == _heightPicker)
        return [_heightArray objectAtIndex:row];
    return [_weightArray objectAtIndex:row];
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
    NSLog(@"%@",[self stringFromDate:_ageDatePicker.date]);
    [[self.view viewWithTag:10086] removeFromSuperview];
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
        [_resultDict setObject:[NSString stringWithFormat:@"%@",index?@"no":@"yes"] forKey:@"Seeing/Feeling Bulge"];
    }
    
    if(tag == 7)
    {
        [_resultDict setObject:[NSString stringWithFormat:@"%@",index?@"no":@"yes"] forKey:@"Menopausal Status"];
    }
    
    if(tag == 8)
    {
        [_resultDict setObject:[NSString stringWithFormat:@"%ld",index] forKey:@"Children"];
    }
    
    if(tag == 9)
    {
        [_resultDict setObject:[NSString stringWithFormat:@"%@",index?@"no":@"yes"] forKey:@"Smoking"];
    }
    
    if(tag == 10)
    {
        [_resultDict setObject:[NSString stringWithFormat:@"%@",index?@"no":@"yes"] forKey:@"Pelvic Floor Surgery"];
    }
    
    if(tag == 11)
    {
        [_resultDict setObject:[NSString stringWithFormat:@"%@",index?@"no":@"yes"] forKey:@"Current Heavy Work"];
    }
    
    if(tag == 12)
    {
        [_resultDict setObject:[NSString stringWithFormat:@"%@",index?@"no":@"yes"] forKey:@"Pelvic Floor Problems (POP or UI) during Gestation"];
    }
    
    if(tag == 13)
    {
        [_resultDict setObject:[NSString stringWithFormat:@"%@",index?@"no":@"yes"] forKey:@"Mother with POP or UI"];
    }
    
    _result = [_resultDict JSONString];
    
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
