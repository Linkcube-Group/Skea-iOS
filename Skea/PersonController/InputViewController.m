//
//  InputViewController.m
//  Skea
//
//  Created by yuyang on 14/11/15.
//  Copyright (c) 2014年 com.dlnu.*. All rights reserved.
//

#import "InputViewController.h"

@interface InputViewController ()

@end

@implementation InputViewController
{
    UITextField * field;
}
@synthesize delegate = _delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [[Theam currentTheam] navigationTitleViewWithTitle:NSLocalizedString(@"昵称", nil)];
    self.navigationItem.leftBarButtonItem = [[Theam currentTheam] navigationBarLeftButtonItemWithImage:IMG(@"menu_action_back_white.png") Title:nil Target:self Selector:@selector(btBack_DisModal:)];
    self.navigationItem.rightBarButtonItem = [[Theam currentTheam] navigationBarRightButtonItemWithImage:nil Title:NSLocalizedString(@"保存", nil) Target:nil Selector:@selector(Done)];
    self.view.backgroundColor = [UIColor colorWithRed:249/255.f green:249/255.f blue:249/255.f alpha:1.f];
    
    
    UIView * wView = [[UIView alloc] init];
    wView.frame = CGRectMake(0, 110, self.view.frame.size.width, 40);
    wView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:wView];
    
    field = [[UITextField alloc] init];
    field.backgroundColor = [UIColor clearColor];
    field.text = self.nickName;
    field.frame = CGRectMake(20, 110, self.view.frame.size.width - 40, 40);
    [self.view addSubview:field];
}

-(void)Done
{
    NSString *nickName = field.text;
    if (StringIsNullOrEmpty(nickName)) {
        showAlertMessage(@"昵称不能为空");
        return;
    }
    
    IMP_BLOCK_SELF(InputViewController) //作为一个self的弱引用,在block里面调用
    
    showIndicator(YES, @"正在加载中");  ///弹一个正在加载的菊花
    [[BaseEngine sharedEngine] RunRequest:[@{@"email":[SkeaUser defaultUser].email,@"nickname":nickName} mutableCopy] path:SK_EDITNAME completionHandler:^(id responseObject) {
        ///请求成功
        showCustomAlertMessage(@"修改成功");
        showIndicator(NO, nil);
        [SkeaUser defaultUser].nickName = nickName;
        [block_self dismissViewControllerAnimated:YES completion:nil];
        
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
