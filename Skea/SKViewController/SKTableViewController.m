//
//  SKTableViewController.m
//  tempSKTableViewController
//
//  Created by yuyang on 14/10/25.
//  Copyright (c) 2014年 yuyang. All rights reserved.
//

#import "SKTableViewController.h"

#define REFRESH_LABEL_DURATION 2.0

@interface SKTableViewController ()
{
    UISearchDisplayController *_searchDisplayController;
    
    UIImageView *_blankView;
    
    CGRect _tempFrame;              //搜索前tableView的frame
    UIView *_tempTableFooterView;   //被_blankView替换前的tableFooterView
    
    NSString *_cellIdentifier;
    BOOL _isHeaderReloading;
    BOOL _isFooterReloading;
    
    CGFloat _systemVersion;
}

@property (atomic) BOOL shouldCancelThread;//有新搜索任务,取消正在执行的搜索线程
@property (atomic) BOOL isThreadRunning;//搜索任务正在执行

@end

@implementation SKTableViewController

- (id)init
{
    self = [super init];
    if (self) {
        _showSearchBar = NO;
        _showSearchDisplayController = NO;
        _showRefreshHeaderView = NO;
        _showRefreshFooterView = NO;
        _showTableBlankView = NO;
        
        _enableTableViewCellLongPress = NO;
        
        _tableViewClassName = NSStringFromClass([UITableView class]);
        _tableViewCellClassName = NSStringFromClass([SKTableViewCell class]);
        _tableViewStyle = UITableViewStylePlain;
        _tableViewCellSeparatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _cellIdentifier = NSStringFromClass(self.class);
        
        _systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    }
    return self;
}

- (void)viewDidLoad
{
    [self reloadDataSource];
    [super viewDidLoad];
}

#pragma mark - Property

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (NSMutableDictionary *)dataDictionary
{
    if (!_dataDictionary) {
        _dataDictionary = [[NSMutableDictionary alloc] init];
    }
    return _dataDictionary;
}

- (NSMutableArray *)displayDataArray
{
    if (!_displayDataArray) {
        _displayDataArray = [[NSMutableArray alloc] init];
    }
    return _displayDataArray;
}

- (NSMutableDictionary *)displayDataDictionary
{
    if (!_displayDataDictionary) {
        _displayDataDictionary = [[NSMutableDictionary alloc] init];
    }
    return _displayDataDictionary;
}

- (NSMutableArray *)searchResultsArray
{
    if (!_searchResultsArray) {
        _searchResultsArray = [[NSMutableArray alloc] init];
    }
    return _searchResultsArray;
}

- (NSMutableDictionary *)searchResultsDictionary
{
    if (!_searchResultsDictionary) {
        _searchResultsDictionary = [[NSMutableDictionary alloc] init];
    }
    return _searchResultsDictionary;
}

#pragma mark - Subviews

/*加载子视图，修改父类子视图*/
- (void)setupSubviews
{
    [super setupSubviews];
    //表视图
    if (!_tableView) {
        _tableView = [[NSClassFromString(_tableViewClassName) alloc] initWithFrame:self.contentFrame style:_tableViewStyle];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        //cell布局宽度(设置tableFooterView会重绘tableView，在此前计算)
        if (_tableView.style == UITableViewStyleGrouped) {
            if (_systemVersion < 7.0) {
                _cellContentFrame = CGRectMake(0.0, 0.0, _tableView.frame.size.width - 20.0, 0.0);
            } else {
                _cellContentFrame = CGRectMake(10.0, 0.0, _tableView.frame.size.width - 20.0, 0.0);
            }
        } else {
            _cellContentFrame = CGRectMake(0.0, 0.0, _tableView.frame.size.width, 0.0);
        }
        
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, _tableView.frame.size.width, 1.0)];//底部截止线
        _tempTableFooterView = _tableView.tableFooterView;
        
        if (_tableViewStyle == UITableViewStylePlain) {
            _tableView.separatorColor = [UIColor clearColor];
            _tableView.separatorStyle = _tableViewCellSeparatorStyle;
        } else {//分组样式
            _tableView.backgroundView = [[UIView alloc] init];
            _tableView.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1.0];
            
            if (_systemVersion >= 7.0) {
                _tableView.separatorColor = nil;
                _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            } else {
                _tableView.separatorColor = [UIColor colorWithWhite:0.8 alpha:1.0];
                _tableView.separatorStyle = _tableViewCellSeparatorStyle;
            }
        }
        
        [self.view addSubview:_tableView];
    }
    
    //初始化下拉更新功能
    if (_showRefreshHeaderView && !_refreshHeaderView) {
        CGRect frame = _tableView.frame;
        frame.origin.x = 0.0;
        frame.origin.y = -frame.size.height;
        
        _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:frame];
        _refreshHeaderView.delegate = self;
        [_tableView addSubview:_refreshHeaderView];
        
        [_refreshHeaderView refreshLastUpdatedDate];
    }
    
    //初始化上拉更新功能
    if (_showRefreshFooterView && !_refreshFooterView) {
        CGRect frame = _tableView.frame;
        frame.origin.x = 0.0;
        frame.origin.y = frame.size.height * 2;//初始化不显示
        
        _refreshFooterView = [[SKRefreshTableFooterView alloc] initWithFrame:frame];
        _refreshFooterView.delegate = self;
    }
    [self reloadRefreshTableHeaderView];
    [self reloadRefreshTableFooterView];
    
    //空数据提示
    if (self.showTableBlankView) {
        [self reloadTableBlankView];
    }
    
    
    //搜索栏
    if ((_showSearchBar || _showSearchDisplayController) && !_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 0.0, _tableView.frame.size.width, 44.0)];
        _searchBar.delegate = self;
        _searchBar.placeholder = NSLocalizedString(@"搜索", nil);
        _searchBar.barStyle = UIBarStyleDefault;
        _searchBar.keyboardType = UIKeyboardTypeDefault;
        _tableView.tableHeaderView = _searchBar;//表头部显示搜索栏
        _searchView = _searchBar;
        
        [_tableView scrollRectToVisible:CGRectMake(0.0, _tableView.tableHeaderView.frame.size.height, _tableView.frame.size.width, _tableView.frame.size.height) animated:NO];//默认隐藏搜索栏
    }
    if (_showSearchDisplayController && !_searchDisplayController) {
        _searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
        _searchDisplayController.delegate = self;
        _searchDisplayController.searchResultsDataSource = self;
        _searchDisplayController.searchResultsDelegate = self;
    }
    
    //导航栏显示在最高层
    if (self.showNavigationBar) {
        [self.view bringSubviewToFront:self.navigationBar];
    }
    
}



/*清除子视图缓存*/
- (void)clearSubviews
{
    [super clearSubviews];
    
    if (self.shouldClearSubview) {
        [self willDealloc];
    }
}

/*刷新子视图，结束编辑*/
- (void)refreshSubviews
{
    [super refreshSubviews];
    
    [self reloadTable];
}

/*刷新上拉刷新视图*/
- (void)reloadRefreshTableFooterView
{
    if (_showRefreshFooterView) {
        if (!_dataArray.count && !_dataDictionary.count) {//空数据
            [_refreshFooterView removeFromSuperview];
        } else {//有数据
            [_tableView addSubview:_refreshFooterView];
        }
    } else {//不显示
        [_refreshFooterView removeFromSuperview];
    }
}

/*刷新下拉刷新视图*/
- (void)reloadRefreshTableHeaderView
{
    if (_showRefreshHeaderView) {
        [_tableView addSubview:_refreshHeaderView];
    } else {//不显示
        [_refreshHeaderView removeFromSuperview];
    }
}

/*刷新无数据提示视图*/
- (void)reloadTableBlankView
{
    if (_showTableBlankView && !_dataArray.count && !_dataDictionary.count) {//空数据
        if (!_blankView) {
            _blankView = [[UIImageView alloc] initWithFrame:CGRectZero];
            _blankView.contentMode = UIViewContentModeCenter;
        }
        
        _blankView.frame = CGRectMake(0.0, 0.0, _tableView.frame.size.width, 180.0);
        _blankView.image = _isHeaderReloading ? [UIImage imageNamed:@"table_blank_loading"] : [UIImage imageNamed:@"table_blank_normal"];
        
        if (_tableView.tableFooterView != _blankView) {
            _tempTableFooterView = _tableView.tableFooterView;
        }
        _tableView.tableFooterView = _blankView;
    } else {//有数据
        if (_tableView.tableFooterView == _blankView) {
            _tableView.tableFooterView = _tempTableFooterView;
        }
        
        [_blankView removeFromSuperview];
        _blankView = nil;
    }
}

#pragma mark - TableView Methods

/*编辑状态*/
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    [_tableView setEditing:editing animated:animated];
}

/*重新加载数据源*/
- (void)reloadDataSource
{
//    if (self.pathForDataArray.length) {
//        self.dataArray.array = [[FileManager loadArray:self.pathForDataArray] subarrayFromIndex:0 count:30];
//        if (self.dataArray.count) {
//            [self reloadTable];
//        } else if (_showRefreshHeaderView) {
//            [self autoTriggerHeaderRefresh];
//        }
//    }
//    
//    if (self.pathForDataDictionary.length) {
//        self.dataDictionary = [FileManager loadDictionary:self.pathForDataDictionary];
//    }
}

/*刷新表视图、空数据提示视图、上拉刷新视图*/
- (void)reloadTable
{
    [_tableView reloadData];
    
    if (self.showEditBarButtonItem) {//编辑按钮
        self.editButtonItem.enabled = (_dataArray.count || _dataDictionary.count);
        
    }
    if (self.showTableBlankView) {
        [self reloadTableBlankView];
    }
    [self reloadRefreshTableFooterView];
}

- (void)tableViewCellLongPressAction:(UILongPressGestureRecognizer *)longPressGesture
{
    if (longPressGesture.state == UIGestureRecognizerStateBegan) {
        NSIndexPath *indexPath = [_tableView indexPathForCell:(UITableViewCell *)longPressGesture.view];
        [self tableView:_tableView didLongPressRowAtIndexPath:indexPath];
    }
}

#pragma mark - TableView Delegate & DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.searchView.tag == SKSearchBarStateDefault) {//正常
        return 1;
    } else {//搜索
        return 1;
    }
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.searchView.tag == SKSearchBarStateDefault) {
        return self.dataArray.count;
    } else {
        return self.searchResultsArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    if (!cell) {
        cell = [[NSClassFromString(_tableViewCellClassName) alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:_cellIdentifier];
        
        if (_enableTableViewCellLongPress) {//长按监听
            UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewCellLongPressAction:)];
            longPressGestureRecognizer.minimumPressDuration = 1.0;
            [cell addGestureRecognizer:longPressGestureRecognizer];
        }
    }
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    cell.textLabel.text = @"";
    cell.detailTextLabel.text = @"";
    cell.accessoryView = nil;
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //iOS7上模拟iOS6分组样式
    //    if (_systemVersion >= 7.0 && _tableViewStyle == UITableViewStyleGrouped) {
    //        if ([_tableViewCellClassName isEqualToString:NSStringFromClass([TIXATableViewCell class])]) {
    //            TIXATableViewCell *aCell = (TIXATableViewCell *)cell;
    //
    //            NSUInteger numberOfRows = [tableView numberOfRowsInSection:indexPath.section];
    //            if (numberOfRows == 1) {
    //                aCell.backgroundViewType = TIXATableViewCellBackgroundTypeGroup;
    //            } else {
    //                if (indexPath.row == 0) {
    //                    aCell.backgroundViewType = TIXATableViewCellBackgroundTypeGroupTop;
    //                } else if (indexPath.row == numberOfRows - 1) {
    //                    aCell.backgroundViewType = TIXATableViewCellBackgroundTypeGroupBottom;
    //                } else {
    //                    aCell.backgroundViewType = TIXATableViewCellBackgroundTypeGroupMiddle;
    //                }
    //            }
    //        } else if ([_tableViewCellClassName isEqualToString:NSStringFromClass([UITableViewCell class])]) {
    //            cell.backgroundColor = [UIColor clearColor];
    //            cell.textLabel.backgroundColor = [UIColor clearColor];
    //            cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    //        }
    //    }
    
    
    [self tableView:tableView setupCell:cell atIndexPath:indexPath];
    
    return cell;
}

/*设置可复用cell*/
- (void)tableView:(UITableView *)tableView setupCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    
}

/*cell长按事件*/
- (void)tableView:(UITableView *)tableView didLongPressRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.showEditBarButtonItem;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    id object;
//    if (self.searchView.tag == SFSearchBarStateDefault) {
//        object = [self.dataArray objectAtIndex:indexPath.row];
//    } else {
//        object = [self.searchResultsArray objectAtIndex:indexPath.row];
//    }
//    [self.dataArray removeObject:object];
//    [self.searchResultsArray removeObject:object];
//    
//    [FileManager saveObject:[self.dataArray subarrayFromIndex:0 count:200] filePath:self.pathForDataArray];//最多存储200条记录
//    
//    if (!self.dataArray.count) {//删除了最后一组，结束编辑
//        self.editing = NO;
//        self.editButtonItem.enabled = NO;
//        if (self.showTableBlankView) {
//            [self reloadTableBlankView];
//        }
//        
//        [self reloadRefreshTableFooterView];
//    }
//    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
}



#pragma mark - Refresh Methods

/*显示刷新提示信息，持续指定duration*/
- (void)showRefreshLabel:(NSString *)message duration:(NSTimeInterval)duration
{
    if (!_refreshLabel) {
        _refreshLabel = [[UILabel alloc] init];
        _refreshLabel.alpha = 0.0;
        _refreshLabel.layer.cornerRadius = 6.0;
        _refreshLabel.backgroundColor = [UIColor clearColor];
        _refreshLabel.textColor = [UIColor whiteColor];
        _refreshLabel.textAlignment = NSTextAlignmentCenter;
        _refreshLabel.font = [UIFont boldSystemFontOfSize:18.0];
        [self.view addSubview:_refreshLabel];
    }
    _refreshLabel.frame = CGRectMake(_tableView.frame.origin.x + 5.0, _tableView.frame.origin.y + 4.0, _tableView.frame.size.width - 10.0, 30.0);
    
    if (message.length) {
        _refreshLabel.text = message;
        
        [self showRefreshLabelAnimation];
        [self performSelector:@selector(hideRefreshLabelAnimation) withObject:nil afterDelay:duration];
    }
}

/*显示刷新提示标签，持续默认duration*/
- (void)showRefreshLabel:(NSString *)message
{
    [self showRefreshLabel:message duration:REFRESH_LABEL_DURATION];
}

/*刷新提示标签显示动画*/
- (void)showRefreshLabelAnimation
{
    [UIView animateWithDuration:0.3 animations:^{
        _refreshLabel.alpha = 1.0;
    }];
}

/*刷新提示标签隐藏动画*/
- (void)hideRefreshLabelAnimation
{
    [UIView animateWithDuration:0.3 animations:^{
        _refreshLabel.alpha = 0.0;
    }];
}

/*下拉刷新事件*/
- (void)tableViewDidTriggerHeaderRefresh
{
    if (self.showTableBlankView) {
        [self reloadTableBlankView];
    }
    
}

/*上拉刷新事件*/
- (void)tableViewDidTriggerFooterRefresh
{
    
}

/*下拉刷新回调*/
- (void)tableViewDidFinishHeaderRefreshReload:(BOOL)reload
{
    _isHeaderReloading = NO;
    [_refreshHeaderView performSelectorOnMainThread:@selector(egoRefreshScrollViewDataSourceDidFinishedLoading:) withObject:_tableView waitUntilDone:NO];
    
    //回弹动画后移除控件
    if (!_showRefreshFooterView && _refreshFooterView) {
        [_refreshFooterView removeFromSuperview];
        _refreshFooterView.delegate = nil;
        _refreshFooterView = nil;
    }
    
    if (reload) {
        [self reloadTable];
    }
}

/*下拉刷新回调，刷新表视图*/
- (void)tableViewDidFinishHeaderRefresh
{
    [self tableViewDidFinishHeaderRefreshReload:YES];
}

/*上拉刷新回调*/
- (void)tableViewDidFinishFooterRefreshReload:(BOOL)reload
{
    _isFooterReloading = NO;
    [_refreshFooterView performSelectorOnMainThread:@selector(skRefreshScrollViewDataSourceDidFinishedLoading:) withObject:_tableView waitUntilDone:NO];
    
    //回弹动画后移除控件
    if (!_showRefreshFooterView && _refreshFooterView) {
        [_refreshFooterView removeFromSuperview];
        _refreshFooterView.delegate = nil;
        _refreshFooterView = nil;
    }
    
    if (reload) {
        [self reloadTable];
    }
}

/*上拉刷新回调，刷新表视图*/
- (void)tableViewDidFinishFooterRefresh
{
    [self tableViewDidFinishFooterRefreshReload:YES];
}

/*自动下拉更新*/
- (void)autoTriggerHeaderRefresh:(BOOL)animated
{
    if (animated) {
        [_tableView setContentOffset:CGPointMake(0.0, -65.0)];
        [_refreshHeaderView egoRefreshScrollViewDidScroll:_tableView];
        [_refreshHeaderView egoRefreshScrollViewDidEndDragging:_tableView];
    } else {
        _isHeaderReloading = YES;
        [self tableViewDidTriggerHeaderRefresh];
    }
}

/*自动下拉更新*/
- (void)autoTriggerHeaderRefresh
{
    [self autoTriggerHeaderRefresh:YES];
}


#pragma mark - ScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([_searchView isFirstResponder]) {
        [self searchDidConfirm:_searchView];
    }
    if (self.showRefreshHeaderView) {
        [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    }
    if (self.showRefreshFooterView) {
        [_refreshFooterView skRefreshScrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.showRefreshHeaderView) {
        [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    }
    if (self.showRefreshFooterView) {
        [_refreshFooterView skRefreshScrollViewDidEndDragging:scrollView];
    }
}



#pragma mark - Refresh Delegate

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view
{
    _isHeaderReloading = YES;
    [self tableViewDidTriggerHeaderRefresh];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view
{
    return _isHeaderReloading;
}

- (NSDate *)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view
{
    return [NSDate date];
}

- (void)skRefreshTableFooterDidTriggerRefresh:(SKRefreshTableFooterView *)view
{
    _isFooterReloading = YES;
    [self tableViewDidTriggerFooterRefresh];
}

- (BOOL)skRefreshTableFooterDataSourceIsLoading:(SKRefreshTableFooterView *)view
{
    return _isFooterReloading;
}



#pragma mark - Search Methods

/*搜索任务（子类全部实现）*/
- (NSMutableArray *)searchTask:(NSString *)searchText
{
    return nil;
}

/*如果搜索任务执行时更新了输入，取消正在执行的搜索任务并创建新的搜索线程。返回值为NO时继续正常执行。*/
- (BOOL)needsRestartSearchTask
{
    if (self.shouldCancelThread) {
        self.shouldCancelThread = NO;
        
        NSString *searchText = [_searchView performSelector:@selector(text)];
        [self performSelectorInBackground:@selector(searchThread:) withObject:searchText];
        return YES;
    }
    return NO;
}

/*搜索任务*/
- (void)searchThread:(NSString *)searchText
{
    @autoreleasepool {
        NSMutableArray *tempArray = [self searchTask:searchText];
        self.searchResultsArray.array = tempArray;
        self.isThreadRunning = NO;
        if (tempArray) {//搜索全部完成，未被中断
            [_tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
        }
    }
}

/*搜索文本变化*/
- (void)searchTextDidChange:(NSString *)searchText
{
    // NSLog(@"searchTextDidChange:");
    
    if (searchText.length) {
        if (!self.isThreadRunning) {
            self.isThreadRunning = YES;
            [self performSelectorInBackground:@selector(searchThread:) withObject:searchText];
        } else {
            self.shouldCancelThread = YES;
        }
    } else {
        [self.searchResultsArray removeAllObjects];
        [self reloadTable];
    }
}

/*搜索开始*/
- (void)searchDidBegin:(UIView *)searchView
{
    //NSLog(@"searchDidBegin:");
    
//    if (searchView.tag == SKSearchBarStateDefault) {//首次进入搜索状态
//        self.view.backgroundColor = [UIColor clearColor];
//        
//        //切换状态，刷新表
//        searchView.tag = SFSearchBarStateSearching;
//        [self reloadTable];
//        
//        //界面调整
//        _tempFrame = _tableView.frame;
//        [UIView animateWithDuration:0.2 animations:^{
//            if (self.tabBarController.navigationController) {
//                self.tabBarController.navigationController.navigationBarHidden = YES;
//            } else if (self.tabBarController.navigationBar) {
//                CGRect frame = self.tabBarController.navigationBar.frame;
//                frame.origin.y = -frame.size.height;
//                self.tabBarController.navigationBar.frame = frame;
//            } else if (self.navigationController) {
//                self.navigationController.navigationBarHidden = YES;
//            } else if (self.navigationBar) {
//                CGRect frame = self.navigationBar.frame;
//                frame.origin.y = -frame.size.height;
//                self.navigationBar.frame = frame;
//            }
//            
//            //隐藏TabBar
//            if (self.tabBarController) {
//                self.tabBarController.tabBar.hidden = YES;
//                
//                CGRect frame = self.view.frame;
//                frame.size.height += self.tabBarController.tabBar.frame.size.height;
//                self.view.frame = frame;
//            }
//            
//            //            CGRect frame = self.segmentedView.frame;
//            //            frame.origin.y = -frame.size.height;
//            //            self.segmentedView.frame = frame;
//            
//            CGRect frame = _tableView.frame;
//            frame.origin.y = (_systemVersion < 7.0) ? 0.0 : 20.0;
//            frame.size.height = self.view.frame.size.height;
//            _tableView.frame = frame;
//            
//            //            //调整searchbar
//            //            CGRect sFrame = _searchBar.frame;
//            //            sFrame.origin.y = (_systemVersion < 7.0) ? 0.0 : 20.0;
//            //            _searchView.frame = sFrame;
//            
//        }];
//        
//        if ([searchView isKindOfClass:[UISearchBar class]]) {
//            [(UISearchBar *)searchView setShowsCancelButton:YES animated:YES];
//        }
//    }
}

- (void)searchDidEnd:(UIView *)searchView
{
    //NSLog(@"searchDidEnd:");
    
    if ([searchView isKindOfClass:[UISearchBar class]]) {
        //启用取消按钮文字
        for (id subview in searchView.subviews) {
            if ([subview isKindOfClass:[UIButton class]]) {
                [(UIButton *)subview setEnabled:YES];
            }
        }
    }
}

- (void)searchDidCancel:(UIView *)searchView
{
    //NSLog(@"searchDidCancel:");
    self.view.backgroundColor = [UIColor whiteColor];
    [searchView resignFirstResponder];
    
    if ([searchView respondsToSelector:@selector(setText:)]) {
        [searchView performSelector:@selector(setText:) withObject:nil];
    }
    
    [_searchResultsArray removeAllObjects];
    [_searchResultsDictionary removeAllObjects];
    
    //切换状态，刷新表
    searchView.tag = SKSearchBarStateDefault;
    [self reloadTable];
    
    //界面调整
    [UIView animateWithDuration:0.2 animations:^{
//        if (self.tabBarController.navigationController) {
//            self.tabBarController.navigationController.navigationBarHidden = NO;
//        } else if (self.tabBarController.navigationBar) {
//            CGRect frame = self.tabBarController.navigationBar.frame;
//            frame.origin.y = (_systemVersion < 7.0) ? 0.0 : 20.0;
//            self.tabBarController.navigationBar.frame = frame;
//        } else if (self.navigationController) {
//            self.navigationController.navigationBarHidden = NO;
//        } else if (self.navigationBar) {
//            CGRect frame = self.navigationBar.frame;
//            frame.origin.y = (_systemVersion < 7.0) ? 0.0 : 0.0;
//            self.navigationBar.frame = frame;
//        }
        
        //恢复TabBar
        if (self.tabBarController) {
            self.tabBarController.tabBar.hidden = NO;
            
            CGRect frame = self.view.frame;
            frame.size.height -= self.tabBarController.tabBar.frame.size.height;
            self.view.frame = frame;
        }
        
        //        CGRect frame = self.segmentedView.frame;
        //        frame.origin.y = frame.size.height;
        //        self.segmentedView.frame = frame;
        
        _tableView.frame = _tempFrame;
        
        //        //调整searchbar
        //        CGRect sFrame = _searchBar.frame;
        //        sFrame.origin.y = (_systemVersion < 7.0) ? 44.0 : 64.0;
        //        _searchView.frame = sFrame;
        
        
    } completion:^(BOOL finished) {
        if ([searchView isKindOfClass:[UISearchBar class]]) {
            [(UISearchBar *)searchView setShowsCancelButton:NO animated:YES];
        }
    }];
}

- (void)searchDidConfirm:(UIView *)searchView
{
    //NSLog(@"searchDidConfirm:");
    
    [searchView resignFirstResponder];
    
    if ([searchView isKindOfClass:[UISearchBar class]]) {
        //启用取消按钮文字
        for (id subview in searchView.subviews) {
            if ([subview isKindOfClass:[UIButton class]]) {
                [(UIButton *)subview setEnabled:YES];
            }
        }
    }
}



#pragma mark - IFlyRecognize Delegate

/*语音输入*/
- (void)startVoiceInput
{
    [self searchDidBegin:_searchView];//进入搜索状态
    
    //    IFlyRecognizeControl *recognizeControl = [[AudioManager defaultManager] iFlyRecognizeControl];
    //    recognizeControl.delegate = self;
    //    [self.view addSubview:recognizeControl];
    //
    //    [recognizeControl start];
    
    [_searchView resignFirstResponder];
}

/*输出识别结果*/
- (void)finishVoiceInput:(NSString *)result
{
    NSString *inputString = [result stringByReplacingOccurrencesOfString:@"。" withString:@""];
    
    NSString *text = [_searchView performSelector:@selector(text)];
    text = [text stringByAppendingString:inputString];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"pinyin" ofType:@"plist"];
    NSDictionary *pinyinDictionary = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    text = [self updatePinyins:pinyinDictionary newName:text];
    filePath = nil;
    pinyinDictionary = nil;
    
    if ([_searchView respondsToSelector:@selector(setText:)]) {
        [_searchView performSelector:@selector(setText:) withObject:text];
    }
    [self searchTextDidChange:text];
}

/***********************
 将语音识别到的结果转换成简拼
 ***********************/
- (NSString *)updatePinyins:(NSDictionary *)pinyinDic newName:(NSString *)newName
{
    NSString *value = @"";
    for (NSInteger i = 0; i < newName.length; i++) {
        unichar c = [newName characterAtIndex:i];
        if ((c >= '0' && c <= '9') || (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z')) {//字母、数字
            value = [value stringByAppendingFormat:@"%c", c];
        } else if (c + '0' > 255 + '0') {//汉字
            NSString *hanzi = [NSString stringWithCharacters:&c length:1];
            NSArray *pinyinList = [pinyinDic objectForKey:hanzi];
            
            if (!pinyinList || pinyinList.count == 0) {//标点符号或未收录对应拼音
                ;
            } else if (pinyinList.count == 1) {//单音字
                NSString *pinyinString = [pinyinList objectAtIndex:0];
                value = [value stringByAppendingString:[pinyinString substringToIndex:1]];
            } else {//多音字
                NSString *pinyinString = [pinyinList objectAtIndex:0];
                value = [value stringByAppendingString:[pinyinString substringToIndex:1]];
            }
        }
    }
    return value;
}
//
///*识别结束回调函数，当整个会话过程结束时候会调用这个函数*/
//- (void)onRecognizeEnd:(IFlyRecognizeControl *)iFlyRecognizeControl theError:(SpeechError)error
//{
//	NSLog(@"getUpflow:%d, getDownflow:%d", [iFlyRecognizeControl getUpflow], [iFlyRecognizeControl getDownflow]);
//
//    [iFlyRecognizeControl removeFromSuperview];
//    iFlyRecognizeControl.delegate = nil;
//
//    [_searchView becomeFirstResponder];
//}
//
///*识别结果回调函数*/
//- (void)onResult:(IFlyRecognizeControl *)iFlyRecognizeControl theResult:(NSArray *)resultArray
//{
//	[self performSelectorOnMainThread:@selector(finishVoiceInput:) withObject:[[resultArray objectAtIndex:0] objectForKey:@"NAME"] waitUntilDone:YES];
//}



#pragma mark - SearchBar Delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self searchTextDidChange:searchText];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self searchDidBegin:searchBar];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self searchDidEnd:searchBar];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self searchDidCancel:searchBar];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self searchDidConfirm:searchBar];
}



#pragma mark - searchDisplayController Delegate

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self searchTextDidChange:searchString];
    return YES;
}

- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    [self searchDidBegin:controller.searchBar];
}

- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
{
    [self searchDidEnd:controller.searchBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
