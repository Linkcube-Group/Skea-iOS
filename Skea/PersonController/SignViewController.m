//
//  SignViewController.m
//  Skea
//
//  Created by mosn on 10/7/14.
//  Copyright (c) 2014 com.dlnu.*. All rights reserved.
//

#import "SignViewController.h"
#import "PersonViewController.h"
#import "CXAlertView.h"
#import "TestingViewController1.h"
#import "SkeaUser.h"

@interface SignViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@end

@implementation SignViewController
{
    UITextField * _emailTextField;
    UITextField * _passwordTextField;
    UITextField * _rePasswordTextField;
    UIButton * regButton;
}
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
//    self.navigationItem.titleView = [[Theam currentTheam] navigationTitleViewWithTitle:nil];
//    self.navigationItem.leftBarButtonItem = [[Theam currentTheam] navigationBarLeftButtonItemWithImage:IMG(@"back-cross.png") Title:nil Target:self Selector:@selector(btBack_DisModal:)];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:IMG(@"back-cross.png") forState:UIControlStateNormal];
    btn.tag = 200;
    [btn addTarget:self action:@selector(btBack_DisModal:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font=[Theam currentTheam].navigationBarItemFont;
    [btn setTitleColor:[Theam currentTheam].navigationBarItemTitleColor forState:UIControlStateNormal];
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    btn.frame=CGRectMake(10, 34, 24, 24);
    
    //让图片在最右侧对齐
    CGSize imagesize=IMG(@"back-cross.png").size;
    imagesize.width=imagesize.width/2;
    imagesize.height=imagesize.height/2;
    CGSize btnsize=btn.size;
    
    //iOS7下面导航按钮会默认有10px间距
    UIEdgeInsets insets=UIEdgeInsetsMake((btnsize.height-imagesize.height)/2, btnsize.width-imagesize.width, (btnsize.height-imagesize.height)/2, 0);
    [btn setImageEdgeInsets:insets];
    btn.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    if (DeviceSystemSmallerThan(7.0)) {
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    }
    [self.view addSubview:btn];
    
    _emailTextField  = [[UITextField alloc] init];
    _passwordTextField = [[UITextField alloc] init];
    _rePasswordTextField = [[UITextField alloc] init];
    
    self.view.backgroundColor = [UIColor colorWithRed:249/255.f green:249/255.f blue:249/255.f alpha:1.f];
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor colorWithRed:249/255.f green:249/255.f blue:249/255.f alpha:1.f];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
        return 80.f;
    if(indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3)
        return 40.f;
    return 400.f;
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
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake((self.view.frame.size.width - 258/2)/2.f, 0, 258/2, 63);
        imageView.image = [UIImage imageNamed:@"logo.png"];
        [cell.contentView addSubview:imageView];
        [cell.contentView addSubview:[self lineViewWithFrame:CGRectMake(0, 79.f, self.view.frame.size.width, 0.5)]];
    }
    else if (indexPath.row == 1)
    {
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(25, 10, 20, 20);
        imageView.image = [UIImage imageNamed:@"icon-email.png"];
        [cell.contentView addSubview:imageView];
        
//        UILabel * label = [[UILabel alloc] init];
//        label.frame = CGRectMake(imageView.frame.origin.x + imageView.frame.size.width + 10, 5, 80, 30);
//        label.backgroundColor = [UIColor clearColor];
//        label.text = NSLocalizedString(@"邮箱", nil);
//        [cell.contentView addSubview:label];
        
        _emailTextField.frame = CGRectMake(imageView.frame.origin.x + imageView.frame.size.width + 10, 5, self.view.frame.size.width - imageView.frame.origin.x - imageView.frame.size.width - 10, 30);
        _emailTextField.placeholder = NSLocalizedString(@"请输入邮箱", nil);
        _emailTextField.returnKeyType = UIReturnKeyDone;
        _emailTextField.delegate = self;
        [cell.contentView addSubview:_emailTextField];
        [cell.contentView addSubview:[self lineViewWithFrame:CGRectMake(20, 39.f, self.view.frame.size.width - 20, 0.5)]];
    }
    else if (indexPath.row == 2)
    {
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(25, 10, 20, 20);
        imageView.image = [UIImage imageNamed:@"icon-password.png"];
        [cell.contentView addSubview:imageView];
        
//        UILabel * label = [[UILabel alloc] init];
//        label.frame = CGRectMake(imageView.frame.origin.x + imageView.frame.size.width + 10, 5, 80, 30);
//        label.backgroundColor = [UIColor clearColor];
//        label.text = NSLocalizedString(@"密码", nil);
//        [cell.contentView addSubview:label];
        
        _passwordTextField.frame = CGRectMake(imageView.frame.origin.x + imageView.frame.size.width + 10, 5, self.view.frame.size.width - imageView.frame.origin.x - imageView.frame.size.width - 10, 30);
        _passwordTextField.placeholder = NSLocalizedString(@"请输入密码", nil);
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.returnKeyType = UIReturnKeyDone;
        _passwordTextField.delegate = self;
        [cell.contentView addSubview:_passwordTextField];
        [cell.contentView addSubview:[self lineViewWithFrame:CGRectMake(20, 39.f, self.view.frame.size.width - 20, 0.5)]];
    }
    else if (indexPath.row == 3)
    {
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(25, 10, 20, 20);
        imageView.image = [UIImage imageNamed:@"icon-password.png"];
        [cell.contentView addSubview:imageView];
        
//        UILabel * label = [[UILabel alloc] init];
//        label.frame = CGRectMake(imageView.frame.origin.x + imageView.frame.size.width + 10, 5, 80, 30);
//        label.backgroundColor = [UIColor clearColor];
//        label.text = NSLocalizedString(@"确认密码", nil);
//        [cell.contentView addSubview:label];
        
        _rePasswordTextField.frame = CGRectMake(imageView.frame.origin.x + imageView.frame.size.width + 10, 5, self.view.frame.size.width - imageView.frame.origin.x - imageView.frame.size.width - 10, 30);
        _rePasswordTextField.placeholder = NSLocalizedString(@"再次输入密码", nil);
        _rePasswordTextField.secureTextEntry = YES;
        _rePasswordTextField.returnKeyType = UIReturnKeyDone;
        _rePasswordTextField.delegate = self;
        [cell.contentView addSubview:_rePasswordTextField];
        [cell.contentView addSubview:[self lineViewWithFrame:CGRectMake(0, 39.f, self.view.frame.size.width, 0.5)]];
    }
    else
    {
        NSString * str0 = NSLocalizedString(@"同意", nil);
        NSString * str = NSLocalizedString(@"Skea用户协议", nil);
        CGSize size0 = [str0 sizeWithFont:[UIFont systemFontOfSize:13.f]];
        CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:13.f]];
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(25, 10, 20, 20);
        [btn setImage:[UIImage imageNamed:@"selection-checked.png"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(agree:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:13.f];
        [cell.contentView addSubview:btn];
        
        UILabel * label0 =[[UILabel alloc] init];
        label0.frame = CGRectMake(55, 10, size0.width, 20);
        label0.backgroundColor = [UIColor clearColor];
        label0.textColor = [UIColor blackColor];
        label0.text = str0;
        label0.font = [UIFont systemFontOfSize:13.f];
        [cell.contentView addSubview:label0];
        
        UILabel * label =[[UILabel alloc] init];
        label.frame = CGRectMake(55 + size0.width + 5, 10, size.width, 20);
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithRed:103/255.f green:201/255.f blue:224/255.f alpha:1.f];
        label.text = str;
        label.font = [UIFont systemFontOfSize:13.f];
        label.userInteractionEnabled = YES;
        [cell.contentView addSubview:label];
        
        UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(0, 0, label.frame.size.width, label.frame.size.height);
        [btn1 addTarget:self action:@selector(forgetPassword) forControlEvents:UIControlEventTouchUpInside];
        btn1.backgroundColor = [UIColor clearColor];
        [label addSubview:btn1];
        
        UIView * line = [[UIView alloc] init];
        line.frame = CGRectMake(0, 19.5, size.width, 0.5);
        line.backgroundColor = [UIColor colorWithRed:103/255.f green:201/255.f blue:224/255.f alpha:1.f];
        [label addSubview:line];
        
        
        regButton = [UIButton buttonWithType:UIButtonTypeCustom];
        regButton.frame = CGRectMake(8, 50, self.view.frame.size.width - 16, 44);
        [regButton setBackgroundImage:[UIImage imageNamed:@"button-cyan.png"] forState:UIControlStateNormal];
        [regButton setBackgroundImage:[UIImage imageNamed:@"loginButtonBg.png"] forState:UIControlStateHighlighted];
        regButton.layer.cornerRadius = 15.f;
        [regButton setTitle:NSLocalizedString(@"注册", nil) forState:UIControlStateNormal];
        [regButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [regButton addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:regButton];
        
        UIButton * loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        loginButton.frame = CGRectMake(regButton.frame.origin.x, self.view.frame.size.height - 64 - 44 - 20 - 200, regButton.frame.size.width, regButton.frame.size.height);
        
        [loginButton setTitle:NSLocalizedString(@"登陆", nil) forState:UIControlStateNormal];
        [loginButton setBackgroundImage:[UIImage imageNamed:@"button-gray.png"] forState:UIControlStateNormal];
        [loginButton setBackgroundImage:[UIImage imageNamed:@"loginButtonBg.png"] forState:UIControlStateHighlighted];
        [loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:loginButton];
        
    }
    return cell;
}

-(void)agree:(UIButton *)btn
{
    //selection-unchecked.png
    static BOOL change = YES;
    if(change)
    {
        regButton.enabled = NO;
        [btn setImage:[UIImage imageNamed:@"selection-unchecked.png"] forState:UIControlStateNormal];
    }
    else
    {
        regButton.enabled = YES;
        [btn setImage:[UIImage imageNamed:@"selection-checked.png"] forState:UIControlStateNormal];
    }
    change = !change;
}

-(UIView *)lineViewWithFrame:(CGRect)rect
{
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithRed:156/255.f green:157/255.f blue:159/255.f alpha:1.f];
    view.frame = rect;
    return view;
}

-(void)login
{
    NSLog(@"登陆");
    [self btBack_DisModal:nil];
}

-(void)registerButtonClick
{
    NSLog(@"注册");
    
    //    [self btBack_DisModal:nil];
    NSString *email = _emailTextField.text;
    if (StringIsNullOrEmpty(email)) {
        showAlertMessage(@"邮箱不能为空");
        return;
    }
    NSString *pwd = _passwordTextField.text;
    if (StringIsNullOrEmpty(pwd)) {
        showAlertMessage(@"密码不能为空");
        return;
    }
    
    if(![_passwordTextField.text isEqualToString:_rePasswordTextField.text])
    {
        showAlertMessage(@"密码和确认密码不一致");
        return;
    }
    
    IMP_BLOCK_SELF(SignViewController) //作为一个self的弱引用,在block里面调用
    
    showIndicator(YES, @"正在加载中");  ///弹一个正在加载的菊花
    ///path 在URL.h里面找对就的宏
    ///[@{@"email":email,@"password":pwd} mutableCopy] 这是一个要post内容的可扩展字面
    [[BaseEngine sharedEngine] RunRequest:[@{@"email":email,@"password":pwd,@"nickname":@"skea"} mutableCopy] path:SK_SIGN completionHandler:^(id responseObject) {
        ///请求成功
        showCustomAlertMessage(@"恭喜您注册成功");
        showIndicator(NO, nil);
        
        [SkeaUser defaultUser].email = email;
        [SkeaUser defaultUser].password = pwd;
        [SkeaUser defaultUser].isLogin = YES;
        [SkeaUser defaultUser].userId = @"";
        [SkeaUser defaultUser].saveUser = YES;
        
        [SkeaUser defaultUser].speedType = SpeedTypeConstant;
        
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"compressLevel"];
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"rotateLevel"];
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"selfLevel"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
//        [block_self btBack_DisModal:nil];
        TestingViewController1 * tvc = [[TestingViewController1 alloc] init];
        tvc._isRegisterPush = YES;
        UINavigationController * nvc = [[UINavigationController alloc] initWithRootViewController:tvc];
        [block_self presentViewController:nvc animated:YES completion:nil];
        
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_emailTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    [_rePasswordTextField resignFirstResponder];
    return YES;
}

-(void)forgetPassword
{
    NSString * str = @"溧阳鹊桥电子科技有限公司（下称“鹊桥科技”）在此特别提醒用户认真阅读、充分理解本《服务协议》（下称《协议》）--- 用户应认真阅读、充分理解本《协议》中各条款，包括免除或者限制鹊桥科技责任的免责条款及对用户的权利限制条款。请您审慎阅读并选择接受或不接受本《协议》（未成年人应在法定监护人陪同下阅读）。除非您接受本《协议》所有条款，否则您无权登录或使用本协议所涉相关服务。您的登录、使用等行为将视为对本《协议》的接受，并同意接受本《协议》各项条款的约束。\n本《协议》是您（下称“用户”）与鹊桥科技之间关于使用“连酷”服务所订立的协议。本《协议》描述鹊桥科技与用户之间关于“连酷”服务相关方面的权利义务。“用户”是指使用、浏览本服务的个人或组织。\n本《协议》可由鹊桥科技随时更新，更新后的协议条款一旦公布即代替原来的协议条款，恕不再另行通知，用户可在本网站查阅最新版协议条款。在鹊桥科技修改《协议》条款后，如果用户不接受修改后的条款，请立即停止使用鹊桥科技提供的服务，用户继续使用鹊桥科技提供的服务将被视为已接受了修改后的协议。\n使用规则\n1、鹊桥科技和连酷的服务及产品仅为成年人提供，未成年人严禁使用。\n2、用户充分了解并同意，连酷仅为用户提供信息分享、传送及获取的平台，用户必须为自己帐号下的一切行为负责，包括您所传送的任何内容以及由此产生的任何结果。用户应对连酷中的内容自行加以判断，并承担因使用内容而引起的所有风险，包括因对内容的正确性、完整性或实用性的依赖而产生的风险。鹊桥科技无法且不会对因用户行为而导致的任何损失或损害承担责任。\n3、用户在连酷服务中或通过连酷服务所传送的任何内容并不反映鹊桥科技的观点或政策，鹊桥科技对此不承担任何责任。\n4、用户充分了解并同意，连酷是一个基于用户关系的即时物联网通讯产品，用户须对在连酷上的账号信息的真实性、合法性、有效性承担全部责任，用户不得冒充他人；不得利用他人的名义传播任何信息；不得恶意使用帐号导致其他用户误认；否则鹊桥科技有权立即停止提供服务，收回连酷帐号并由用户独自承担由此而产生的一切法律责任。\n5、用户须对在连酷上所传送信息的真实性、合法性、无害性、有效性等全权负责，与用户所传播的信息相关的任何法律责任由用户自行承担，与鹊桥科技无关。\n6、鹊桥科技保留因业务发展需要，单方面对本服务的全部或部分服务内容在任何时候不经任何通知的情况下变更、暂停、限制、终止或撤销连酷服务的权利，用户需承担此风险。\n7、连酷提供的服务中可能包括广告，用户同意在使用过程中显示连酷和第三方供应商、合作伙伴提供的广告。\n8、用户不得利用连酷或连酷服务制作、上载、复制、发送如下内容：\n(1) 反对宪法所确定的基本原则的；\n(2) 危害国家安全，泄露国家秘密，颠覆国家政权，破坏国家统一的；\n(3) 损害国家荣誉和利益的；\n(4) 煽动民族仇恨、民族歧视，破坏民族团结的；\n(5) 破坏国家宗教政策，宣扬邪教和封建迷信的；\n(6) 散布谣言，扰乱社会秩序，破坏社会稳定的；\n(7) 散布淫秽、色情、赌博、暴力、凶杀、恐怖或者教唆犯罪的；\n(8) 侮辱或者诽谤他人，侵害他人合法权益的；\n(9) 含有法律、行政法规禁止的其他内容的信息。\n9、鹊桥科技可依其合理判断，对违反有关法律法规或本协议约定；或侵犯、妨害、威胁任何人权利或安全的内容，或者假冒他人的行为，鹊桥科技有权依法停止传输任何前述内容，并有权依其自行判断对违反本条款的任何人士采取适当的法律行动，包括但不限于，从连酷服务中删除具有违法性、侵权性、不当性等内容，终止违反者的成员资格，阻止其使用连酷全部或部分服务，并且依据法律法规保存有关信息并向有关部门报告等。\n10、用户权利及义务：\n(1) 连酷帐号的所有权归鹊桥科技所有，用户完成安装后，获得连酷帐号的使用权，该使用权仅属于手机拥有人，禁止赠与、借用、租用、转让或售卖。鹊桥科技因经营需要，有权回收用户的连酷帐号。\n(2) 用户有权更改、删除在连酷上的个人资料、信息及传送内容等，但需注意，删除有关信息的同时也会删除任何您储存在系统中的文字和图片。用户需承担该风险。\n(3) 用户有责任妥善保管帐号信息的安全，用户需要对帐号下的行为承担法律责任。用户同意在任何情况下不使用其他成员的帐号。在您怀疑他人在使用您的帐号时，您同意立即通知鹊桥科技。\n(4) 用户应遵守本协议的各项条款，正确、适当地使用本服务，如因用户违反本协议中的任何条款，鹊桥科技有权依据协议终止对违约用户连酷帐号提供服务。同时，鹊桥科技保留在任何时候收回连酷帐号、用户名的权利。\n(5) 用户拥有连酷帐号后如果长期不使用该帐号，鹊桥科技有权回收该帐号，以免造成资源浪费，由此带来问题均由用户自行承担。\n\n隐私保护\n用户同意个人隐私信息是指那些能够对用户进行个人辨识或涉及个人通信的信息，包括下列信息：用户真实姓名，身份证号，手机号码，IP地址。而非个人隐私信息是指用户对本服务的操作状态以及使用习惯等一些明确且客观反映在鹊桥科技服务器端的基本记录信息和其他一切个人隐私信息范围外的普通信息；以及用户同意公开的上述隐私信息；\n\n尊重用户个人隐私信息的私有性是鹊桥科技的一贯制度，鹊桥科技将会采取合理的措施保护用户的个人隐私信息，除法律或有法律赋予权限的政府部门要求或用户同意等原因外，鹊桥科技未经用户同意不向除合作单位以外的第三方公开、 透露用户个人隐私信息。 但是，经用户同意，或用户与鹊桥科技及合作单位之间就用户个人隐私信息公开或使用另有约定的除外，同时用户应自行承担因此可能产生的任何风险，鹊桥科技对此不予负责。同时，为了运营和改善鹊桥科技的技术和服务，鹊桥科技将可能会自行收集使用或向第三方提供用户的非个人隐私信息，这将有助于鹊桥科技向用户提供更好的用户体验和提高鹊桥科技的服务质量。\n\n用户同意，在使用连酷服务时也同样受鹊桥科技隐私政策的约束。当您接受本协议条款时，您同样认可并接受鹊桥科技隐私政策的条款。\n\n连酷商标信息\n连酷服务中所涉及的图形、文字或其组成，以及其他鹊桥科技标志及产品、服务名称，均为鹊桥科技之商标（以下简称“鹊桥科技标识”）。未经鹊桥科技事先书面同意，用户不得将鹊桥科技标识以任何方式展示或使用或作其他处理，也不得向他人表明您有权展示、使用、或其他有权处理鹊桥科技标识的行为。\n\n法律责任及免责\n1、用户违反本《协议》或相关的服务条款的规定，导致或产生的任何第三方主张的任何索赔、要求或损失，包括合理的律师费，用户同意赔偿鹊桥科技与合作公司、关联公司，并使之免受损害。\n2、用户因第三方如电信部门的通讯线路故障、技术问题、网络、电脑故障、系统不稳定性及其他各种不可抗力原因而遭受的一切损失，鹊桥科技及合作单位不承担责任。\n3、因技术故障等不可抗事件影响到服务的正常运行的，鹊桥科技及合作单位承诺在第一时间内与相关单位配合，及时处理进行修复，但用户因此而遭受的一切损失，鹊桥科技及合作单位不承担责任。\n4、本服务同大多数互联网服务一样，受包括但不限于用户原因、网络服务质量、社会环境等因素的差异影响，可能受到各种安全问题的侵扰，如他人利用用户的资料，造成现实生活中的骚扰；用户下载安装的其它软件或访问的其他网站中含有“特洛伊木马”等病毒，威胁到用户的计算机信息和数据的安全，继而影响本服务的正常使用等等。用户应加强信息安全及使用者资料的保护意识，要注意加强账号保护，以免遭致损失和骚扰。\n5、用户须明白，使用本服务因涉及Internet服务，可能会受到各个环节不稳定因素的影响。因此，本服务存在因不可抗力、计算机病毒或黑客攻击、系统不稳定、用户所在位置、用户关机以及其他任何技术、互联网络、通信线路原因等造成的服务中断或不能满足用户要求的风险。用户须承担以上风险，鹊桥科技不作担保。对因此导致用户不能发送和接受阅读信息、或接发错信息，鹊桥科技不承担任何责任。\n6、用户须明白，在使用本服务过程中存在有来自任何他人的包括威胁性的、诽谤性的、令人反感的或非法的内容或行为或对他人权利的侵犯（包括知识产权）的匿名或冒名的信息的风险，用户须承担以上风险，鹊桥科技和合作公司对本服务不作任何类型的担保，不论是明确的或隐含的，包括所有有关信息真实性、适商性、适于某一特定用途、所有权和非侵权性的默示担保和条件，对因此导致任何因用户不正当或非法使用服务产生的直接、间接、偶然、特殊及后续的损害，不承担任何责任。\n7、鹊桥科技定义的信息内容包括：文字、软件、声音、相片、录像、图表；在广告中全部内容；鹊桥科技为用户提供的商业信息，所有这些内容受版权、商标权、和其它知识产权和所有权法律的保护。所以，用户只能在鹊桥科技和广告商授权下才能使用这些内容，而不能擅自复制、修改、编纂这些内容、或创造与内容有关的衍生产品。\n8、在任何情况下，鹊桥科技均不对任何间接性、后果性、惩罚性、偶然性、特殊性或刑罚性的损害，包括因用户使用连酷服务而遭受的利润损失，承担责任（即使连酷已被告知该等损失的可能性亦然）。尽管本协议中可能含有相悖的规定，鹊桥科技对您承担的全部责任，无论因何原因或何种行为方式，始终不超过您在成员期内因使用连酷服务而支付给鹊桥科技的费用(如有) 。\n连酷社区管理规则\n连酷是和现实相关的社交产品，希望用户相互尊重，遵循和现实社会一样的社交礼仪。\n有以下行为者，被用户举报后将给予警告处理，警告多次后将被禁言：\n1、在交谈中有辱骂、恐吓、威胁等言论；\n2、使用含色情意味的或冒犯性的个人姓名、头像或资料；\n3、群发骚扰信息，滥用通讯自由情况者；\n4、发布各类垃圾广告，恶意信息，诱骗信息；\n5、恶意性骚扰或进行恶劣人身攻击的行为；\n6、恶意攻击他人种族或血统、宗教、残障、年龄、性取向行为；\n7、假冒他人身份和资料，或采取任何误导或有意误导他人的行为；\n8、擅自公布他人的隐私和机密信息，包括住址、手机、证件号码、邮箱等信息；\n9、利用连酷发布不当政治言论或者任何违反国家法规政策的言论；\n用户一旦被禁言，需要联系客服申请解禁，申请解禁请在应用中联系客服，或联系我们。\n如用户违反社区管理规则，鹊桥科技有权依据协议终止对违约用户连酷帐号提供服务。同时，鹊桥科技保留在任何时候收回连酷帐号的权力。\n\n其他条款\n1、鹊桥科技郑重提醒用户注意本《协议》中免除鹊桥科技责任和加重用户义务的条款，请用户仔细阅读，自主考虑风险。未成年人应在法定监护人的陪同下阅读本《协议》。以上各项条款内容的最终解释权及修改权归鹊桥科技所有。\n2、本《协议》所定的任何条款的部分或全部无效者，不影响其它条款的效力。\n3、本《协议》的版权由鹊桥科技所有，鹊桥科技保留一切解释和修改权利。";
    CXAlertView *alertView = [[CXAlertView alloc] initWithTitle:NSLocalizedString(@"Skea用户协议", nil) message:str cancelButtonTitle:NSLocalizedString(@"确定", nil)];
    [alertView show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
