//
//  SKTableViewController.h
//  tempSKTableViewController
//
//  Created by yuyang on 14/10/25.
//  Copyright (c) 2014年 yuyang. All rights reserved.
//

#warning 待完善

#import <UIKit/UIKit.h>
#import "SKRefreshTableFooterView.h"
#import "SKTableViewCell.h"
#import "EGORefreshTableHeaderView.h"
#import "SKViewController.h"

//重新搜索的标记。如果搜索任务执行时更新了输入，取消正在执行的搜索任务并创建新的搜索线程。
#define RESTART_SEARCH_TASK_POINT if ([self needsRestartSearchTask]) return nil;

typedef enum {
    SKSearchBarStateDefault = 0,
    SKSearchBarStateSearching
} SKSearchBarState;


@interface SKTableViewController : SKViewController<EGORefreshTableHeaderDelegate,SKRefreshTableFooterDelegate,UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDelegate,UITableViewDataSource>
{
@private
    UILabel *_refreshLabel;
}

@property (nonatomic, strong, readonly) NSString *pathForDataArray;//数组数据源文件路径（子类全部实现）
@property (nonatomic, strong, readonly) NSString *pathForDataDictionary;//字典数据源文件路径（子类全部实现）
@property (nonatomic, strong) NSMutableArray *dataArray;//数组形式数据源
@property (nonatomic, strong) NSMutableDictionary *dataDictionary;//字典形式数据源
@property (nonatomic, strong) NSMutableArray *displayDataArray;//显示数组形式数据源
@property (nonatomic, strong) NSMutableDictionary *displayDataDictionary;//显示字典形式数据源

//搜索
@property (nonatomic, strong) UIView *searchView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray *searchResultsArray;//数组形式搜索结果
@property (nonatomic, strong) NSMutableDictionary *searchResultsDictionary;//字典形式搜索结果

@property (nonatomic, strong) NSString *tableViewClassName;//表视图类名
@property (nonatomic, strong) NSString *tableViewCellClassName;//表元类名
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic) UITableViewStyle tableViewStyle;
@property (nonatomic) UITableViewCellSeparatorStyle tableViewCellSeparatorStyle;
@property (nonatomic, strong) EGORefreshTableHeaderView *refreshHeaderView;
@property (nonatomic, strong) SKRefreshTableFooterView *refreshFooterView;

@property (nonatomic, assign) BOOL showSearchBar;//是否显示搜索栏
@property (nonatomic, assign) BOOL showSearchDisplayController;//是否显示搜索控制器

@property (nonatomic, assign) BOOL showRefreshHeaderView;//是否支持下拉刷新
@property (nonatomic, assign) BOOL showRefreshFooterView;//是否支持上拉刷新
@property (nonatomic, assign) BOOL showTableBlankView;//是否显示默认空数据视图

@property (nonatomic, assign) BOOL enableTableViewCellLongPress;//添加表元长按监听

///cell布局区域
@property (nonatomic, readonly) CGRect cellContentFrame;

- (void)reloadDataSource;//重新加载数据源
- (void)reloadTable;//刷新   表视图、上拉刷新视图


- (void)showRefreshLabel:(NSString *)message duration:(NSTimeInterval)duration;//显示刷新提示信息，持续指定duration
- (void)showRefreshLabel:(NSString *)message;//显示刷新提示信息，持续默认duration

- (void)tableViewDidTriggerHeaderRefresh;//下拉刷新事件
- (void)tableViewDidTriggerFooterRefresh;//上拉刷新事件
- (void)tableViewDidFinishHeaderRefresh;//下拉刷新回调，刷新表视图
- (void)tableViewDidFinishHeaderRefreshReload:(BOOL)reload;//下拉刷新回调
- (void)tableViewDidFinishFooterRefresh;//上拉刷新回调，刷新表视图
- (void)tableViewDidFinishFooterRefreshReload:(BOOL)reload;//上拉刷新回调
- (void)autoTriggerHeaderRefresh:(BOOL)animated;//自动下拉更新
- (void)autoTriggerHeaderRefresh;//自动下拉更新，animated=YES

- (void)tableView:(UITableView *)tableView setupCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;/*设置可复用cell*/
- (void)tableView:(UITableView *)tableView didLongPressRowAtIndexPath:(NSIndexPath *)indexPath;/*cell长按事件*/

- (NSMutableArray *)searchTask:(NSString *)searchText;//搜索任务（子类全部实现）
- (BOOL)needsRestartSearchTask;//见 RESTART_SEARCH_TASK_POINT

- (void)searchTextDidChange:(NSString *)searchText;
- (void)searchDidBegin:(UIView *)searchView;
- (void)searchDidEnd:(UIView *)searchView;
- (void)searchDidCancel:(UIView *)searchView;
- (void)searchDidConfirm:(UIView *)searchView;

- (void)startVoiceInput;

@end
