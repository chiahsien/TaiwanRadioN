// TRListViewController.m
//
// Copyright (c) 2015年 Shinren Pan <shinren.pan@gmail.com>

#import "TRRadioPlayer.h"
#import "TRFavoriteHandel.h"
#import "TRListViewController.h"

@interface TRListViewController ()

// 電台資料
@property (nonatomic, strong) NSArray *dataSource;

@end


@implementation TRListViewController

#pragma mark - LifeCycle
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self.tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if([self isViewLoaded] && !self.view.window)
    {
        [[NSNotificationCenter defaultCenter]removeObserver:self.tableView];
        
        _dataSource = nil;
        self.view   = nil;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self __setup];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *radio = _dataSource[indexPath.row];
    NSString *radioId   = radio[@"channel_id"];
    BOOL favorited      = [TRFavoriteHandel radioIdInFavorites:radioId];
    
    UITableViewCell *cell = ^{
        UITableViewCell *temp    = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        temp.imageView.tintColor = [UIColor whiteColor];
        temp.textLabel.text      = radio[@"channel_title"];
        temp.accessoryView       = [self __favoriteButtonHighlight:favorited atRow:indexPath.row];
        
        return temp;
    }();
    
    if([radioId isEqualToString:[TRRadioPlayer singleton].radioId])
    {
        cell.imageView.tintColor = [TRRadioPlayer singleton].statusColor;
        
        if([TRRadioPlayer singleton].radioStatus == TRRaidoStatusBuffer)
        {
            UIActivityIndicatorView *loading =
              [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:
               UIActivityIndicatorViewStyleWhite];
            
            [loading startAnimating];
            
            cell.accessoryView = loading;
        }
    }

    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TRRadioPlayer *radio         = [TRRadioPlayer singleton];
    NSDictionary *selected = _dataSource[indexPath.row];
    NSString *radioId      = selected[@"channel_id"];
    
    // 點到目前正在播放的電台
    if([radioId isEqualToString:radio.radioId] && radio.isPlaying)
    {
        [radio pause];
        
        return;
    }
    
    [TRRadioPlayer singleton].radioTitle = selected[@"channel_title"];
    [TRRadioPlayer singleton].radioId    = radioId;
}

#pragma mark - Private
- (void)__setup
{
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    [[NSNotificationCenter defaultCenter]addObserver:self.tableView
                                            selector:@selector(reloadData)
                                                name:TRRaidoStatusChangedNotification
                                              object:nil];
    
    // 當從背景回到前景, User 可能在控制面板或是線控播放或暫停
    [[NSNotificationCenter defaultCenter]addObserver:self.tableView
                                            selector:@selector(reloadData)
                                                name:UIApplicationDidBecomeActiveNotification
                                              object:nil];
    
    // 設置 _dataSource
    NSString *radioListPath = [[NSBundle mainBundle]pathForResource:@"RadioList" ofType:@"json"];
    
    NSString *radioListJSON = [NSString stringWithContentsOfFile:radioListPath
                                                        encoding:NSUTF8StringEncoding
                                                           error:nil];
    
    NSData *toData = [radioListJSON dataUsingEncoding:NSUTF8StringEncoding];
    
    id toArray = [NSJSONSerialization JSONObjectWithData:toData
                                                 options:NSJSONReadingAllowFragments
                                                   error:nil];
    
    if(![toArray isKindOfClass:[NSArray class]])
    {
        return;
    }
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"channel_title" ascending:YES];
    
    _dataSource = [toArray sortedArrayUsingDescriptors:@[sort]];
}

- (UIButton *)__favoriteButtonHighlight:(BOOL)flag atRow:(NSUInteger)row
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag       = row;
    button.frame     = CGRectMake(0, 0, 30, 30);
    button.tintColor = flag ? [UIColor magentaColor] : [UIColor whiteColor];
    
    [button setImage:[UIImage imageNamed:@"icon-tab2"] forState:UIControlStateNormal];
    
    [button addTarget:self
               action:@selector(__favoriteButtonClicked:)
     forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (void)__favoriteButtonClicked:(UIButton *)button
{
    NSUInteger row         = button.tag;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    NSDictionary *radio    = _dataSource[row];
    NSString *radioId      = radio[@"channel_id"];
    NSString *badgeValue;
    
    if([TRFavoriteHandel radioIdInFavorites:radioId])
    {
        [TRFavoriteHandel removeRadioIdFromFavorites:radioId];
        badgeValue = @"-1";
    }
    else
    {
        [TRFavoriteHandel addRadioIdToFavorites:radioId];
        badgeValue = @"+1";
    }
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationNone];
    
    // 設置 TRFavoriteController tabBarItem badgeValue
    UIViewController *favoriteController = self.tabBarController.viewControllers[1];
    favoriteController.tabBarItem.badgeValue = badgeValue;
}

@end
