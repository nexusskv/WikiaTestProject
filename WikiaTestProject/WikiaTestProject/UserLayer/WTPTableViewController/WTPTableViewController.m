//
//  WTPTableViewController.m
//  WikiaTestProject
//
//  Created by rost on 10.12.14.
//  Copyright (c) 2014 Rost. All rights reserved.
//

#import "WTPTableViewController.h"
#import "WTPDataLoader.h"
#import "CustomLinksCell.h"
#import "Constants.h"
#import "WTPDetailsViewController.h"


@interface WTPTableViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray *linksArray;
@property (nonatomic, strong) UITableView *linksListTable;
@property (nonatomic, assign) NSUInteger nextValue;
@property (nonatomic, assign) NSUInteger totalValue;
@property (nonatomic, assign) NSUInteger batchValue;
@end


@implementation WTPTableViewController

#pragma mark - Constructor
- (id)init {
    self = [super init];
    
    if (self) {
        self.batchValue = 1;
        [self getItems];
    }
    return self;
}
#pragma mark -


#pragma mark - View life cycle
- (void)loadView {
    [super loadView];
    
    self.title = @"Gaming Hub";
    
    self.linksListTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.linksListTable.delegate = self;
    self.linksListTable.dataSource = self;
    
    self.linksListTable.backgroundColor = [UIColor whiteColor];
    self.linksListTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.linksListTable.contentInset = UIEdgeInsetsMake(5.0f, 0.0f, 6.0f, 0.0f);
    [self.view addSubview:self.linksListTable];

    self.linksListTable.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = @{@"tableView"   : self.linksListTable};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|"
                                                                      options:0
                                                                      metrics:nil                                                                        views:views]];
}
#pragma mark -


#pragma mark - getItems
- (void)getItems {
    WTPDataLoader *dataLoader = [[WTPDataLoader alloc] initWithCallback:^(id resultObject) {
        if (resultObject[@"items"]) {
            if ([(NSArray *)resultObject[@"items"] count] > 0) {
                if ([self.linksArray count] > 0) {
                    NSMutableArray *newLinksArray = [NSMutableArray arrayWithArray:self.linksArray];
                    [newLinksArray addObjectsFromArray:(NSArray *)resultObject[@"items"]];
                    self.linksArray = newLinksArray;
                } else
                    self.linksArray = [NSArray arrayWithArray:resultObject[@"items"]];
                
                [self.linksListTable reloadData];
                
                if (([resultObject[@"total"] intValue] > 0) && ([resultObject[@"total"] intValue] > self.totalValue))
                    self.totalValue = [resultObject[@"total"] intValue];
                
                self.nextValue = self.batchValue * kLimitValue;
                self.batchValue++;
            }
        }
    }];

    [dataLoader loadDataByPage:self.batchValue];
}
#pragma mark -


#pragma mark - UITableViewDatasource methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.linksArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    CustomLinksCell *cell = (CustomLinksCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[CustomLinksCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell setWikiImage:self.linksArray[indexPath.row][@"image"]];
        [cell setWikiTitle:self.linksArray[indexPath.row][@"title"]];
        [cell setWikiLink:self.linksArray[indexPath.row][@"url"]];
    }
    
    if (self.nextValue < self.totalValue)
        if (indexPath.row == [self.linksArray count] - 15)
            [self getItems];
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
#pragma mark -


#pragma mark - UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.linksArray[indexPath.row][@"url"]) {
        WTPDetailsViewController *detailsVC = [[WTPDetailsViewController alloc] init];
        detailsVC.urlString = self.linksArray[indexPath.row][@"url"];
        if (self.linksArray[indexPath.row][@"title"])
            detailsVC.titleString = self.linksArray[indexPath.row][@"title"];
        [self.navigationController pushViewController:detailsVC animated:NO];
    }
}
#pragma mark -


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];    
    self.linksArray = nil;
}

@end
