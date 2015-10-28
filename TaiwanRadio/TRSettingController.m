// TRSettingController.m
//
// Copyright (c) 2015年 Shinren Pan <shinren.pan@gmail.com>

#import "TRRadioPlayer.h"
#import "TRSettingController.h"

// TableView Section 類型
typedef NS_ENUM(NSUInteger, TableSectionType) {
    TableSectionTypePlayer = 0     // 播放 / 暫停的 section
};


@implementation TRSettingController

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
        
        self.view = nil;
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    if(indexPath.section == TableSectionTypePlayer)
    {
        NSString *title;
        
        switch ([TRRadioPlayer singleton].radioStatus)
        {
            case TRRaidoStatusPlaying:
                title = NSLocalizedString(@"Radio-Playing", nil);
                break;
        
            case TRRaidoStatusError:
                title = NSLocalizedString(@"Radio-Error", nil);
                break;
                
            case TRRaidoStatusBuffer:
                title = NSLocalizedString(@"Radio-Buffering", nil);
                break;
                
            case TRRaidoStatusPaused:
                title = NSLocalizedString(@"Radio-Paused", nil);
                break;
                
            default:
                title = NSLocalizedString(@"Radio-Unselected", nil);
                break;
        }
        
        NSString *subString       = [TRRadioPlayer singleton].radioTitle ? : @"";
        cell.textLabel.text       = title;
        cell.detailTextLabel.text = subString;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // Header 文字為白色
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    
    [header.textLabel setTextColor:[UIColor whiteColor]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == TableSectionTypePlayer)
    {
        if([TRRadioPlayer singleton].isPlaying)
        {
            [[TRRadioPlayer singleton]pause];
        }
        else
        {
            [[TRRadioPlayer singleton]resume];
        }
    }
}

#pragma mark - Private
- (void)__setup
{
    [[NSNotificationCenter defaultCenter]addObserver:self.tableView
                                            selector:@selector(reloadData)
                                                name:TRRaidoStatusChangedNotification
                                              object:nil];
    
    // 當從背景回到前景, User 可能在控制面板或是線控播放或暫停
    [[NSNotificationCenter defaultCenter]addObserver:self.tableView
                                            selector:@selector(reloadData)
                                                name:UIApplicationDidBecomeActiveNotification
                                              object:nil];
}

@end
