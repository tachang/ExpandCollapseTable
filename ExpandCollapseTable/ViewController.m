//
//  ViewController.m
//  ExpandCollapseTable
//
//  Created by Jeff Tchang on 8/17/18.
//  Copyright © 2018 Jeff Tchang. All rights reserved.
//

#import "ViewController.h"

const int NUM_SECTIONS = 10;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.expandedSections = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < NUM_SECTIONS; i++) {
        [self.expandedSections addObject:@(0)];
    }
    
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    NSInteger section = recognizer.view.tag;
    
    NSMutableArray *arrayOfIndexPaths = [NSMutableArray array];
    for (int i=0; i < 5; i++) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:section];
        [arrayOfIndexPaths addObject:index];
    }
    
    
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:NSNotFound inSection:section] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];


    if (self.expandedSections[section] == [NSNumber numberWithInt:0]) {
        self.expandedSections[section] = @(1);
        
        
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:arrayOfIndexPaths withRowAnimation: UITableViewRowAnimationFade];
        [self.tableView endUpdates];
        
    }
    else {
        self.expandedSections[section] = @(0);
        
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:arrayOfIndexPaths withRowAnimation: UITableViewRowAnimationFade];
        [self.tableView endUpdates];
        
    }

    NSLog(@"Header tapped: %ld", (long)section);
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return NUM_SECTIONS;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.expandedSections[section] == [NSNumber numberWithInt:0]) {
        return 0;
    }
    else {
        return 5;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    headerView.tag = section;
    headerView.backgroundColor = [UIColor yellowColor];
    headerView.layer.borderWidth = 1;
    headerView.layer.borderColor = [[UIColor redColor] CGColor];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 320, 20)];
    label1.text = [NSString stringWithFormat:@"Header #%ld", section];
    [headerView addSubview:label1];
    

    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [headerView addGestureRecognizer:singleFingerTap];
    
    return headerView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    cell.textLabel.text = @"Hello Cell";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 43.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 28.0;
}

@end
